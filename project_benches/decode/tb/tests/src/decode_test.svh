//test_top
class test_top extends uvm_test;

`uvm_component_utils( test_top );

decode_env_configuration decode_env_cnfg; //decode_environment_configuration
decode_environment decode_env; //decode environment 

decode_in_random_sequence decode_in_rand_seq;

function new(string name="", uvm_component parent=null);
	super.new(name, parent);

endfunction

virtual function void build_phase(uvm_phase phase);
	decode_env_cnfg = decode_env_configuration::type_id::create("decode_env_cnfg");
	decode_env = decode_environment::type_id::create("decode_env", this);
	
	decode_env_cnfg.initialize(ACTIVE, "uvm_test_top.decode_env.decode_env_in_agent", "decode_in_if", INITIATOR, 1, 1, 
				   PASSIVE, "uvm_test_top.decode_env.decode_env_out_agent", "decode_out_if", 1, 1);
	decode_in_rand_seq = decode_in_random_sequence::type_id::create("decode_in_rand_seq");
endfunction


virtual task run_phase(uvm_phase phase);
	phase.raise_objection(this, "OBJECTION RAISED BY DECODE TEST");
	decode_env_cnfg.decode_in_cnfg.monitor_bfm.wait_for_reset();
	repeat(25) decode_in_rand_seq.start(decode_env.decode_env_in_agent.sequencer);
	decode_env_cnfg.decode_in_cnfg.monitor_bfm.wait_for_num_clocks(3);
	phase.drop_objection(this, "OBJECTION DROPPED BY DECODE TEST");

endtask	

virtual function void report_phase(uvm_phase phase);
	decode_env.decode_scoreboard_inst.print_scoreboard_results();
endfunction

endclass
