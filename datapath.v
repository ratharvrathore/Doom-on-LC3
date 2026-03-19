// datapath modules

module datapath (
    input wire clk,
    input wire reset,
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

    wire [15:0] incremented_PC_wire, PC_internal;

    //hardware declarations
    register_handler register_handler(
        .SR1(SR1),
        .SR2(SR2),
        .DR(DR),
        .data(register_data),
        .incremented_PC(incremented_PC_wire),
        .RegWrite(RegWrite),
        .clk(clk),
        .reset(reset),
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
    
    //combinational wire logic
    assign SR1 = instruction[8:6];
    assign SR2 = (SR2Mux) ? instruction[11:9] : instruction[2:0];
    assign DR = (DRMux) ? 3'd7 : instruction[11:9];
    assign register_data = (RegWriteMux) ? rams_output : ALUoutput;
    assign ImmExtALUinput2Intermediate = (BrFinalBoss) ? ImmExtResult : 16'd0;

    assign ALUinput1 = (SRPCMux) ? data_SR1 : incremented_PC_wire;
    assign ALUinput2 = (ImmSR2Mux) ? data_SR2 : (BrMux) ? ImmExtALUinput2Intermediate : ImmExtResult;

    assign ram_address = ALUoutput;
    assign input_word_to_ram = data_SR2;

    //PC logic
    assign PC_internal = (reset) ? 16'd0 : (JMPMux) ? ALUoutput : incremented_PC_wire;
    assign incremented_PC_wire = PC + 16'd1;
    reg [15:0] PC_reg, intermediate_PC_reg;
    initial begin
        PC_reg <= 16'd0;
        intermediate_PC_reg <= 16'd0;
    end
    always @(posedge clk) begin
        if (!reset) begin
           PC_reg <= intermediate_PC_reg; 
        end  
    end
    always @(negedge clk) begin
        if (!reset) begin
           intermediate_PC_reg <= PC_internal; 
        end
    end
    assign PC = PC_reg;

endmodule