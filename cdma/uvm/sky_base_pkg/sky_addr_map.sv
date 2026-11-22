/////////////////////////////////////////////////////////////////////////////////////
// Copyright 2019 seabeam@yahoo.com - Licensed under the Apache License, Version 2.0
// For more information, see LICENCE in the main folder
/////////////////////////////////////////////////////////////////////////////////////
`ifndef _SKY_ADDR_MAP_
`define _SKY_ADDR_MAP_

class sky_addr_map extends uvm_object;
  protected uint32 high;     //include this address
  protected uint32 low;      //include this address

  `uvm_object_utils_begin(sky_addr_map)
    `uvm_field_int(high, UVM_DEFAULT)
    `uvm_field_int(low, UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name="sky_addr_map");
    super.new(name);
  endfunction

  function void set_map(uint32 low, uint32 high);
    if (low > high) begin
      `uvm_fatal(get_name(), $sformatf("Low address(0x%0h) exceeds the high boundary(0x%0h) is forbidden", low, high))
      return;
    end
    this.high = high;
    this.low  = low;
  endfunction

  function uint32 get_low();
    return this.low;
  endfunction

  function uint32 get_high();
    return this.high;
  endfunction

  function bit is_contain(uint32 addr);
    if (addr inside {[low:high]})
      return 1;
    else
      return 0;
  endfunction
endclass


class sky_addr_maps extends uvm_object;

  protected sky_addr_map    maps[$] ;   //system addr map of multi-segment
  uint32                    cnt     ;

  `uvm_object_utils_begin(sky_addr_maps)
    `uvm_field_queue_object(maps, UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name="sky_addr_maps");
    super.new(name);
    cnt = 0;
  endfunction

  function void set_map(uint32 low, uint32 high);
    sky_addr_map    tmp ;
    tmp = sky_addr_map::type_id::create($sformatf("map_%0d", cnt));
    cnt++;
    tmp.set_map(low, high);

    maps.push_back(tmp);
  endfunction : set_map


  function bit is_contain(uint32 addr);
    bit flag    = 0;

    foreach(maps[i]) begin
        flag = maps[i].is_contain(addr);
        if(flag)
            break;
    end

    return(flag);
  endfunction : is_contain
endclass

`endif

