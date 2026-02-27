// controller module
// under cpu

module controller (
    input wire [15:0] instruction,
    input wire clk,

    output reg  [1:0] ALUControl,
    output reg  [1:0] ExtByHowMuch,
    output wire RegWrite,
    output wire PtrToPtr,
    output wire WriteEnable,
    output wire SR2Mux,
    output wire DRMux,
    output wire RegWriteMux,
    output wire SRPCMux,
    output wire BrMux,
    output wire ImmSR2Mux,
    output wire JMPMux
);

    wire [3:0] opcode;
    assign opcode = instruction[15:12];

    // ALU Control
    always @(*) begin
        case (opcode)
            4'b0101: ALUControl = 2'b01; // AND
            4'b1001: ALUControl = 2'b10; // NOT
            default: ALUControl = 2'b00; // ADD
        endcase
    end

    // Immediate extension size
    always @(*) begin
        casez (opcode)
            4'b0100: ExtByHowMuch = 2'b11; // 11 to 16
            4'b??01: ExtByHowMuch = 2'b00; // 5 to 16
            4'b011?: ExtByHowMuch = 2'b01; // 6 to 16
            default: ExtByHowMuch = 2'b10; // 9 to 16
        endcase
    end

    // RegWrite
    assign RegWrite = opcode[0] ^ opcode[1];

    // RAM controls
    assign PtrToPtr   = opcode[3];
    assign WriteEnable = ~(opcode[3] & opcode[2]) & (opcode[1] & opcode[0]);

    // SR2Mux
    assign SR2Mux = ~opcode[3] & opcode[2] & opcode[1] & opcode[0];

    // DRMux
    assign DRMux = ~opcode[3] & opcode[2] & ~opcode[1] & ~opcode[0];

    // RegWriteMux
    assign RegWriteMux = ~(opcode[3] & opcode[2]) & (opcode[1] & ~opcode[0]);

    // SRPCMux
    assign SRPCMux = opcode[0] & ~opcode[1];

    // Branch Mux
    assign BrMux = ~opcode[3] & ~opcode[2] & ~opcode[1] & ~opcode[0];

    // Immediate vs SR2 Mux
    assign ImmSR2Mux = opcode[0] & ~opcode[1] & ~instruction[5];

    // JMP Mux
    assign JMPMux = ~opcode[0] & ~opcode[1];

endmodule
