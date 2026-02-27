// lc3computer.v
// Top level entry
// immediate inclusive modules are:
//		instruction decoder
//		CPU
//		RAM equivalent

module lc3computer (
    input wire clk
);
    wire [15:0] instruction, memory_data, ram_address, input_word_to_ram, PC;
    wire reset, PtrToPtr, WriteEnable;

    cpu cpu1(
        .instruction(instruction),
        .memory_data(memory_data),
        .clk(clk),
        .reset(reset),
        .PC(PC),
        .ram_address(ram_address),
        .input_word_to_ram(input_word_to_ram),
        .PtrToPtr(PtrToPtr),
        .WriteEnable(WriteEnable)
    );

    ram ram1(
        .clk(clk),
        .reset(reset),
        .WrEn(WriteEnable),
        .PtrToPtr(PtrToPtr),
        .address(ram_address),
        .word_in(input_word_to_ram),
        .word_out(memory_data)
    );

    instruction_decoder instruction_decoder(
        .instruction_address(PC),
        .instruction(instruction)
    );
endmodule