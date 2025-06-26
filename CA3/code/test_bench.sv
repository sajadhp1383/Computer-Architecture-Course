`timescale 1ns/1ns

module PROCESSOR_TEST();
    logic clk, rst;
    wire [7:0] dataBus;
    wire [4:0] adrBus;

    MultiCycleProcessor  MCP(
        .clk(clk),
        .rst(rst),
        .dataBus(dataBus),
        .adrBus(adrBus)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 0;

        #20 rst = 1; #10 rst = 0;
        #1000
        #20 $stop;
    end

endmodule