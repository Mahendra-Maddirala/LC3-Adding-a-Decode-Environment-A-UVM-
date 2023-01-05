//scoreboard
class decode_scoreboard extends uvm_component;

`uvm_component_utils( decode_scoreboard );
`uvm_analysis_imp_decl(_decode_out_expected_aep); //expected decode out
`uvm_analysis_imp_decl(_decode_out_actual_aep); //actual decode out

uvm_analysis_imp_decode_out_expected_aep #(decode_out_transaction, decode_scoreboard) decode_out_expected_aep;
uvm_analysis_imp_decode_out_actual_aep #(decode_out_transaction, decode_scoreboard) decode_out_actual_aep;

decode_out_transaction expected_trans_queue[$];

bit flag;
int expected_trans_count, actual_trans_count, mismatch_count, match_count, nothing_to_compare_count;

function new(string name="", uvm_component parent=null);
	super.new(name, parent);
	decode_out_expected_aep = new("decode_out_expected_aep", this);
	decode_out_actual_aep = new("decode_out_actual_aep", this);
	expected_trans_count = 0;
	actual_trans_count = 0;
	mismatch_count = 0;
	match_count = 0;
	nothing_to_compare_count = 0;
	flag = 1;

endfunction: new

virtual function void write_decode_out_expected_aep(decode_out_transaction expected_trans);
	`uvm_info("SCOREBOARD", {"RECEIVED EXPECTED TRANSACTION: ", expected_trans.convert2string()}, UVM_LOW);
	expected_trans_queue.push_front(expected_trans);
	expected_trans_count++;
endfunction: write_decode_out_expected_aep


virtual function void write_decode_out_actual_aep(decode_out_transaction actual_trans);
	decode_out_transaction expected_trans;
	actual_trans_count++;


	if(flag) flag=0;
	else 
	 begin
	 `uvm_info("SCOREBOARD", {"RECEIVED ACTUAL TRANSACTION: ", actual_trans.convert2string()}, UVM_LOW);
	 expected_trans = expected_trans_queue.pop_back();
	if(expected_trans==null) begin
	 `uvm_error("SCOREBOARD_ERROR: ", "NO ENTRY TO COMPARE");
	  nothing_to_compare_count++;
	end
	
	else begin
	if(actual_trans.compare(expected_trans)) begin
	 `uvm_info("SCOREBOARD_INFO: ", "TRANSACTION MATCH!", UVM_LOW);
	 match_count++;
	end
	else begin
	 `uvm_error("SCOREBOARD_ERROR: ", "TRANSACTION MISMATCH!");
	  mismatch_count++;
	end
	end
	end

endfunction: write_decode_out_actual_aep

function string convert2string();
	return $sformatf("Expected Transaction Count:%d, Actual Transaction Count:%d, Transaction Match Count:%d,
					   Transaction Mismatch Count:%d, Nothing to Compare Count:%d", expected_trans_count,
					   actual_trans_count, match_count, mismatch_count, nothing_to_compare_count);
endfunction: convert2string

function void print_scoreboard_results();
	`uvm_info("SCOREBOARD STATS: ", convert2string(), UVM_LOW); //score board results are printed
endfunction: print_scoreboard_results


endclass: decode_scoreboard
