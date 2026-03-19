// ram.v
// memory

// What all should RAM do:
// take in ptr, gives you value at that ram location or ptr to ptr
// writeenable and input word both must exist also

module ram (
    input wire clk,
    input wire reset,

    input wire WrEn,
    input wire PtrToPtr, //if 1 then ptr to ptr

    input wire [15:0] address,
    input wire [15:0] word_in,

    output wire [15:0] word_out
);
    reg [15:0] memory [0:65535];
    wire [15:0] indirect_address;
    wire [15:0] effective_address;
    assign indirect_address = memory[address];
    assign effective_address = (PtrToPtr) ? indirect_address : address;

    // Debug wires (for waveform visibility only)
  wire [15:0] M0 = memory[0];
  wire [15:0] M1 = memory[1];
  wire [15:0] M2 = memory[2];
  wire [15:0] M3 = memory[3];
  wire [15:0] M4 = memory[4];
  wire [15:0] M5 = memory[5];
  wire [15:0] M6 = memory[6];
  wire [15:0] M7 = memory[7];
  wire [15:0] M8 = memory[8];
  wire [15:0] M9 = memory[9];
  wire [15:0] M10 = memory[10];
  wire [15:0] M11 = memory[11];
  wire [15:0] M12 = memory[12];
  wire [15:0] M13 = memory[13];
  wire [15:0] M57 = memory[57];
  wire [15:0] M67 = memory[67];

    always @(negedge clk) begin
        if(WrEn) begin
            memory[effective_address] <= word_in;
        end
    end

    assign word_out = memory[effective_address];
endmodule
