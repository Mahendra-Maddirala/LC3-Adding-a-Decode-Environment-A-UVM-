//decode environment configuration
class decode_env_configuration extends uvm_object;

`uvm_object_utils( decode_env_configuration )

decode_in_configuration decode_in_cnfg;
decode_out_configuration decode_out_cnfg;

function new(string name="");
	super.new(name);
	decode_in_cnfg = decode_in_configuration::type_id::create("decode_in_cnfg"); //decode in configuration
	decode_out_cnfg = decode_out_configuration::type_id::create("decode_out_cnfg"); //decode out configuration
endfunction: new

virtual function void initialize(uvmf_active_passive_t decode_in_activity, string decode_in_agent_path, string decode_in_interface_name, uvmf_initiator_responder_t in_agent_i_r, bit agent_1_tv, bit agent_1_cov,
	uvmf_active_passive_t decode_out_activity, string decode_out_agent_path, string decode_out_interface_name, bit agent_2_tv, bit agent_2_cov);

	decode_in_cnfg.initialize(decode_in_activity, decode_in_agent_path, decode_in_interface_name);
	decode_out_cnfg.initialize(decode_out_activity, decode_out_agent_path, decode_out_interface_name);
	decode_in_cnfg.initiator_responder = in_agent_i_r;
	decode_in_cnfg.enable_transaction_viewing = agent_1_tv;
	decode_out_cnfg.enable_transaction_viewing = agent_2_tv;
	decode_in_cnfg.has_coverage = agent_1_cov;
	decode_out_cnfg.has_coverage = agent_2_cov;

endfunction: initialize
endclass: decode_env_configuration
