//predictor
class decode_predictor extends uvm_subscriber #(decode_in_transaction);

`uvm_component_utils( decode_predictor );
uvm_analysis_port #(decode_out_transaction) decode_out_expected_ap;

typedef enum bit[3:0] {ADD=4'b0001, AND=4'b0101, NOT=4'b1001, LD=4'b0010, LDR=4'b0110, LDI=4'b1010, 
                       LEA=4'b1110, ST=4'b0011, STR=4'b0111, STI=4'b1011, BR=4'b0000, JMP=4'b1100} op_t;

function new(string name="", uvm_component parent=null);
	super.new(name, parent);
	decode_out_expected_ap = new("decode_out_expected_ap", this);
endfunction: new

virtual function void write(T t);
	decode_out_transaction decode_out_expected_trans;
	decode_out_expected_trans = new("decode_out_expected_trans");
	if(! (decode_model(
        t.instr_dout, 
        t.npc_in, 
	 decode_out_expected_trans.IR,
	 decode_out_expected_trans.npc_out,
	 decode_out_expected_trans.E_control,
	 decode_out_expected_trans.W_control,
	 decode_out_expected_trans.Mem_control)))
	begin 
    	 decode_out_expected_ap.write(decode_out_expected_trans);
	end
endfunction: write

function bit decode_model
  (
    input bit [15: 0] instr_dout,
    input bit [15: 0] npc_in,
    output bit [15: 0] ir,
    output bit [15: 0] npc_out,
    output bit [5: 0] e_control,
    output bit [1: 0] w_control,
    output bit mem_control
  );
  // replacing the test code below with lc3 decode model
  ir = instr_dout;
  npc_out = npc_in;

  casex (instr_dout[15: 12])
    ADD : begin
      w_control = 0;
      e_control = (instr_dout[5] == 1) ? (6'b000000) : (6'b000001);
      mem_control = 0;
    end

    AND : begin
      w_control = 0;
      e_control = (instr_dout[5] == 1) ? (6'b010000) : (6'b010001);
      mem_control = 0;
    end

    NOT : begin
      w_control = 0;
      e_control = 6'b100000;
      mem_control = 0;
    end

    BR : begin
      w_control = 0;
      e_control = 6'b000110;
      mem_control = 0;
    end

    JMP : begin
      w_control = 0;
      e_control = 6'b001100;
      mem_control = 0;
    end

    LD : begin
      w_control = 1;
      e_control = 6'b000110;
      mem_control = 0;
    end

    LDR : begin
      w_control = 1;
      e_control = 6'b001000;
      mem_control = 0;
    end

    LDI : begin
      w_control = 1;
      e_control = 6'b000110;
      mem_control = 1;
    end

    LEA : begin
      w_control = 2;
      e_control = 6'b000110;
      mem_control = 0;
    end

    ST : begin
      w_control = 0;
      e_control = 6'b000110;
      mem_control = 0;
    end

    STR : begin
      w_control = 0;
      e_control = 6'b001000;
      mem_control = 0;
    end

    STI : begin
      w_control = 0;
      e_control = 6'b000110;
      mem_control = 1;
    end

  endcase

  return (0);
endfunction: decode_model
endclass: decode_predictor
