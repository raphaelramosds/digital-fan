onerror {quit -f}
vlib work
vlog -work work DigitalFan.vo
vlog -work work DigitalFan.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.DigitalFan_vlg_vec_tst
vcd file -direction DigitalFan.msim.vcd
vcd add -internal DigitalFan_vlg_vec_tst/*
vcd add -internal DigitalFan_vlg_vec_tst/i1/*
add wave /*
run -all
