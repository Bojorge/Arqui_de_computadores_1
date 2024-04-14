transcript on
if ![file isdirectory verilog_libs] {
	file mkdir verilog_libs
}

vlib verilog_libs/altera_ver
vmap altera_ver ./verilog_libs/altera_ver
vlog -vlog01compat -work altera_ver {/home/bojorge/intelFPGA_lite/23.1std/quartus/eda/sim_lib/altera_primitives.v}

vlib verilog_libs/lpm_ver
vmap lpm_ver ./verilog_libs/lpm_ver
vlog -vlog01compat -work lpm_ver {/home/bojorge/intelFPGA_lite/23.1std/quartus/eda/sim_lib/220model.v}

vlib verilog_libs/sgate_ver
vmap sgate_ver ./verilog_libs/sgate_ver
vlog -vlog01compat -work sgate_ver {/home/bojorge/intelFPGA_lite/23.1std/quartus/eda/sim_lib/sgate.v}

vlib verilog_libs/altera_mf_ver
vmap altera_mf_ver ./verilog_libs/altera_mf_ver
vlog -vlog01compat -work altera_mf_ver {/home/bojorge/intelFPGA_lite/23.1std/quartus/eda/sim_lib/altera_mf.v}

vlib verilog_libs/altera_lnsim_ver
vmap altera_lnsim_ver ./verilog_libs/altera_lnsim_ver
vlog -sv -work altera_lnsim_ver {/home/bojorge/intelFPGA_lite/23.1std/quartus/eda/sim_lib/altera_lnsim.sv}

vlib verilog_libs/fiftyfivenm_ver
vmap fiftyfivenm_ver ./verilog_libs/fiftyfivenm_ver
vlog -vlog01compat -work fiftyfivenm_ver {/home/bojorge/intelFPGA_lite/23.1std/quartus/eda/sim_lib/fiftyfivenm_atoms.v}
vlog -vlog01compat -work fiftyfivenm_ver {/home/bojorge/intelFPGA_lite/23.1std/quartus/eda/sim_lib/mentor/fiftyfivenm_atoms_ncrypt.v}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Memory {/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Memory/ROM.v}
vlog -vlog01compat -work work +incdir+/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Memory {/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Memory/RAM.v}
vlog -sv -work work +incdir+/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Processor {/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Processor/adder.sv}
vlog -sv -work work +incdir+/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Processor {/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Processor/arm.sv}
vlog -sv -work work +incdir+/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Processor {/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Processor/condlogic.sv}
vlog -sv -work work +incdir+/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Processor {/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Processor/controller.sv}
vlog -sv -work work +incdir+/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Processor {/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Processor/datapath.sv}
vlog -sv -work work +incdir+/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Processor {/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Processor/decoder.sv}
vlog -sv -work work +incdir+/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Processor {/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Processor/extend.sv}
vlog -sv -work work +incdir+/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Processor {/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Processor/flopenr.sv}
vlog -sv -work work +incdir+/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Processor {/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Processor/flopr.sv}
vlog -sv -work work +incdir+/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Processor {/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Processor/mux2.sv}
vlog -sv -work work +incdir+/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Processor {/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Processor/regfile.sv}
vlog -sv -work work +incdir+/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/VGA {/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/VGA/pll.sv}
vlog -sv -work work +incdir+/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/VGA {/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/VGA/generate_graphic.sv}
vlog -sv -work work +incdir+/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/VGA {/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/VGA/generate_rectangle.sv}
vlog -sv -work work +incdir+/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/VGA {/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/VGA/vga_controller.sv}
vlog -sv -work work +incdir+/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales {/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/TopModule.sv}
vlog -sv -work work +incdir+/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales {/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/CPU.sv}
vlog -sv -work work +incdir+/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/ALU {/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/ALU/alu.sv}

vlog -sv -work work +incdir+/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Testbenches {/home/bojorge/Documents/TEC/Arqui_1/Arqui_de_computadores_1/CPU_taller_digitales/Testbenches/adder_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  adder_tb

add wave *
view structure
view signals
run -all
