// datapath modules

module datapath (
    input wire clk,
    // instruction
    input wire [15:0] instruction,
    //input wire from ram's output
    input wire [15:0] rams_output,

    //control inputs
    input wire [1:0] ALUControl, ExtByHowMuch,
    input wire RegWrite, PtrToPtr, SR2Mux, DRMux, RegWriteMux, SRPCMux, BrMux, ImmSR2Mux, JMPMux,

    //outputs to RAM
    output wire [15:0] ram_address, input_word_to_ram,

    //output to instruction
    output wire [15:0] PC
);
    // wire declarations
    wire [2:0] SR1, SR2, DR;
    wire [15:0] register_data, data_SR1, data_SR2;
    wire BrFinalBoss;

    wire [15:0] ImmExtResult, ImmExtALUinput2Intermediate;

    wire [15:0] ALUinput1, ALUinput2, ALUoutput;

    wire [15:0] incremented_PC;

    //hardware declarations
    register_handler register_handler(
        .SR1(SR1),
        .SR2(SR2),
        .DR(DR),
        .data(register_data),
        .incremented_PC(incremented_PC),
        .RegWrite(RegWrite),
        .clk(clk),
        .data_SR1(data_SR1),
        .data_SR2(data_SR2),
        .BrFinalBoss(BrFinalBoss)
    );

    ImmExt ImmExt(
        .data(instruction[10:0]),
        .ExtByHowMuch(ExtByHowMuch),
        .result(ImmExtResult)
    );

    ALU ALU(
        .data1(ALUinput1),
        .data2(ALUinput2),
        .ALUControl(ALUControl),
        .result(ALUoutput)
    );
    
    PCadd PCadd(
        .PC_in(PC),
        .clk(clk),
        .PC_incremented(incremented_PC)
    );

    //combinational wire logic
    assign SR1 = instruction[8:6];
    assign SR2 = (SR2Mux) ? instruction[11:9] : instruction[2:0];
    assign DR = (DRMux) ? 3'd7 : instruction[11:9];
    assign register_data = (RegWriteMux) ? rams_output : ALUoutput;
    assign ImmExtALUinput2Intermediate = {16{(BrMux & BrFinalBoss)}} & ImmExtResult;

    assign ALUinput1 = (SRPCMux) ? data_SR1 : incremented_PC;
    assign ALUinput2 = (ImmSR2Mux) ? data_SR2 : ImmExtALUinput2Intermediate;

    assign ram_address = ALUoutput;
    assign input_word_to_ram = SR2;

    assign PC = (JMPMux) ? ALUoutput : incremented_PC;

endmodule