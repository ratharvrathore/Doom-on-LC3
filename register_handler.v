module register_handler (
    input wire [2:0] SR1, SR2, DR,
    input wire [15:0] data,
    input wire [15:0] incremented_PC,
    input wire RegWrite,
    input wire clk,
    input wire reset,

    output wire [15:0] data_SR1, data_SR2,
    output wire BrFinalBoss
);

    reg [15:0] regfile [0:7];
    reg N, Zee, P;

                                    // Debug wires (for waveform visibility only)
                                  wire [15:0] R0 = regfile[0];
                                  wire [15:0] R1 = regfile[1];
                                  wire [15:0] R2 = regfile[2];
                                  wire [15:0] R3 = regfile[3];
                                  wire [15:0] R4 = regfile[4];
                                  wire [15:0] R5 = regfile[5];
                                  wire [15:0] R6 = regfile[6];
                                  wire [15:0] R7 = regfile[7];

    // Asynchronous read
    assign data_SR1 = regfile[SR1];
    assign data_SR2 = regfile[SR2];

    // Single sequential block
    always @(negedge clk) begin
        if (reset) begin
            regfile[0] <= 16'd0;
            regfile[1] <= 16'd0;
            regfile[2] <= 16'd0;
            regfile[3] <= 16'd0;
            regfile[4] <= 16'd0;
            regfile[5] <= 16'd0;
            regfile[6] <= 16'd0;
            regfile[7] <= 16'd0;

            N   <= 1'b0;
            Zee <= 1'b0;
            P   <= 1'b0;
        end
        else if (RegWrite) begin
            if (DR == 3'b111)
                regfile[7] <= incremented_PC;
            else
                regfile[DR] <= data;

            // Condition codes update
            N   <= data[15];
            Zee <= (data == 16'd0);
            P   <= (~data[15]) & (data != 16'd0);
        end
    end

    assign BrFinalBoss =
            (DR[0] & P) |
            (DR[1] & Zee) |
            (DR[2] & N);

endmodule