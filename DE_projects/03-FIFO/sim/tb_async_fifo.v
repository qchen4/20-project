`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Async FIFO testbench:
//   1) fill until full
//   2) drain until empty
//   3) concurrent write/read with different clocks
////////////////////////////////////////////////////////////////////////////////
module tb_async_fifo;

    localparam DATA_WIDTH = 8;
    localparam ADDR_WIDTH = 4;
    localparam DEPTH      = 1 << ADDR_WIDTH;

    reg                  wr_clk;
    reg                  wr_rst_n;
    reg                  wr_en;
    reg  [DATA_WIDTH-1:0] wr_data;
    wire                 full;
    wire                 wr_almost_full;

    reg                  rd_clk;
    reg                  rd_rst_n;
    reg                  rd_en;
    wire [DATA_WIDTH-1:0] rd_data;
    wire                 empty;
    wire                 rd_almost_empty;

    integer wr_count;
    integer rd_count;
    integer error_count;
    integer i;
    reg [DATA_WIDTH-1:0] expected [0:1023];

    async_fifo #(
        .DATA_WIDTH (DATA_WIDTH),
        .ADDR_WIDTH (ADDR_WIDTH)
    ) dut (
        .wr_clk          (wr_clk),
        .wr_rst_n        (wr_rst_n),
        .wr_en           (wr_en),
        .wr_data         (wr_data),
        .full            (full),
        .wr_almost_full  (wr_almost_full),
        .rd_clk          (rd_clk),
        .rd_rst_n        (rd_rst_n),
        .rd_en           (rd_en),
        .rd_data         (rd_data),
        .empty           (empty),
        .rd_almost_empty (rd_almost_empty)
    );

    initial begin
        wr_clk = 1'b0;
        forever #5 wr_clk = ~wr_clk;     // 100 MHz
    end

    initial begin
        rd_clk = 1'b0;
        forever #7 rd_clk = ~rd_clk;     // ~71 MHz
    end

    task automatic wr_reset;
        begin
            wr_en   = 1'b0;
            wr_data = {DATA_WIDTH{1'b0}};
            wr_rst_n = 1'b0;
            repeat (4) @(posedge wr_clk);
            wr_rst_n = 1'b1;
            @(posedge wr_clk);
        end
    endtask

    task automatic rd_reset;
        begin
            rd_en    = 1'b0;
            rd_rst_n = 1'b0;
            repeat (4) @(posedge rd_clk);
            rd_rst_n = 1'b1;
            @(posedge rd_clk);
        end
    endtask

    task automatic write_word(input [DATA_WIDTH-1:0] data);
        begin
            @(posedge wr_clk);
            while (full) @(posedge wr_clk);
            wr_en   <= 1'b1;
            wr_data <= data;
            expected[wr_count] = data;
            wr_count = wr_count + 1;
            @(posedge wr_clk);
            wr_en <= 1'b0;
        end
    endtask

    task automatic read_word;
        begin
            @(posedge rd_clk);
            while (empty) @(posedge rd_clk);
            rd_en <= 1'b1;
            @(posedge rd_clk);
            rd_en <= 1'b0;
            @(posedge rd_clk);   // registered RAM: data valid next cycle
            if (rd_data !== expected[rd_count]) begin
                $display("[%0t] MISMATCH rd=%0d exp=%0h got=%0h",
                         $time, rd_count, expected[rd_count], rd_data);
                error_count = error_count + 1;
            end
            rd_count = rd_count + 1;
        end
    endtask

    initial begin
        wr_count    = 0;
        rd_count    = 0;
        error_count = 0;
        wr_en       = 1'b0;
        rd_en       = 1'b0;
        wr_data     = 0;
        wr_rst_n    = 1'b0;
        rd_rst_n    = 1'b0;

        fork
            wr_reset();
            rd_reset();
        join

        $display("=== Test 1: fill until full ===");
        for (i = 0; i < DEPTH; i = i + 1)
            write_word(8'hA0 + i[7:0]);

        @(posedge wr_clk);
        if (!full) begin
            $display("ERROR: FIFO should be full after %0d writes", DEPTH);
            error_count = error_count + 1;
        end else
            $display("PASS: full asserted after %0d writes", DEPTH);

        $display("=== Test 2: drain until empty ===");
        for (i = 0; i < DEPTH; i = i + 1)
            read_word();

        repeat (4) @(posedge rd_clk);
        if (!empty) begin
            $display("ERROR: FIFO should be empty after drain");
            error_count = error_count + 1;
        end else
            $display("PASS: empty asserted after drain");

        $display("=== Test 3: concurrent write/read ===");
        fork
            begin
                for (i = 0; i < 64; i = i + 1)
                    write_word(8'h10 + i[7:0]);
            end
            begin
                for (i = 0; i < 64; i = i + 1)
                    read_word();
            end
        join

        repeat (8) @(posedge rd_clk);

        if (error_count == 0)
            $display("=== ALL TESTS PASSED (%0d writes, %0d reads) ===", wr_count, rd_count);
        else
            $display("=== FAILED with %0d errors ===", error_count);

        $finish;
    end

    initial begin
        #200000;
        $display("TIMEOUT");
        $finish;
    end

endmodule
