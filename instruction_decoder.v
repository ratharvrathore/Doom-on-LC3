// instr_mem.v - instruction memory

module instruction_decoder (
    input       [15:0] instruction_address,
    output      [15:0] instruction
);

// array of 64 32-bit words or instructions
reg [15:0] instruction_ram [0:1];

initial begin
    $readmemh("lc3_test.hex", instruction_ram);
end

// word-aligned memory access
// combinational read logic
assign instruction = instruction_ram[instruction_address];

endmodule