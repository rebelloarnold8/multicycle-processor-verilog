#!/bin/sh
# Build + simulate the multicycle processor with Icarus Verilog; add -w to open GTKWave.
cd "$(dirname "$0")" || exit 1
iverilog -g2005 -Wall -o Multicycle_Processor_tb.vvp \
  Multicycle_Processor_tb.v Multicycle_Processor.v Datapath.v Control_Unit.v ALU.v \
  ALU_Result_Buffer.v Data_Register.v Instruction_Memory.v Instruction_Register.v \
  IorD_Mux.v Program_Counter.v RegDst_Mux.v Register_File.v Sign_Extend_Module.v \
  pMux2T1_AluSrcA.v pMux2T1_MemToReg.v pMux2T1_PCSrc.v pMux4T1_SrcB.v regA64.v regB64.v || exit 1
vvp -n Multicycle_Processor_tb.vvp || exit 1
if [ "$1" = "-w" ]; then
  command -v gtkwave >/dev/null || { echo "gtkwave not found - install it first (see README)"; exit 1; }
  gtkwave Multicycle_Processor_tb.vcd Multicycle_Processor.gtkw &
fi
