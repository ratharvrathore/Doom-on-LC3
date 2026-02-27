// cpu module
// origin: lc3computer
// includes the following modules:
//		datapath
//		control

module cpu (
    //input from instruction_decoder
    input wire [15:0] instruction,

    //input from RAM
	input wire [15:0] memory_data,
	 
	//misc inputs
    input wire clk,
    input wire reset,
	 
	//outputs for instruction_decoder
    output wire [15:0] PC,
	 
	//outputs for RAM
    output wire [15:0] ram_address,
    output wire [15:0] input_word_to_ram,
    
	//control outputs for RAM
    output wire PtrToPtr,
    output wire WriteEnable
);

    wire [1:0] ALUControl, ExtByHowMuch;
    wire RegWrite, SR2Mux, DRMux, RegWriteMux, SRPCMux, ImmSR2Mux, JMPMux;

    controller controller(
        .instruction(instruction),
        .clk(clk),
        .ALUControl(ALUControl),
        .ExtByHowMuch(ExtByHowMuch),
        .RegWrite(RegWrite),
        .PtrToPtr(PtrToPtr),
        .WriteEnable(WriteEnable),
        .SR2Mux(SR2Mux),
        .DRMux(DRMux),
        .RegWriteMux(RegWriteMux),
        .SRPCMux(SRPCMux),
        .ImmSR2Mux(ImmSR2Mux),
        .JMPMux(JMPMux),
    );

    datapath datapath(
        .clk(clk),
        .instruction(instruction),
        .rams_output(memory_data),
        .ALUControl(ALUControl),
        .ExtByHowMuch(ExtByHowMuch),
        .RegWrite(RegWrite),
        .PtrToPtr(PtrToPtr),
        .SR2Mux(SR2Mux),
        .DRMux(DRMux),
        .RegWriteMux(RegWriteMux),
        .SRPCMux(SRPCMux),
        .ImmSR2Mux(ImmSR2Mux),
        .JMPMux(JMPMux),
        .ram_address(ram_address),
        .input_word_to_ram(input_word_to_ram),
        .PC(PC)
    );
endmodule