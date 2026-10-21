# Multicycle Processor

A 64-bit MIPS-style multicycle processor in Verilog. It supports lw, sw, add, sub and beq.

Install: `sudo port install iverilog gtkwave` (or `sudo apt install iverilog gtkwave` on Ubuntu)

Run: `./run.sh` to simulate, or `./run.sh -w` to also open the waveforms in GTKWave.

## Files

- `Multicycle_Processor.v` - top module, connects the datapath to the control unit
- `Datapath.v` - wires up all the datapath blocks below
- `Control_Unit.v` - the FSM (Fetch, Decode, MemAdr, MemRead, MemWB, MemWrite, ExecuteR, ALUWB, BEQ) plus the ALU decoder
- `ALU.v` - add/sub with a zero flag for beq
- `Program_Counter.v` - PC register with reset and write enable
- `Instruction_Memory.v` - shared instruction/data memory, 1024 x 64-bit words, byte addressed
- `Instruction_Register.v` - holds the fetched instruction
- `Data_Register.v` - holds data read from memory for lw
- `Register_File.v` - registers with two read ports and one write port, r0 always reads 0
- `regA64.v`, `regB64.v` - A and B registers that latch the register file outputs
- `ALU_Result_Buffer.v` - ALUOut register
- `Sign_Extend_Module.v` - sign-extends the 32-bit immediate to 64 bits
- `IorD_Mux.v` - picks the memory address: PC or ALUOut
- `RegDst_Mux.v` - picks the destination register: rt or rd
- `pMux2T1_AluSrcA.v` - ALU input A: PC or A
- `pMux4T1_SrcB.v` - ALU input B: B, 8, imm, or imm<<3
- `pMux2T1_MemToReg.v` - register write data: ALUOut or memory data
- `pMux2T1_PCSrc.v` - next PC: ALU result or ALUOut (branch target)
- `Multicycle_Processor_tb.v` - testbench; loads the program, runs it, checks registers and memory
- `program.hex` - the test program with each instruction commented
- `Multicycle_Processor.gtkw` - saved GTKWave layout with the useful signals grouped
- `run.sh` - compiles with iverilog and runs with vvp
- `MulticycleProcessor.qpf/.qsf` - Quartus project files
- `*_gate_64bit*.v`, `full_adder_64bit*.v`, `full_subtractor_64bit*.v`, `sr_/jk_flipflop*.v`, `mealy_/moore_machine*.v` - earlier lab exercises with their testbenches, not part of the processor
- `pMux2T1_IorD.v`, `pMux2T1_RegDst.v`, `instr_mem64.v` - older duplicates of the IorD mux, RegDst mux and memory, not used
