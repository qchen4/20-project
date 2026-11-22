`timescale 1ns/1ps
`default_nettype none
module tb_bppe_measurement;
`include "measurement_tb_ports.svh"
    string filename;
    integer fd,got,i,j,k,n,cases=0,valid_cases=0,blocked=0,max_latency=0,latency;
    logic [63:0] words[0:87],raw_beats[0:2][0:63][0:4];
    logic [1023:0] saved_packet;
    task automatic compare;
        begin
            if(!out_valid || out_tag!==words[0][31:0] || has_features!==words[69][0] || sqi!==words[75][7:0] ||
                reason_flags!==words[79][15:0] || result_valid!==words[80][0] ||
                $signed(pressure_raw[0])!=$signed(words[81]) || $signed(pressure_raw[1])!=$signed(words[82]) ||
                pressure_codes[0]!==words[83][15:0] || pressure_codes[1]!==words[84][15:0] ||
                saturation_count!==words[85] || divzero_count!==words[86] || precision_count!==words[87])
                $fatal(1,"Measurement output mismatch profile=%0d case=%0d reasons got=%0d expected=%0d faults=%0d/%0d/%0d",PROFILE,words[0],reason_flags,words[79],saturation_count,divzero_count,precision_count);
            for(integer x=0;x<5;x=x+1) if($signed(features[x])!=$signed(words[70+x])) $fatal(1,"Mean feature mismatch case=%0d index=%0d",words[0],x);
            for(integer x=0;x<3;x=x+1) if(channel_sqi[x]!==words[76+x][7:0]) $fatal(1,"Channel SQI mismatch case=%0d channel=%0d",words[0],x);
        end
    endtask
    initial begin
        if(!$value$plusargs("VECTORS=%s",filename)) $fatal(1,"Missing measurement vectors");
        fd=$fopen(filename,"r");if(fd==0) $fatal(1,"Cannot open measurement vectors");
        repeat(2) @(negedge clk);rst=0;
        while(!$feof(fd)) begin
            got=$fscanf(fd,"%h",words[0]);
            if(got==1) begin
                for(i=1;i<88;i=i+1) begin got=$fscanf(fd,"%h",words[i]);if(got!=1) $fatal(1,"Truncated measurement record");end
                if(words[3]<1 || words[3]>3 || words[4]>=words[3] || words[5]<1 || words[5]>64) $fatal(1,"Invalid measurement vector shape");
                for(i=0;i<3;i=i+1) begin
                    n=integer'(words[60+i]);if(n>64) $fatal(1,"Invalid beat count");
                    for(j=0;j<64;j=j+1) for(k=0;k<5;k=k+1) raw_beats[i][j][k]=0;
                    if(i<words[3]) for(j=0;j<n;j=j+1) for(k=0;k<5;k=k+1) begin
                        got=$fscanf(fd,"%h",raw_beats[i][j][k]);if(got!=1) $fatal(1,"Truncated beat matrix");
                    end
                end
                if(words[1]==FF && words[2]==RF) begin
                    // Each CSV case owns an independent MATLAB math handle.
                    @(negedge clk);rst=1;@(negedge clk);rst=0;
                    in_tag=words[0][31:0];in_channels=words[3][1:0];in_primary=words[4][1:0];in_beats_required=words[5][6:0];
                    in_min_amplitude=words[6][FW-1:0];in_max_amplitude=words[7][FW-1:0];in_max_cv=words[8][FW-1:0];in_sqi_threshold=words[9][7:0];
                    in_configured=words[10][0];in_calibrated=words[11][0];in_demo_only=words[12][0];in_allow_demo=words[13][0];
                    for(i=0;i<5;i=i+1) begin
                        in_center[i]=words[14+i][FW-1:0];in_scale[i]=words[19+i][FW-1:0];
                        in_min_enabled[i]=words[36+i][0];in_feature_min[i]=words[41+i][FW-1:0];
                        in_max_enabled[i]=words[46+i][0];in_feature_max[i]=words[51+i][FW-1:0];
                    end
                    for(i=0;i<6;i=i+1) for(j=0;j<2;j=j+1) in_beta[i][j]=words[24+2*i+j][BW-1:0];
                    for(i=0;i<2;i=i+1) begin in_bp_min[i]=words[56+i][AW-1:0];in_bp_max[i]=words[58+i][AW-1:0];end
                    for(i=0;i<3;i=i+1) begin
                        in_counts[i]=words[60+i][6:0];in_rejected[i]=words[63+i];
                        for(j=0;j<64;j=j+1) for(k=0;k<5;k=k+1) in_beats[i][j][k]=raw_beats[i][j][k][FW-1:0];
                    end
                    in_saturations=words[66];in_divzero=words[67];in_precision=words[68];
                    in_valid=1;out_ready=0;do @(posedge clk);while(!in_ready);
                    @(negedge clk);in_valid=1; // A blocked extra request must not be accepted.
                    in_tag='1;in_channels=0;in_saturations=64'd77;in_divzero=64'd88;in_precision=64'd99;
                    for(i=0;i<3;i=i+1) begin
                        in_counts[i]=0;in_rejected[i]='1;
                        for(j=0;j<64;j=j+1) for(k=0;k<5;k=k+1) in_beats[i][j][k]=0;
                    end
                    for(i=0;i<5;i=i+1) begin in_center[i]=0;in_scale[i]=0;in_feature_min[i]=0;in_feature_max[i]=0;end
                    for(i=0;i<6;i=i+1) for(j=0;j<2;j=j+1) in_beta[i][j]=0;
                    in_configured=0;in_min_enabled=0;in_max_enabled=0;
                    latency=0;
                    while(!out_valid) begin
                        @(negedge clk);latency=latency+1;
                        if(in_ready || latency>MEASUREMENT_LATENCY_BOUND) $fatal(1,"Measurement busy/latency failure");
                    end
                    if(latency>max_latency) max_latency=latency;
                    compare();saved_packet=packet();
                    repeat(3) begin @(negedge clk);if(in_ready || !out_valid || packet()!==saved_packet) $fatal(1,"Blocked measurement changed");compare();blocked=blocked+1;end
                    in_valid=0;out_ready=1;@(negedge clk);out_ready=0;
                    if(out_valid) $fatal(1,"Measurement output duplicated");
                    cases=cases+1;if(words[80]!=0) valid_cases=valid_cases+1;
                end
            end else if(!$feof(fd)) $fatal(1,"Malformed measurement vectors");
        end
        $fclose(fd);
        if(cases!=96 || valid_cases==0 || blocked!=288) $fatal(1,"Incomplete measurement suite");
        $display("RTL_MEASUREMENT_PASSED profile=%0d cases=%0d valid=%0d blocked=%0d max_latency=%0d",PROFILE,cases,valid_cases,blocked,max_latency);$finish;
    end
    initial begin #100000000;$fatal(1,"Measurement global watchdog");end
endmodule
`default_nettype wire
