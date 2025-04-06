`timescale 1ns/1ns

module TB_MAZE();

    logic clk = 0, rst = 0, Fail = 0, Done = 0;
    logic [1:0] Move;
    logic Start = 0, Run = 0;  
    
    logic [0:15] Memory_Load [0:15];

    initial begin
        $readmemb("C:/Users/Erfan/Desktop/ComputerArch/CA/Computer-Architecture-S04/CA1/test/3.txt", Memory_Load);
    end

    Maze maze(clk, rst, Start, Run, Memory_Load, Fail, Done, Move);    

    always #2 clk = ~clk;

    initial begin
        #20 rst = 1; #10 rst = 0;
        #10 Start = 1; #5 Start = 0;
        #6000
        #10 Run = 1; #5 Run = 0;
        #600
        #100 Run = 1; #5 Run = 0;
        #800
        #20 rst = 1; #10 rst = 0; 
        #40 $stop;
    end
endmodule