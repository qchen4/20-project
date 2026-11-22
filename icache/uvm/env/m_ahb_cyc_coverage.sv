// 文件说明 m_ahb_cyc_coverage.sv
// 对 CPU 侧 Master 接口逐周期采样的补充覆盖 program。
// 记录 IDLE/NONSEQ 转换、读写及地址极值，与事务级覆盖互补。
// 这里按周期采样，部分覆盖未使用 HREADY 门控，因此样本数不等于完成事务数。

`include "sim_define.v"

program automatic m_ahb_cyc_coverage(yuu_ahb_master_interface ahb_io);

covergroup cover_cyc;
    option.per_instance = 1;
    
    rw:     coverpoint ahb_io.hwrite iff(ahb_io.hreset_n && (ahb_io.htrans == NONSEQ)); 
    addr:   coverpoint ahb_io.haddr  iff(ahb_io.hreset_n && (ahb_io.htrans == NONSEQ)) {
        bins    addr_min = {0};
        bins    addr_amx = {32'hffff_ffff};
    }
    
    rw_addr: cross rw, addr;

    htrans: coverpoint ahb_io.htrans iff(ahb_io.hreset_n) {
        bins    idle    = {IDLE};
        bins    nonseq  = {NONSEQ};
    }

    htrans_trans: coverpoint ahb_io.htrans iff(ahb_io.hreset_n) {
        bins    trans[] = (IDLE, NONSEQ => IDLE, NONSEQ);
    }
endgroup

initial begin
    cover_cyc   cov;
    cov = new();
    forever begin
        ahb_io.wait_cycle();
        cov.sample();
    end
    
end

endprogram : m_ahb_cyc_coverage

