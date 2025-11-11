# Adapted from Edalize
# https://github.com/olofk/edalize/blob/4a3f3e87/edalize/modelsim.py

onerror { quit -code 1; }
vlib work
vlog +define+SIM -sv -work work ucsbece154a_alu.sv
vlog +define+SIM -sv -work work ucsbece154a_controller.sv
vlog +define+SIM -sv -work work ucsbece154a_datapath.sv
vlog +define+SIM -sv -work work ucsbece154a_dmem.sv
vlog +define+SIM -sv -work work ucsbece154a_imem.sv
vlog +define+SIM -sv -work work ucsbece154a_riscv.sv
vlog +define+SIM -sv -work work ucsbece154a_rf.sv
vlog +define+SIM -sv -work work ucsbece154a_top.sv
vlog +define+SIM -sv -work work ucsbece154a_top_tb.sv
