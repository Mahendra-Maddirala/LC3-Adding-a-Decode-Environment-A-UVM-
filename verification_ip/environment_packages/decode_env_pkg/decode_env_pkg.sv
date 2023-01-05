//decode environment package
package decode_env_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"
import uvmf_base_pkg_hdl::*; //importing base package HDL
import uvmf_base_pkg::*; ////importing base package 

import decode_in_pkg::*; //importing decode in package
import decode_out_pkg::*; //importing decode out package

`include "src/decode_env_configuration.svh" //including environment configuration
`include "src/decode_predictor.svh" //including decode predictor
`include "src/decode_scoreboard.svh" //including scoreboard
`include "src/decode_environment.svh" //including environment
endpackage
