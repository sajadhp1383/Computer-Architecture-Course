`timescale 1ns/1ns

module TB_MAZE();

    logic clk = 0, rst = 0, Fail = 0, Done = 0;
    logic [1:0] Move;
    logic Start = 0, Run = 0;  
    Maze maze(clk, rst, Start, Run, Fail, Done, Move);    

    always #2 clk = ~clk;

    initial begin
        #20 rst = 1; #10 rst = 0;
        #10 Start = 1; #5 Start = 0;
        #6000
        #10 Run = 1; #5 Run = 0;
        #800
        #40 $stop;
    end
endmodule