module Multicycle_Processor_tb;
    reg CLK=0, reset=1;
    integer i, errors=0;

    Multicycle_Processor dut(CLK, reset);

    always #5 CLK=~CLK;

    task check(input [255:0] name, input [63:0] got, input [63:0] exp);
        if (got!==exp) begin
            $display("FAIL %0s = %0d (expected %0d)", name, got, exp); errors=errors+1;
        end else
            $display("PASS %0s = %0d", name, got);
    endtask

    initial begin
        $dumpfile("Multicycle_Processor_tb.vcd");
        $dumpvars(0, Multicycle_Processor_tb);
        for (i=0;i<1024;i=i+1) dut.dp.mem.mem[i]=0;
        for (i=0;i<=64;i=i+1)  dut.dp.regFile.regfile[i]=0;
        $readmemh("program.hex", dut.dp.mem.mem, 0, 1023);

        #12 reset=0;
        // 10 instrs: 3 lw*5 + 1 sw*4 + 4 R*4 + 2 beq*3 = 15+4+16+6 = 41 cycles to reach the halt loop
        repeat (60) @(posedge CLK);
        #1;
        $display("---- final PC = 0x%0h (halt loop at 0x50)", dut.dp.PC);
        check("r1", dut.dp.regFile.regfile[1], 25);
        check("r2", dut.dp.regFile.regfile[2], 17);
        check("r3", dut.dp.regFile.regfile[3], 42);
        check("r4", dut.dp.regFile.regfile[4], 8);
        check("r5", dut.dp.regFile.regfile[5], 0);
        check("r6", dut.dp.regFile.regfile[6], 50);
        check("r7", dut.dp.regFile.regfile[7], 42);
        check("mem[0x410]", dut.dp.mem.mem[130], 42);
        check("PC", dut.dp.PC[7:0] == 8'h50 || dut.dp.PC[7:0] == 8'h58, 1);
        if (errors==0) $display("ALL TESTS PASSED");
        else           $display("%0d TEST(S) FAILED", errors);
        $finish;
    end

    // instruction trace
    always @(posedge CLK)
        if (!reset && dut.cu.state==1)
            $display("%6t  PC=0x%02h  instr=%016h  op=%0d", $time, dut.dp.PC[7:0]-8'd8, dut.dp.Instr, dut.dp.opcode);
endmodule
