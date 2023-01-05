onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /hdl_top/clock
add wave -noupdate /hdl_top/reset
add wave -noupdate /hdl_top/npc_in
add wave -noupdate /hdl_top/instr_dout
add wave -noupdate /hdl_top/enable_decode
add wave -noupdate /hdl_top/Mem_control
add wave -noupdate /hdl_top/W_control
add wave -noupdate /hdl_top/E_control
add wave -noupdate /hdl_top/IR
add wave -noupdate /hdl_top/npc_out
add wave -noupdate -expand /uvm_root/uvm_test_top/decode_env/decode_env_out_agent/decode_env_out_agent_monitor/txn_stream
add wave -noupdate -expand /uvm_root/uvm_test_top/decode_env/decode_env_in_agent/decode_env_in_agent_monitor/txn_stream
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 269
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {150 ns}
