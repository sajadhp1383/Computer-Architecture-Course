module INTG_RAT(input CLK, RST, Start, Run, Dout,
                 output Fail, Done, RD, WR, Din, output [1:0] Move, output [3:0] X,Y);

    wire ldX, ldY, push, pop;
    wire [3:0] M1, M2, IncOut, DecOut;
    logic SelMux1, SelMux2, full, empty;
    wire [1:0] DinStack, TopStack;

    Reg_4Bit Xreg(CLK, RST, ldX, M2, X);
    Reg_4Bit Yreg(CLK, RST, ldY, M2, Y);
    QuadMUX_2to1 Mux1(X, Y, SelMux1, M1);
    QuadMUX_2to1 Mux2(IncOut, DecOut, SelMux2, M2);
    INC Inc(M1, IncOut);
    DEC Dec(M1, DecOut);
    Stack_2bitWide stack(CLK, RST, push, pop, DinStack,
                             full, empty, TopStack);


endmodule