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


//register adapter
class amiq_apb2rm_adapter extends uvm_reg_adapter;

	`uvm_object_utils(amiq_apb2rm_adapter)

	//function for getting the ID used in messaging
	//@return message ID
	virtual function string get_id();
		return "amiq_apb2rm_adapter";
	endfunction

	//constructor
	//@param name - name of the component instance
	function new(string name = "amiq_apb2rm_adapter");
		super.new(name);
	endfunction

	virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
        amiq_apb_master_drv_item    tr = amiq_apb_master_drv_item::type_id::create("tr");

		assert (tr.randomize() with {
            need_response == 1;
            trans_delay <= 2;

            address == local::rw.addr;
            
            if(local::rw.kind == UVM_WRITE) {
                rw == WRITE;
                strobe == 4'hf;
            } else {
                rw == READ;
            }
                
            data    == local::rw.data;

		}) else
		`uvm_fatal(get_id(), "Could not randomize amiq_apb_master_drv_item");

		return tr;
	endfunction

	virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
		amiq_apb_master_drv_item tr;

		rw.status = UVM_NOT_OK;

		if($cast(tr, bus_item)) begin
			if(tr.rw == WRITE)
				rw.kind = UVM_WRITE;
			else
				rw.kind = UVM_READ;

			rw.addr = tr.address;
			rw.data = tr.data;
			rw.status = UVM_IS_OK;
            rw.byte_en=4'hf;
		end
		else begin
			`uvm_fatal(get_id(), $sformatf("casting did not worked - bus_item: %s", bus_item.convert2string()))
		end

	endfunction
endclass



