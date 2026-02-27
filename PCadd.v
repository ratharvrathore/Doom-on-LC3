// PCadd module
// part of datapath

module PCadd (
    input wire [15:0] PC_in,
    input wire clk,
    output reg [15:0] PC_incremented
);
    always @(posedge clk ) begin
        PC_incremented <= PC_in + 16'd1;
    end
endmodule