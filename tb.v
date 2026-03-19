`timescale 1ns/1ps

module tb;

    reg clk;
    reg reset;

    // DUT
    lc3computer dut (
        .clk(clk),
        .reset(reset)
    );

    // ================================
    // CLOCK: 100 MHz
    // ================================
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // ================================
    // RESET SEQUENCE
    // ================================
    initial begin
        reset = 1;      // assert reset
        #17;            // hold for 2 clock cycles
        reset = 0;      // release reset
    end

    // ================================
    // WAVE DUMP
    // ================================
    initial begin
        $dumpfile("lc3_full_debug.vcd");
        $dumpvars(0, tb);
    end

    // ================================
    // MONITOR DISPLAY
    // ================================
    always @(posedge clk) begin
        $display("------------------------------------------------------------");
        $display("Time = %0t | Reset = %b", $time, reset);

        $display("PC = %h | Instruction = %h",
                 dut.cpu1.PC,
                 dut.instruction);

        $display("SR1_data = %h | SR2_data = %h",
                 dut.cpu1.datapath.data_SR1,
                 dut.cpu1.datapath.data_SR2);

        $display("ALU_in1 = %h | ALU_in2 = %h | ALU_out = %h",
                 dut.cpu1.datapath.ALUinput1,
                 dut.cpu1.datapath.ALUinput2,
                 dut.cpu1.datapath.ALUoutput);

        $display("RAM_addr = %h | RAM_in = %h | RAM_out = %h | WE = %b | PtrToPtr = %b",
                 dut.ram_address,
                 dut.input_word_to_ram,
                 dut.memory_data,
                 dut.WriteEnable,
                 dut.PtrToPtr);

        $display("ALUControl=%b Ext=%b RegWrite=%b",
                 dut.cpu1.ALUControl,
                 dut.cpu1.ExtByHowMuch,
                 dut.cpu1.RegWrite);

        $display("SR2Mux=%b DRMux=%b RegWriteMux=%b SRPCMux=%b BrMux=%b ImmSR2Mux=%b JMPMux=%b",
                 dut.cpu1.SR2Mux,
                 dut.cpu1.DRMux,
                 dut.cpu1.RegWriteMux,
                 dut.cpu1.SRPCMux,
                 dut.cpu1.BrMux,
                 dut.cpu1.ImmSR2Mux,
                 dut.cpu1.JMPMux);
    end

    // ================================
    // SIMULATION CONTROL
    // ================================
    initial begin
        $display("Starting LC3 Debug Simulation...");
        #1000;
        $display("Simulation Finished.");
        $finish;
    end

endmodule