`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Asynchronous FIFO
// Dual-clock FIFO using Gray-coded pointers and 2-flop synchronizers.
//
// Full  (write domain): wr_gray == {~rd_gray_sync[MSB:MSB-1], rd_gray_sync[MSB-2:0]}
// Empty (read  domain): rd_gray == wr_gray_sync
////////////////////////////////////////////////////////////////////////////////
module async_fifo #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4           // depth = 2^ADDR_WIDTH
) (
    input  wire                  wr_clk,
    input  wire                  wr_rst_n,
    input  wire                  wr_en,
    input  wire [DATA_WIDTH-1:0] wr_data,
    output wire                  full,
    output wire                  wr_almost_full,

    input  wire                  rd_clk,
    input  wire                  rd_rst_n,
    input  wire                  rd_en,
    output wire [DATA_WIDTH-1:0] rd_data,
    output wire                  empty,
    output wire                  rd_almost_empty
);

    localparam DEPTH = 1 << ADDR_WIDTH;
    localparam PTR_WIDTH = ADDR_WIDTH + 1;   // extra MSB for wrap / full detect

    wire [PTR_WIDTH-1:0] wr_ptr_bin;
    wire [PTR_WIDTH-1:0] wr_ptr_gray;
    wire [PTR_WIDTH-1:0] rd_ptr_bin;
    wire [PTR_WIDTH-1:0] rd_ptr_gray;
    wire [PTR_WIDTH-1:0] wr_ptr_gray_sync;   // wr gray in rd clock
    wire [PTR_WIDTH-1:0] rd_ptr_gray_sync;   // rd gray in wr clock

    wire wr_push = wr_en && !full;
    wire rd_pop  = rd_en && !empty;

    // Dual-port RAM: write on wr_clk, read on rd_clk
    async_fifo_mem #(
        .DATA_WIDTH (DATA_WIDTH),
        .ADDR_WIDTH (ADDR_WIDTH)
    ) u_mem (
        .wr_clk  (wr_clk),
        .wr_en   (wr_push),
        .wr_addr (wr_ptr_bin[ADDR_WIDTH-1:0]),
        .wr_data (wr_data),
        .rd_clk  (rd_clk),
        .rd_en   (rd_pop),
        .rd_addr (rd_ptr_bin[ADDR_WIDTH-1:0]),
        .rd_data (rd_data)
    );

    fifo_ptr_gen #(
        .PTR_WIDTH (PTR_WIDTH)
    ) u_wr_ptr (
        .clk     (wr_clk),
        .rst_n   (wr_rst_n),
        .inc     (wr_push),
        .ptr_bin (wr_ptr_bin),
        .ptr_gray(wr_ptr_gray)
    );

    fifo_ptr_gen #(
        .PTR_WIDTH (PTR_WIDTH)
    ) u_rd_ptr (
        .clk     (rd_clk),
        .rst_n   (rd_rst_n),
        .inc     (rd_pop),
        .ptr_bin (rd_ptr_bin),
        .ptr_gray(rd_ptr_gray)
    );

    gray_sync #(
        .WIDTH (PTR_WIDTH)
    ) u_rd2wr_sync (
        .dst_clk (wr_clk),
        .dst_rst_n (wr_rst_n),
        .src_gray  (rd_ptr_gray),
        .dst_gray  (rd_ptr_gray_sync)
    );

    gray_sync #(
        .WIDTH (PTR_WIDTH)
    ) u_wr2rd_sync (
        .dst_clk (rd_clk),
        .dst_rst_n (rd_rst_n),
        .src_gray  (wr_ptr_gray),
        .dst_gray  (wr_ptr_gray_sync)
    );

    // Full: extra MSB inverted vs synchronized read Gray, remaining bits equal
    assign full = (wr_ptr_gray == {~rd_ptr_gray_sync[PTR_WIDTH-1:PTR_WIDTH-2],
                                    rd_ptr_gray_sync[PTR_WIDTH-3:0]});

    // Empty: Gray pointers match after write pointer is synchronized into read domain
    assign empty = (rd_ptr_gray == wr_ptr_gray_sync);

    // Occupancy from Gray pointers (write domain / read domain)
    wire [PTR_WIDTH-1:0] rd_bin_in_wr = gray2bin(rd_ptr_gray_sync);
    wire [PTR_WIDTH-1:0] wr_bin_in_rd = gray2bin(wr_ptr_gray_sync);
    wire [PTR_WIDTH-1:0] wr_used = wr_ptr_bin - rd_bin_in_wr;
    wire [PTR_WIDTH-1:0] rd_used = wr_bin_in_rd - rd_ptr_bin;

    assign wr_almost_full  = (wr_used >= (DEPTH - 1));
    assign rd_almost_empty = (rd_used <= 1);

    function automatic [PTR_WIDTH-1:0] gray2bin;
        input [PTR_WIDTH-1:0] gray;
        integer i;
        begin
            gray2bin[PTR_WIDTH-1] = gray[PTR_WIDTH-1];
            for (i = PTR_WIDTH-2; i >= 0; i = i - 1)
                gray2bin[i] = gray2bin[i+1] ^ gray[i];
        end
    endfunction

endmodule
