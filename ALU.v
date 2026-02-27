// ALU module
// part of datapath

module ALU (
    input wire [15:0] data1, data2,

    //control input
    input wire [1:0] ALUControl,

    output wire [15:0] result
);
    //ALUcontrol: 00: Add
    //            01: AND
    //            10: NOT (on data1)

    assign result = (ALUControl == 2'b00) ? (data1 + data2) :
                    (ALUControl == 2'b01) ? (data1 & data2) :
                    (ALUControl == 2'b10) ? (~data1)        :
                                            16'b0;
    
endmodule