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

    always @(negedge clk) begin
        if(WrEn) begin
            memory[effective_address] <= word_in;
        end
    end

    assign word_out = memory[effective_address];
endmodule
