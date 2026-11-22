// Module-local experimental watchdog bounds, not a product latency promise.
// <=40 divisions, 3*(64 variance + 27 search squares + 1 rounding square
// + 4 quality) + 5 standardization + 10 regression = 303 products.
// 58/8 clocks per division/product include controller handshakes. The
// remaining budget covers sum/variance loops, sqrt control and finalization.
    localparam integer MEASUREMENT_LATENCY_BOUND=40*58+303*8+3*(2*64+32+8)+5*64+128;
// 305 synchronous reads per pass, <=311 divisions and <=3*305+4
// guarded products. Eight cycles per product include controller handshakes;
// six cycles per stored point cover reads, scan/integral control and updates.
    localparam integer BEAT_LATENCY_BOUND=(304+7)*58+(3*(304+1)+4)*8+6*(304+1)+128;
    localparam integer CHANNEL_LATENCY_BOUND=BEAT_LATENCY_BOUND+64;
    localparam integer SINGLE_LATENCY_BOUND=MEASUREMENT_LATENCY_BOUND+CHANNEL_LATENCY_BOUND+128;
    localparam integer SYSTEM_LATENCY_BOUND=MEASUREMENT_LATENCY_BOUND+3*CHANNEL_LATENCY_BOUND+128;
