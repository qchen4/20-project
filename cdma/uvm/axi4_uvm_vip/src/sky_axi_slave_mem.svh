`ifndef SKY_AXI_SLAVE_READ_MEM_SVH
`define SKY_AXI_SLAVE_READ_MEM_SVH

class sky_axi_slave_mem extends tue_component_base #(
  .BASE          (uvm_component         ),
  .CONFIGURATION (tvip_axi_configuration),
  .STATUS        (tvip_axi_status       )
);

  `uvm_component_utils(sky_axi_slave_mem)
  `tue_component_default_constructor(sky_axi_slave_mem)

  protected tvip_axi_slv_vif    vif     ;
  mailbox_slv                   drv2mem ;
  mailbox_slv                   mem2drv ;

  tvip_axi_slave_item           item    ;


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif = configuration.slv_vif;
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      do_reset();
      fork
        main();
        @(negedge vif.areset_n);
      join_any
      disable fork;
    end
  endtask

  protected task do_reset();
    while(drv2mem.num() != 0) begin
      drv2mem.get(item);
    end

    @(posedge vif.areset_n);
  endtask

  task main();
    forever begin
      drv2mem.get(item);

      if(item.is_read())
        sys_mem_rd();
      else
        sys_mem_wr();

      mem2drv.put(item);  
    end
  endtask

  function int  lower_byte_offset(tvip_axi_address addr);
    int   data_bus_byte ;
    data_bus_byte = this.configuration.data_width / 8;

    return (addr % data_bus_byte);

  endfunction


  //func: get data from sys_mem and fill in trans item
  task sys_mem_rd();
    tvip_axi_address  byte_addr   ;
    tvip_axi_data     rdata       ;
    int               byte_offset ; //byte offset within bus

    for(int i=0; i<item.burst_length; i++) begin
      if(!item.addr_dec_err[i]) begin
        byte_addr = item.addr_beat[i];
        rdata     = '0;

        if(i==0) begin  //align byte_addr to burst size(just first beat may not align)
          case(item.burst_size)
          1:  ;
          2:  byte_addr[0]  = 1'd0;
          4:  byte_addr[1:0]= 2'd0;
          8:  byte_addr[2:0]= 3'd0;
          16: byte_addr[3:0]= 4'd0;
          32: byte_addr[4:0]= 5'd0;
          64: byte_addr[5:0]= 6'd0;
          128:byte_addr[6:0]= 7'd0;
          endcase
        end

        byte_offset = lower_byte_offset(byte_addr);

        for(int j=0; j<item.burst_size; j++) begin
          if(item.strobe[i][byte_offset] == 1'b1)
            rdata[byte_offset*8 +: 8] = vif.sys_mem_byte_rd(byte_addr);

          byte_addr++;
          byte_offset++;
        end

        item.data[i] = rdata;
      end else begin
        item.response[i] = TVIP_AXI_DECODE_ERROR;
        `uvm_error(get_name(), $sformatf("AXI Read to addr %0h is out of address range.", item.addr_beat[i]))
        item.maps.print();
      end   //if(!item.addr_dec_err[i])
    end //for(int i=0; i<item.burst_length; i++)
  endtask : sys_mem_rd


  //func: get data from trans irem and write to sys_mem
  task sys_mem_wr();
    tvip_axi_address  byte_addr   ;
    logic [7:0]       wdata       ;
    int               byte_offset ; //byte offset within bus

    for(int i=0; i<item.burst_length; i++) begin
      if(!item.addr_dec_err[i]) begin
        byte_addr = item.addr_beat[i];

        if(i==0) begin  //align byte addr to burst size(just first beat may not align)
          case(item.burst_size)
          1:  ;
          2:  byte_addr[0]  = 1'd0;
          4:  byte_addr[1:0]= 2'd0;
          8:  byte_addr[2:0]= 3'd0;
          16: byte_addr[3:0]= 4'd0;
          32: byte_addr[4:0]= 5'd0;
          64: byte_addr[5:0]= 6'd0;
          128:byte_addr[6:0]= 7'd0;
          endcase
        end

        byte_offset = lower_byte_offset(byte_addr);

        for(int j=0; j<item.burst_size; j++) begin
          if(item.strobe[i][byte_offset] == 1'b1) begin
            wdata = item.data[i][byte_offset*8 +: 8];
            vif.sys_mem_byte_wr(byte_addr, wdata);
          end

          byte_addr++;
          byte_offset++;
        end //for(int j=0; j<item.burst_size; j++)
      end else begin
        item.response[0] = TVIP_AXI_DECODE_ERROR;   //1 response for write item
        `uvm_error(get_name(), $sformatf("AXI write to addr %0h is out of address range.", item.addr_beat[i]))
        item.maps.print();
      end   //if(!item.addr_dec_err[i])
    end //for(int i=0; i<item.burst_length; i++)    
  endtask : sys_mem_wr

endclass : sky_axi_slave_mem

`endif
