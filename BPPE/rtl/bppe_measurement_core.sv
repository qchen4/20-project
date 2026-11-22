`timescale 1ns / 1ps
`default_nettype none
// Snapshot evaluator only: no acquisition/window timeout, CSR, IRQ or ACK.
// Rounded divisions and guarded products each share one scheduled unit.
// Request snapshots and completed arithmetic/fault ordering are preserved.
module bppe_measurement_core #(
    parameter integer FEATURE_F = 16,
    REGRESSION_F = 16,
    parameter integer FEATURE_W = 4 + FEATURE_F,
    BETA_W = 10 + REGRESSION_F,
    ACC_W = 20 + REGRESSION_F
) (
    input wire clk,
    rst,
    in_valid,
    output wire in_ready,
    input wire [31:0] in_tag,
    input wire [1:0] in_channels,
    in_primary,
    input wire [6:0] in_beats_required,
    in_counts[0:2],
    input wire signed [FEATURE_W-1:0] in_beats[0:2][0:63][0:4],
    input wire [63:0] in_rejected[0:2],
    input wire signed [FEATURE_W-1:0] in_min_amplitude,
    in_max_amplitude,
    in_max_cv,
    input wire [7:0] in_sqi_threshold,
    input wire in_configured,
    in_calibrated,
    in_demo_only,
    in_allow_demo,
    input wire signed [FEATURE_W-1:0] in_center[0:4],
    in_scale[0:4],
    input wire signed [BETA_W-1:0] in_beta[0:5][0:1],
    input wire [4:0] in_min_enabled,
    in_max_enabled,
    input wire signed [FEATURE_W-1:0] in_feature_min[0:4],
    in_feature_max[0:4],
    input wire signed [ACC_W-1:0] in_bp_min[0:1],
    in_bp_max[0:1],
    input wire [63:0] in_saturations,
    in_divzero,
    in_precision,
    output logic out_valid,
    input wire out_ready,
    output logic [31:0] out_tag,
    output logic has_features,
    result_valid,
    output logic signed [FEATURE_W-1:0] features[0:4],
    output logic [7:0] sqi,
    channel_sqi[0:2],
    output logic [15:0] reason_flags,
    output logic signed [ACC_W-1:0] pressure_raw[0:1],
    output logic [15:0] pressure_codes[0:1],
    output logic [63:0] saturation_count,
    divzero_count,
    precision_count
);
  localparam [63:0] LIMIT = 64'd9007199254740991;
  localparam signed [63:0] ONE = 64'sd1 << FEATURE_F, REG_ONE = 64'sd1 << REGRESSION_F;
  typedef enum logic [5:0] {
    IDLE,
    CHANNEL,
    PERIOD_SUM,
    VARIANCE,
    SQRT_INIT,
    SQRT_SEARCH,
    QUALITY,
    QUALITY_FINAL,
    MEAN_SUM,
    MODEL_GATE,
    STANDARDIZE,
    REGRESSION,
    BOUNDS,
    ENCODE,
    AVERAGE_DONE,
    SQRT_DIV_DONE,
    CV_DONE,
    REGULARITY_DONE,
    CLEAN_DONE,
    QUALITY_DONE,
    MEAN_DONE,
    STANDARD_DONE,
    REGRESSION_DONE,
    CODE0_DONE,
    CODE1_DONE,
    DIV_REQUEST,
    DIV_WAIT,
    MUL_REQUEST,
    MUL_WAIT,
    VARIANCE_DONE,
    CV_PRODUCT,
    REGULARITY_PRODUCT,
    CLEAN_FIRST_DONE,
    CLEAN_SECOND_DONE,
    STANDARD_PRODUCT,
    REGRESSION_PRODUCT,
    SQRT_MID_DONE,
    SQRT_ROUND_DONE
  } phase_t;
  phase_t phase, continuation;
  logic signed [63:0] div_numerator, div_denominator, div_result;
  wire divider_ready, divider_valid, divider_zero, divider_precision;
  wire signed [63:0] divider_result;
  bppe_rounded_divider divider (
      .clk(clk),
      .rst(rst),
      .in_valid(phase == DIV_REQUEST),
      .in_ready(divider_ready),
      .in_numerator(div_numerator),
      .in_denominator(div_denominator),
      .out_valid(divider_valid),
      .out_ready(phase == DIV_WAIT),
      .out_quotient(divider_result),
      .out_divzero(divider_zero),
      .out_precision(divider_precision)
  );
  task automatic start_div(input logic signed [63:0] numerator, denominator, input phase_t resume);
    begin
      div_numerator <= numerator;
      div_denominator <= denominator;
      continuation <= resume;
      phase <= DIV_REQUEST;
    end
  endtask
  phase_t multiply_resume;
  logic signed [63:0] multiply_x, multiply_y, multiply_result;
  wire multiply_ready, multiply_valid, multiply_precision;
  wire signed [63:0] multiply_value;
  bppe_guarded_multiplier multiplier (
      .clk(clk),
      .rst(rst),
      .in_valid(phase == MUL_REQUEST),
      .in_ready(multiply_ready),
      .in_x(multiply_x),
      .in_y(multiply_y),
      .out_valid(multiply_valid),
      .out_ready(phase == MUL_WAIT),
      .out_product(multiply_value),
      .out_precision(multiply_precision)
  );
  task automatic start_mul(input logic signed [63:0] x, y, input phase_t resume);
    begin
      multiply_x <= x;
      multiply_y <= y;
      multiply_resume <= resume;
      phase <= MUL_REQUEST;
    end
  endtask
  logic [63:0] sqrt_mid;
  logic [1:0] channels, primary;
  logic [6:0] required_beats, counts[0:2];
  logic signed [FEATURE_W-1:0] beats[0:2][0:63][0:4];
  logic [63:0] rejected[0:2];
  logic signed [63:0] min_amplitude, max_amplitude, max_cv;
  logic [7:0] sqi_threshold;
  logic model_ok;
  logic signed [63:0]
      center[0:4],
      scale[0:4],
      beta[0:5][0:1],
      feature_min[0:4],
      feature_max[0:4],
      bp_min[0:1],
      bp_max[0:1];
  logic [4:0] min_enabled, max_enabled;
  integer channel, index, feature_index, output_index, i, j, k;
  logic signed [63:0]
      sum, average, variance_sum, deviation, quality[0:2], z[0:4], accumulator, prediction[0:1];
  logic amplitude_ok;
  logic [63:0] sqrt_n, sqrt_lo, sqrt_hi;
  logic [63:0] sat_work, div_work, precision_work, mid;
  logic signed [63:0] a, b, c, d, cv, regularity, clean, raw_sqi, next_sum, code0, code1;
  logic envelope_ok;
  logic [15:0] final_reasons;

  function automatic [63:0] mag(input logic signed [63:0] x);
    mag = x[63] ? (~$unsigned(x) + 64'd1) : $unsigned(x);
  endfunction
  function automatic signed [63:0] addq(input logic signed [63:0] x, y, inout logic [63:0] faults);
    begin
      if ({1'b0, mag(x)} + {1'b0, mag(y)} > {1'b0, LIMIT}) begin
        faults = faults + 1'b1;
        addq   = 0;
      end else addq = x + y;
    end
  endfunction
  function automatic signed [63:0] clipq(input logic signed [63:0] x, input integer width,
                                         inout logic [63:0] faults);
    logic signed [63:0] lo, hi;
    begin
      lo = -(64'sd1 << (width - 1));
      hi = (64'sd1 << (width - 1)) - 1;
      if (x < lo) begin
        faults = faults + 1'b1;
        clipq  = lo;
      end else if (x > hi) begin
        faults = faults + 1'b1;
        clipq  = hi;
      end else clipq = x;
    end
  endfunction
  function automatic signed [63:0] codeq(input logic signed [63:0] x, inout logic [63:0] faults);
    begin
      if (x < 0) begin
        faults = faults + 1'b1;
        codeq  = 0;
      end else if (x > 65535) begin
        faults = faults + 1'b1;
        codeq  = 65535;
      end else codeq = x;
    end
  endfunction
  function automatic [7:0] byteq(input logic signed [63:0] x);
    byteq = x < 0 ? 8'd0 : (x > 255 ? 8'd255 : x[7:0]);
  endfunction

  assign in_ready = !rst && phase == IDLE && (!out_valid || out_ready);
  always @(posedge clk) begin
    if (rst) begin
      multiply_resume <= IDLE;
      multiply_x <= 0;
      multiply_y <= 0;
      multiply_result <= 0;
      sqrt_mid <= 0;
      phase <= IDLE;
      continuation <= IDLE;
      div_numerator <= 0;
      div_denominator <= 0;
      div_result <= 0;
      out_valid <= 0;
      out_tag <= 0;
      has_features <= 0;
      result_valid <= 0;
      reason_flags <= 0;
      sqi <= 0;
      saturation_count <= 0;
      divzero_count <= 0;
      precision_count <= 0;
      for (i = 0; i < 5; i = i + 1) features[i] <= 0;
      for (i = 0; i < 3; i = i + 1) channel_sqi[i] <= 0;
      for (i = 0; i < 2; i = i + 1) begin
        pressure_raw[i]   <= 0;
        pressure_codes[i] <= 0;
      end
    end else begin
      sat_work = saturation_count;
      div_work = divzero_count;
      precision_work = precision_count;
      if (out_valid && out_ready) out_valid <= 0;
      case (phase)
        IDLE:
        if (in_valid && in_ready) begin
          out_valid <= 0;
          out_tag <= in_tag;
          has_features <= 0;
          result_valid <= 0;
          reason_flags <= 0;
          sqi <= 0;
          sat_work = in_saturations;
          div_work = in_divzero;
          precision_work = in_precision;
          channels <= in_channels;
          primary <= in_primary;
          required_beats <= in_beats_required;
          min_amplitude <= $signed(in_min_amplitude);
          max_amplitude <= $signed(in_max_amplitude);
          max_cv <= $signed(in_max_cv);
          sqi_threshold <= in_sqi_threshold;
          model_ok <= in_configured && in_calibrated && (!in_demo_only || in_allow_demo);
          min_enabled <= in_min_enabled;
          max_enabled <= in_max_enabled;
          for (i = 0; i < 3; i = i + 1) begin
            counts[i] <= in_counts[i];
            rejected[i] <= in_rejected[i];
            quality[i] <= 0;
            channel_sqi[i] <= 0;
            for (j = 0; j < 64; j = j + 1)
            for (k = 0; k < 5; k = k + 1) beats[i][j][k] <= in_beats[i][j][k];
          end
          for (i = 0; i < 5; i = i + 1) begin
            features[i] <= 0;
            center[i] <= $signed(in_center[i]);
            scale[i] <= $signed(in_scale[i]);
            feature_min[i] <= $signed(in_feature_min[i]);
            feature_max[i] <= $signed(in_feature_max[i]);
          end
          for (i = 0; i < 6; i = i + 1)
          for (j = 0; j < 2; j = j + 1) beta[i][j] <= $signed(in_beta[i][j]);
          for (i = 0; i < 2; i = i + 1) begin
            bp_min[i] <= $signed(in_bp_min[i]);
            bp_max[i] <= $signed(in_bp_max[i]);
            prediction[i] <= 0;
            pressure_raw[i] <= 0;
            pressure_codes[i] <= 0;
          end
          channel <= 0;
          phase   <= CHANNEL;
        end
        CHANNEL: begin
          if (channel >= channels) phase <= QUALITY_FINAL;
          else if (counts[channel] < required_beats) begin
            reason_flags <= reason_flags | 16'h0010;
            quality[channel] <= 0;
            channel <= channel + 1;
          end else begin
            index <= 0;
            sum <= 0;
            variance_sum <= 0;
            amplitude_ok <= 1;
            phase <= PERIOD_SUM;
          end
        end
        PERIOD_SUM: begin
          next_sum = sum + $signed(beats[channel][index][0]);
          sum <= next_sum;
          if (index + 1 == counts[channel]) begin
            start_div(next_sum, $signed({1'b0, counts[channel]}), AVERAGE_DONE);
          end else index <= index + 1;
        end
        AVERAGE_DONE: begin
          average <= div_result;
          index   <= 0;
          phase   <= VARIANCE;
        end
        VARIANCE: begin
          d = $signed(beats[channel][index][0]) - average;
          start_mul(d, d, VARIANCE_DONE);
        end
        VARIANCE_DONE: begin
          variance_sum <= addq(variance_sum, multiply_result, precision_work);
          if ($signed(
                  beats[channel][index][4]
              ) < min_amplitude || $signed(
                  beats[channel][index][4]
              ) > max_amplitude)
            amplitude_ok <= 0;
          if (index + 1 == counts[channel]) phase <= SQRT_INIT;
          else begin
            index <= index + 1;
            phase <= VARIANCE;
          end
        end
        SQRT_INIT: start_div(variance_sum, $signed({1'b0, counts[channel]}), SQRT_DIV_DONE);
        SQRT_DIV_DONE: begin
          a = div_result;
          if (a < 0 || $unsigned(a) > LIMIT) begin
            precision_work = precision_work + 1'b1;
            deviation <= 0;
            phase <= QUALITY;
          end else begin
            sqrt_n  <= $unsigned(a);
            sqrt_lo <= 0;
            sqrt_hi <= (a < 94906265) ? $unsigned(a) : 64'd94906265;
            phase   <= SQRT_SEARCH;
          end
        end
        SQRT_SEARCH: begin
          if (sqrt_lo < sqrt_hi) begin
            mid = (sqrt_lo + sqrt_hi + 1'b1) / 2;
            sqrt_mid <= mid;
            start_mul($signed(mid), $signed(mid), SQRT_MID_DONE);
          end else start_mul($signed(sqrt_lo), $signed(sqrt_lo), SQRT_ROUND_DONE);
        end
        SQRT_MID_DONE: begin
          if ($unsigned(multiply_result) <= sqrt_n) sqrt_lo <= sqrt_mid;
          else sqrt_hi <= sqrt_mid - 1'b1;
          phase <= SQRT_SEARCH;
        end
        SQRT_ROUND_DONE: begin
          deviation <= $signed(
              sqrt_lo + ((sqrt_n - $unsigned(multiply_result) >= sqrt_lo + 1'b1) ? 64'd1 : 64'd0)
          );
          phase <= QUALITY;
        end
        QUALITY: start_mul(deviation, ONE, CV_PRODUCT);
        CV_PRODUCT: start_div(multiply_result, average, CV_DONE);
        CV_DONE: begin
          cv = clipq(div_result, FEATURE_W, sat_work);
          start_mul(cv, ONE, REGULARITY_PRODUCT);
        end
        REGULARITY_PRODUCT: start_div(multiply_result, max_cv, REGULARITY_DONE);
        REGULARITY_DONE: begin
          regularity <= (ONE - div_result > 0) ? ONE - div_result : 64'sd0;
          a = $signed({1'b0, required_beats}) * ONE;
          b = $signed({1'b0, required_beats}) + $signed(rejected[channel]);
          start_div(a, b, CLEAN_DONE);
        end
        CLEAN_DONE: begin
          clean <= div_result;
          start_mul(amplitude_ok ? 64'sd255 : 64'sd0, regularity, CLEAN_FIRST_DONE);
        end
        CLEAN_FIRST_DONE: start_mul(multiply_result, clean, CLEAN_SECOND_DONE);
        CLEAN_SECOND_DONE: start_div(multiply_result, ONE * ONE, QUALITY_DONE);
        QUALITY_DONE: begin
          quality[channel] <= div_result;
          channel <= channel + 1;
          phase <= CHANNEL;
        end
        QUALITY_FINAL: begin
          raw_sqi = quality[0];
          for (i = 0; i < 3; i = i + 1)
          if (i < channels) begin
            channel_sqi[i] <= byteq(quality[i]);
            if (quality[i] < raw_sqi) raw_sqi = quality[i];
          end
          sqi <= byteq(raw_sqi);
          if (raw_sqi < $signed({1'b0, sqi_threshold})) reason_flags <= reason_flags | 16'h0001;
          if (counts[primary] >= required_beats) begin
            has_features <= 1;
            index <= 0;
            feature_index <= 0;
            sum <= 0;
            phase <= MEAN_SUM;
          end else phase <= MODEL_GATE;
        end
        MEAN_SUM: begin
          next_sum = sum + $signed(beats[primary][index][feature_index]);
          sum <= next_sum;
          if (index + 1 == counts[primary]) begin
            start_div(next_sum, $signed({1'b0, required_beats}), MEAN_DONE);
          end else index <= index + 1;
        end
        MEAN_DONE: begin
          features[feature_index] <= clipq(div_result, FEATURE_W, sat_work);
          if (feature_index == 4) phase <= MODEL_GATE;
          else begin
            feature_index <= feature_index + 1;
            index <= 0;
            sum <= 0;
            phase <= MEAN_SUM;
          end
        end
        MODEL_GATE: begin
          envelope_ok = 1;
          for (i = 0; i < 5; i = i + 1)
          if ((min_enabled[i] && $signed(
                  features[i]
              ) < feature_min[i]) || (max_enabled[i] && $signed(
                  features[i]
              ) > feature_max[i]))
            envelope_ok = 0;
          if (!model_ok) begin
            reason_flags <= reason_flags | 16'h0020;
            phase <= ENCODE;
          end else if (!has_features) phase <= ENCODE;
          else if (!envelope_ok) begin
            reason_flags <= reason_flags | 16'h0400;
            phase <= ENCODE;
          end else begin
            feature_index <= 0;
            phase <= STANDARDIZE;
          end
        end
        STANDARDIZE: begin
          start_mul($signed(features[feature_index]) - center[feature_index], REG_ONE,
                    STANDARD_PRODUCT);
        end
        STANDARD_PRODUCT: start_div(multiply_result, scale[feature_index], STANDARD_DONE);
        STANDARD_DONE: begin
          z[feature_index] <= clipq(div_result, 6 + REGRESSION_F, sat_work);
          if (feature_index == 4) begin
            index <= 0;
            output_index <= 0;
            accumulator <= beta[0][0];
            phase <= REGRESSION;
          end else begin
            feature_index <= feature_index + 1;
            phase <= STANDARDIZE;
          end
        end
        REGRESSION: begin
          start_mul(z[index], beta[index+1][output_index], REGRESSION_PRODUCT);
        end
        REGRESSION_PRODUCT: start_div(multiply_result, REG_ONE, REGRESSION_DONE);
        REGRESSION_DONE: begin
          c = addq(accumulator, div_result, precision_work);
          d = clipq(c, ACC_W, sat_work);
          accumulator <= d;
          if (index == 4) begin
            prediction[output_index] <= d;
            if (output_index == 1) phase <= BOUNDS;
            else begin
              output_index <= 1;
              index <= 0;
              accumulator <= beta[0][1];
              phase <= REGRESSION;
            end
          end else begin
            index <= index + 1;
            phase <= REGRESSION;
          end
        end
        BOUNDS: begin
          if(prediction[0]<bp_min[0] || prediction[0]>bp_max[0] || prediction[1]<bp_min[1] ||
                        prediction[1]>bp_max[1] || prediction[0]<=prediction[1])
            reason_flags <= reason_flags | 16'h0400;
          phase <= ENCODE;
        end
        ENCODE: start_div(prediction[0], 64'sd1 << (REGRESSION_F - 7), CODE0_DONE);
        CODE0_DONE: begin
          code0 <= codeq(div_result, sat_work);
          start_div(prediction[1], 64'sd1 << (REGRESSION_F - 7), CODE1_DONE);
        end
        CODE1_DONE: begin
          code1 = codeq(div_result, sat_work);
          final_reasons = reason_flags;
          if (sat_work != 0 || div_work != 0 || precision_work != 0)
            final_reasons = final_reasons | 16'h0040;
          if (div_work != 0) final_reasons = final_reasons | 16'h0080;
          reason_flags <= final_reasons;
          result_valid <= final_reasons == 0;
          if (final_reasons == 0) begin
            pressure_raw[0]   <= prediction[0][ACC_W-1:0];
            pressure_raw[1]   <= prediction[1][ACC_W-1:0];
            pressure_codes[0] <= code0[15:0];
            pressure_codes[1] <= code1[15:0];
          end
          out_valid <= 1;
          phase <= IDLE;
        end
        MUL_REQUEST: if (multiply_ready) phase <= MUL_WAIT;
        MUL_WAIT:
        if (multiply_valid) begin
          multiply_result <= multiply_value;
          precision_work = precision_work + {63'd0, multiply_precision};
          phase <= multiply_resume;
        end
        DIV_REQUEST: if (divider_ready) phase <= DIV_WAIT;
        DIV_WAIT:
        if (divider_valid) begin
          div_result <= divider_result;
          div_work = div_work + divider_zero;
          precision_work = precision_work + divider_precision;
          phase <= continuation;
        end
        default: phase <= IDLE;
      endcase
      saturation_count <= sat_work;
      divzero_count <= div_work;
      precision_count <= precision_work;
    end
  end
`ifndef SYNTHESIS
  // Search operands are bounded by floor(sqrt(2^53-1)); their product is
  // exactly in the healthy domain and must never introduce a new fault.
  always @(posedge clk)
    if(!rst && phase==MUL_WAIT && multiply_valid &&
        (multiply_resume==SQRT_MID_DONE || multiply_resume==SQRT_ROUND_DONE) && multiply_precision)
      $fatal(1, "Bounded square-root product escaped exact domain");
  initial
    if(!((FEATURE_F==8 || FEATURE_F==16 || FEATURE_F==18) && REGRESSION_F==FEATURE_F) ||
        FEATURE_W!=4+FEATURE_F || BETA_W!=10+REGRESSION_F || ACC_W!=20+REGRESSION_F)
      $fatal(1, "Unsupported measurement profile");
  always @(posedge clk)
    if (!rst && in_valid && in_ready) begin
      if(in_channels<1 || in_channels>3 || in_primary>=in_channels || in_beats_required<1 || in_beats_required>64)
        $fatal(1, "Invalid window snapshot configuration");
      if(in_saturations<saturation_count || in_divzero<divzero_count || in_precision<precision_count)
        $fatal(1, "Caller must carry numeric faults forward or reset the evaluator");
      for (integer ch = 0; ch < 3; ch = ch + 1)
      if (ch < in_channels && (in_counts[ch] > in_beats_required || in_rejected[ch] > LIMIT))
        $fatal(1, "Invalid bounded window snapshot");
    end
`endif
endmodule
`default_nettype wire
