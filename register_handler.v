// register handler module
// part of datapath

module register_handler (
    //inputs from instuction code
    input wire [2:0] SR1, SR2, DR,

    //data to write
    input wire [15:0] data,

    //special wire whose origin is incremented PC which maps to reg 7
    input wire [15:0] incremented_PC,

    //control
    input wire RegWrite,
    input wire clk,

    //outputs back to CPU
    output wire [15:0] data_SR1, data_SR2,

    //setcc criteria
    output wire BrFinalBoss
);

    reg [7:0] regfile [0:7];
    assign data_SR1 = regfile[SR1];
    assign data_SR2 = regfile[SR2];
    reg N, Zee, P;

    always @(negedge clk) begin
        if(RegWrite) begin
            if (DR == 3'b111)
            regfile[7] <= incremented_PC;  // R7 gets PC+1
            else
            regfile[DR] <= data;
            // put n,z,p condition here
            // put n,z,p condition here ONLY
            N <= data[15];
            Zee <= (data == 16'b0);
            P <= (~data[15]) & (data != 16'b0);
        end
    end

    assign BrFinalBoss = (DR[0] & P) | (DR[1] & Zee) | (DR[2] & N);
    
endmodule