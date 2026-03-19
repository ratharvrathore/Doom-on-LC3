// PCadd module
// part of datapath

module PCadd (
    input wire [15:0] PC_in,
    input wire clk,
    input wire reset,
    output wire [15:0] PC_incremented_wire
);
    reg [15:0] PC_store;
    always @(posedge clk ) begin
        PC_store <= PC_in;
    end
    assign PC_incremented_wire = (reset) ? 16'd0 : PC_store + 16'd1;
endmodule