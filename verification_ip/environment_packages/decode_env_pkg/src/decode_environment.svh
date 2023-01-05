//decode environment
class decode_environment extends uvm_env;

`uvm_component_utils(decode_environment)

decode_in_agent decode_env_in_agent; //decode environment in agent
decode_out_agent decode_env_out_agent; //decode environment out agent

decode_predictor decode_predictor_inst; //decode predictor inst
decode_scoreboard decode_scoreboard_inst; //decode scoreboard inst

function new(string name="", uvm_component parent=null);
	super.new(name, parent);
endfunction: new

virtual function void build_phase(uvm_phase phase);
	decode_env_in_agent = decode_in_agent::type_id::create("decode_env_in_agent", this);
	decode_env_out_agent = decode_out_agent::type_id::create("decode_env_out_agent", this);
	decode_predictor_inst = decode_predictor::type_id::create("decode_predictor_inst", this);
	decode_scoreboard_inst = decode_scoreboard::type_id::create("decode_scoreboard_inst", this);
endfunction: build_phase

virtual function void connect_phase(uvm_phase phase);
	decode_env_in_agent.monitored_ap.connect(decode_predictor_inst.analysis_export);
	decode_predictor_inst.decode_out_expected_ap.connect(decode_scoreboard_inst.decode_out_expected_aep);
	decode_env_out_agent.monitored_ap.connect(decode_scoreboard_inst.decode_out_actual_aep);
endfunction: connect_phase
endclass: decode_environment
