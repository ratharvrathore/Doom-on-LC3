// ImmExt module
// part of datapath module

module ImmExt (
    input wire [10:0] data,
    input wire [1:0] ExtByHowMuch,
    output wire [15:0] result
);
    // ExtByHowMuch: 00: 5 to 16
    //               01: 6 to 16
    //               10: 9 to 16
    //               11: 11 to 16

    assign result =
        (ExtByHowMuch == 2'b00) ? {{11{data[4]}}, data[4:0]} :
        (ExtByHowMuch == 2'b01) ? {{10{data[8]}}, data[5:0]} :
        (ExtByHowMuch == 2'b10) ? {{7{data[8]}}, data[8:0]} :
        (ExtByHowMuch == 2'b11) ? {{5{data[10]}}, data[10:0]} : 16'd0;
endmodule