module Maze(input CLK, RST, Start, Run, output logic Fail, Done,output logic [1:0] Move);
    logic RD, WR, Din;
    logic [3:0] X, Y;
    wire Dout;

    INTG_RAT Rat(CLK, RST, Start, Run, Dout, Fail, Done, RD, WR, Din, Move, X, Y); 
    MAZE_MEM Memory(CLK, RD, WR, Din, X, Y, Dout);
endmodule