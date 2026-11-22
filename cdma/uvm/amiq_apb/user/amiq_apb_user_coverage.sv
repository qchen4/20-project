

//--- user can change these defines before compile of this file
`ifndef AMIQ_APB_ADDR_BITS
`define AMIQ_APB_ADDR_BITS  32
`endif


class amiq_apb_user_coverage extends uvm_component;

    //port for receiving items collected by the monitor
	uvm_analysis_imp#(amiq_apb_mon_item, amiq_apb_user_coverage) mon2cov;
    
    `uvm_component_utils(amiq_apb_user_coverage)

    amiq_apb_mon_item collected_items[$];   //each apb r/w trans will write in 2 items

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mon2cov = new("mon2cov", this);
    endfunction : build_phase

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction : connect_phase

	virtual function string get_id();
		return "amiq_apb_user_coverage";
	endfunction

    virtual function int unsigned get_delay_between_trans();
        if(collected_items.size() == 2) begin
            int unsigned temp;
            temp = collected_items[1].start_cyc - collected_items[0].end_cyc - 1;
            //`uvm_info(get_name(), $sformatf("last apb end cycle:%0d, this begin cycle:%0d, idle cycle:%0d.", collected_items[0].end_cyc, collected_items[1].start_cyc, temp), UVM_LOW)
            return(temp);
        end else begin
            `uvm_error(get_id(), $sformatf("Expecting collected_items.size() = 2 but found %0d", collected_items.size()))
        end
    endfunction


	//Cover the current item
	covergroup cover_item with function sample(amiq_apb_mon_item collected_item);
		option.per_instance = 1; 

		//Cover the direction
		direction : coverpoint collected_item.rw {
			type_option.comment = "Direction of the APB access";
		}

		//Cover the transition for direction
		trans_direction : coverpoint collected_item.rw {
			bins direction_trans[] = (READ, WRITE => READ, WRITE);
			type_option.comment = "Transitions of APB direction";
		}

        //valid cfg byte addr is: 0x00 ~ 0x2c
        trans_addr: coverpoint collected_item.address[`AMIQ_APB_ADDR_BITS-1 : 2] {
            bins cfg_addr[] = {[0:11]};
        }

        //Cover the wdata bits
		`cvr_multiple_32_bits(wdata, collected_item.data, iff(collected_item.rw == WRITE))

		//Cover the rdata bits
		`cvr_multiple_32_bits(rdata, collected_item.data, iff((collected_item.rw == READ) && (collected_item.has_error == NO_ERROR)))

		//Cover the fact that the transfer has or has not wait-states(pready=0 caused wait-cycle)
        //aes always tie pready==1'b1, no wait-state;
		wait_cycle : coverpoint collected_item.get_wait_state() {
            option.weight = 0;  //option.weight = 0 to ignore this coverpoint
        }

		//Cover the transition for wait-states
		trans_wait_cycle : coverpoint collected_item.get_wait_state() {
			bins transfer_type_trans[] = (WITHOUT_WAIT_STATE, WITH_WAIT_STATE => WITHOUT_WAIT_STATE, WITH_WAIT_STATE);
            option.weight = 0;
		}

        addr_min_max: coverpoint collected_item.address {
            bins    addr_0 = {0};
            bins    addr_max = {32'h2c};   //32bit align
        }

        direction_x_addr_min_max:   cross direction, addr_min_max;
        direction_x_addr_range:     cross direction, trans_addr;
        trans_rw_x_wait:            cross trans_direction, wait_cycle {
            option.weight = 0;
        }

        trans_rw_x_trans_wait:      cross trans_direction, trans_wait_cycle {
            option.weight = 0;
        }
    endgroup

	//Cover the delay between two transfers
	covergroup cover_delay_between_transfers with function sample(amiq_apb_mon_item collected_item);
		option.per_instance = 1;

        //Cover the transition for direction
		trans_direction : coverpoint collected_item.rw {
			bins direction_trans[] = (READ, WRITE => READ, WRITE);
			type_option.comment = "Transitions of APB direction";
		}

		//Cover the delays between transfer
		transfer_delay_units : coverpoint get_delay_between_trans() {
			bins back2back[] = {0};
			bins small_delays[] = {[1:4]};
			bins big_delays[1] = {[5:100]};
		}

        rw_x_wait: cross trans_direction, transfer_delay_units;
	endgroup



    function new(string name = "inst", uvm_component parent = null);
        super.new(name, parent);
        cover_item = new();
        cover_delay_between_transfers = new();
    endfunction

	//write method for analysis port: mon2cov
    //each apb trans will write twice: one at apb setup cycle, the other at pready=1
	virtual function void write(amiq_apb_mon_item transfer);
        //$display("Debug: apb monitor port wirte() at time %0t.", $time);

		if(transfer.end_time != 0) begin    //sencond write of a apb trans                    
			cover_item.sample(transfer);

			begin
				bit found_item = 0;
				for(int i = 0; i < collected_items.size(); i++) begin
					if(collected_items[i].start_time == transfer.start_time) begin
						collected_items[i] = transfer;
						found_item = 1;
						break;
					end
				end

				AMIQ_APB_ALGORITHM_ERROR : assert (found_item == 1) else
					`uvm_fatal("COVERAGE", $sformatf("Did not found item in collected_items: %s", transfer.convert2string()));

			end
		end
		else begin                      //first write of a apb trans
			collected_items.push_back(transfer);

			while(collected_items.size() > 2) begin
				void'(collected_items.pop_front());
			end

			if(collected_items.size() == 2) begin
				cover_delay_between_transfers.sample(transfer);
			end
		end
    endfunction

endclass : amiq_apb_user_coverage

