// by a subsisting licensing agreement from SiliconThink.
//
//      (C) COPYRIGHT SiliconThink Limited or its affiliates
//                   ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from SiliconThink or its affiliates.
// ---------------------------------------------------------------------------//

//--- 1: each cfg_regs in cdma ---//

class reg_sar extends uvm_reg;

    `uvm_object_utils(reg_sar)

    rand uvm_reg_field  sar;

    function new(input string name="reg_sar");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction : new

    virtual function void build();
        sar = uvm_reg_field::type_id::create("sar");
        //configure field:parent, size, lsb, access, volatile, reset val, has_reset, is_rand, self_accessible
        sar.configure       (this, 32,    0,   "RW",  0,        32'h00,    1,         1,       1);
    endfunction : build
endclass : reg_sar


class reg_dar extends uvm_reg;

    `uvm_object_utils(reg_dar)

    rand uvm_reg_field  dar;

    function new(input string name="reg_dar");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction : new

    virtual function void build();
        dar = uvm_reg_field::type_id::create("dar");
        //configure field:parent, size, lsb, access, volatile, reset val, has_reset, is_rand, self_accessible
        dar.configure       (this, 32,    0,   "RW",  0,        32'h00,    1,         1,       1);
    endfunction : build
endclass : reg_dar


class reg_xsize extends uvm_reg;

    `uvm_object_utils(reg_xsize)

    rand uvm_reg_field  xsize;
         uvm_reg_field  unuse;

    function new(input string name="reg_xsize");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction : new

    virtual function void build();
        xsize = uvm_reg_field::type_id::create("xsize");
        unuse = uvm_reg_field::type_id::create("unuse");
        //configure field:parent, size, lsb, access, volatile, reset val, has_reset, is_rand, self_accessible
        xsize.configure     (this, 16,   0,   "RW",  0,        32'h00,    1,         1,       0);
        unuse.configure     (this, 16,   16,  "RO",  0,        32'h00,    1,         0,       0);
    endfunction : build
endclass : reg_xsize


class reg_ysize extends uvm_reg;

    `uvm_object_utils(reg_ysize)

    rand uvm_reg_field  ysize;
         uvm_reg_field  unuse;

    function new(input string name="reg_ysize");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction : new

    virtual function void build();
        ysize = uvm_reg_field::type_id::create("ysize");
        unuse = uvm_reg_field::type_id::create("unuse");
        //configure field:parent, size, lsb, access, volatile, reset val, has_reset, is_rand, self_accessible
        ysize.configure     (this, 16,   0,   "RW",  0,        32'h00,    1,         1,       0);
        unuse.configure     (this, 16,   16,  "RO",  0,        32'h00,    1,         0,       0);
    endfunction : build
endclass : reg_ysize


class reg_step extends uvm_reg;

    `uvm_object_utils(reg_step)

    rand uvm_reg_field  sa_ystep;
    rand uvm_reg_field  da_ystep;

    function new(input string name="reg_step");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction : new

    virtual function void build();
        sa_ystep = uvm_reg_field::type_id::create("sa_ystep");
        da_ystep = uvm_reg_field::type_id::create("da_ystep");
        //configure field:parent, size, lsb, access, volatile, reset val, has_reset, is_rand, self_accessible
        sa_ystep.configure  (this, 16,   0,   "RW",  0,        32'h00,    1,         1,       0);
        da_ystep.configure  (this, 16,   16,  "RW",  0,        32'h00,    1,         1,       0);
    endfunction : build
endclass : reg_step


class reg_llr extends uvm_reg;

    `uvm_object_utils(reg_llr)

    rand uvm_reg_field  llr;

    function new(input string name="reg_llr");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction : new

    virtual function void build();
        llr = uvm_reg_field::type_id::create("llr");
        //configure field:parent, size, lsb, access, volatile, reset val, has_reset, is_rand, self_accessible
        llr.configure       (this, 32,    0,   "RW",  0,        32'h00,    1,         1,       1);
    endfunction : build
endclass : reg_llr


class reg_status extends uvm_reg;
    `uvm_object_utils(reg_status)
         uvm_reg_field  end_flag;
         uvm_reg_field  dma_busy;
         uvm_reg_field  unuse0  ;
         uvm_reg_field  buf_err ;
         uvm_reg_field  unuse1  ;
         uvm_reg_field  cmd_num ;
         uvm_reg_field  unuse2  ;

    function new(input string name="reg_status");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction : new

    virtual function void build();
        end_flag    = uvm_reg_field::type_id::create("end_flag");
        dma_busy    = uvm_reg_field::type_id::create("dma_busy");
        unuse0      = uvm_reg_field::type_id::create("unuse0");
        buf_err     = uvm_reg_field::type_id::create("buf_err");
        unuse1      = uvm_reg_field::type_id::create("unuse1");
        cmd_num     = uvm_reg_field::type_id::create("cmd_num");
        unuse2      = uvm_reg_field::type_id::create("unuse2");

        //configure field:parent, size, lsb, access, volatile, reset val, has_reset, is_rand, self_accessible
        end_flag.configure(this,   1,    0,   "RO",   0,        32'h0,     1,         0,       0);
        dma_busy.configure(this,   1,    1,   "RO",   0,        32'h0,     1,         0,       0);
        unuse0.configure  (this,   2,    2,   "RO",   0,        32'h0,     1,         0,       0);
        buf_err.configure (this,   1,    4,   "RO",   0,        32'h0,     1,         0,       0);
        unuse1.configure  (this,   3,    5,   "RO",   0,        32'h0,     1,         0,       0);
        cmd_num.configure (this,   16,   8,   "RO",   0,        32'h0,     1,         0,       0);
        unuse2.configure  (this,   8,   24,   "RO",   0,        32'h0,     1,         0,       0);
    endfunction : build

endclass : reg_status



class reg_ctrl extends uvm_reg;
    `uvm_object_utils(reg_ctrl)
         uvm_reg_field  intr_en ;
         uvm_reg_field  unuse0  ;
         uvm_reg_field  dma_halt;
         uvm_reg_field  unuse1  ;
         uvm_reg_field  arcache ;
         uvm_reg_field  awcache ;
         uvm_reg_field  unuse2  ;

    function new(input string name="reg_ctrl");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction : new

    virtual function void build();
        intr_en    = uvm_reg_field::type_id::create("intr_en");
        unuse0      = uvm_reg_field::type_id::create("unuse0");
        dma_halt    = uvm_reg_field::type_id::create("dma_halt");
        unuse1      = uvm_reg_field::type_id::create("unuse1");
        arcache     = uvm_reg_field::type_id::create("arcache");
        awcache     = uvm_reg_field::type_id::create("awcache");
        unuse2      = uvm_reg_field::type_id::create("unuse2");

        //configure field:parent, size, lsb, access, volatile, reset val, has_reset, is_rand, self_accessible
        intr_en.configure (this,   1,    0,   "RW",   0,        32'h0,     1,         1,       0);
        unuse0.configure  (this,   3,    1,   "RO",   0,        32'h0,     1,         0,       0);
        dma_halt.configure(this,   1,    4,   "RW",   0,        32'h0,     1,         1,       0);
        unuse1.configure  (this,   3,    5,   "RO",   0,        32'h0,     1,         0,       0);
        arcache.configure (this,   4,    8,   "RW",   0,        32'h0,     1,         1,       0);
        awcache.configure (this,   4,   12,   "RW",   0,        32'h0,     1,         1,       0);
        unuse2.configure  (this,  16,   16,   "RO",   0,        32'h0,     1,         0,       0);
    endfunction : build

endclass : reg_ctrl




class reg_sof extends uvm_reg;
    `uvm_object_utils(reg_sof)

        uvm_reg_field  cdma_sof ;
        uvm_reg_field  unuse    ;

    function new(input string name="reg_sof");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction : new

    virtual function void build();
        cdma_sof= uvm_reg_field::type_id::create("cdma_sof");
        unuse   = uvm_reg_field::type_id::create("unuse");

        //configure field:parent, size, lsb, access, volatile, reset val, has_reset, is_rand, self_accessible
        cdma_sof.configure(this,   1,    0,   "RW",   1,        32'h0,     1,         1,       0);
        unuse.configure   (this,  31,    1,   "RO",   0,        32'h0,     1,         0,       0);
    endfunction : build

endclass : reg_sof


class reg_unuse_0x24 extends uvm_reg;
    `uvm_object_utils(reg_unuse_0x24)

    uvm_reg_field  unuse    ;

    function new(input string name="reg_unuse_0x24");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction : new

    virtual function void build();
        unuse   = uvm_reg_field::type_id::create("unuse");

        //configure field:parent, size, lsb, access, volatile, reset val, has_reset, is_rand, self_accessible
        unuse.configure   (this,  32,    0,   "RO",   0,        32'h0,     1,         0,       0);
    endfunction : build

endclass : reg_unuse_0x24


class reg_unuse_0x28 extends uvm_reg;
    `uvm_object_utils(reg_unuse_0x28)

    uvm_reg_field  unuse    ;

    function new(input string name="reg_unuse_0x28");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction : new

    virtual function void build();
        unuse   = uvm_reg_field::type_id::create("unuse");

        //configure field:parent, size, lsb, access, volatile, reset val, has_reset, is_rand, self_accessible
        unuse.configure   (this,  32,    0,   "RO",   0,        32'h0,     1,         0,       0);
    endfunction : build

endclass : reg_unuse_0x28


class reg_vid extends uvm_reg;
    `uvm_object_utils(reg_vid)

    uvm_reg_field  vid;

    function new(input string name="reg_vid");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction : new

    virtual function void build();
        vid   = uvm_reg_field::type_id::create("vid");

        //configure field:parent, size, lsb, access, volatile, reset val, has_reset, is_rand, self_accessible
        vid.configure     (this,  32,    0,   "RO",   0,        32'h5310,   1,         0,       0);
    endfunction : build

endclass : reg_vid


//--- 2: reg_model of cdma ---//
class cdma_reg_model extends uvm_reg_block;

    `uvm_object_utils(cdma_reg_model)

    rand reg_sar            sar     ;   //0x00
    rand reg_dar            dar     ;
    rand reg_xsize          xsize   ;
    rand reg_ysize          ysize   ;
    rand reg_step           step    ;   //0x10
    rand reg_llr            llr     ;
         reg_status         status  ;
    rand reg_ctrl           ctrl    ;   
         reg_sof            sof     ;   //0x20
         reg_unuse_0x24     unuse_0x24;
         reg_unuse_0x28     unuse_0x28;
         reg_vid            vid     ;


    function new(input string name="cdma_reg_model");
        super.new(name, UVM_NO_COVERAGE);
    endfunction

    virtual function void build();
        //              field:        name,     sys_base_addr, bus byte size, endian,           byte_accessible
        default_map = create_map("default_map", `CDMA_CFG_BASE,  4,            UVM_LITTLE_ENDIAN, 0);


        //0x00
        sar     = reg_sar::type_id::create("sar", null, get_full_name());
        sar.configure(this, null, "");
        sar.build();
        default_map.add_reg(sar, 'h0, "RW");

        //0x04
        dar     = reg_dar::type_id::create("dar", null, get_full_name());
        dar.configure(this, null, "");
        dar.build();
        default_map.add_reg(dar, 'h4, "RW");

        //0x08
        xsize     = reg_xsize::type_id::create("xsize", null, get_full_name());
        xsize.configure(this, null, "");
        xsize.build();
        default_map.add_reg(xsize, 'h8, "RW");

        //0x0C
        ysize     = reg_ysize::type_id::create("ysize", null, get_full_name());
        ysize.configure(this, null, "");
        ysize.build();
        default_map.add_reg(ysize, 'hC, "RW");

        //0x10
        step     = reg_step::type_id::create("step", null, get_full_name());
        step.configure(this, null, "");
        step.build();
        default_map.add_reg(step, 'h10, "RW");

        //0x14
        llr     = reg_llr::type_id::create("llr", null, get_full_name());
        llr.configure(this, null, "");
        llr.build();
        default_map.add_reg(llr, 'h14, "RW");

        //0x18
        status     = reg_status::type_id::create("status", null, get_full_name());
        status.configure(this, null, "");
        status.build();
        default_map.add_reg(status, 'h18, "RO");

        //0x1C
        ctrl     = reg_ctrl::type_id::create("ctrl", null, get_full_name());
        ctrl.configure(this, null, "");
        ctrl.build();
        default_map.add_reg(ctrl, 'h1C, "RW");        

        //0x20
        sof     = reg_sof::type_id::create("sof", null, get_full_name());
        sof.configure(this, null, "");
        sof.build();
        default_map.add_reg(sof, 'h20, "RW");

        //0x24
        unuse_0x24     = reg_unuse_0x24::type_id::create("unuse_0x24", null, get_full_name());
        unuse_0x24.configure(this, null, "");
        unuse_0x24.build();
        default_map.add_reg(unuse_0x24, 'h24, "RW");

        //0x28
        unuse_0x28     = reg_unuse_0x28::type_id::create("unuse_0x28", null, get_full_name());
        unuse_0x28.configure(this, null, "");
        unuse_0x28.build();
        default_map.add_reg(unuse_0x28, 'h28, "RW");

        //0x2C
        vid     = reg_vid::type_id::create("vid", null, get_full_name());
        vid.configure(this, null, "");
        vid.build();
        default_map.add_reg(vid, 'h2C, "RW");
    endfunction : build

endclass : cdma_reg_model


