module INTG_RAT(input CLK, RST, Start, Run, Dout,
                 output logic Fail, Done, RD, WR, Din, output logic [1:0] Move, output logic [3:0] X,Y);

    logic ldX, ldY, ldR, ldC, cen, Izc, cout, push1, pop1, push2, pop2, SelMux5,
        full1, empty1, full2, empty2, finish, invalid;

    Rat_DataPath Datapath(CLK, RST, Dout, ldX, ldY, ldR, ldC, cen, Izc, SelMux5, push1, pop1, push2, pop2,
                            finish, invalid, empty1, empty2, full1, full2, cout, Move, X, Y);

    Rat_Controller Controller(CLK, RST, Start, Run, cout, invalid, finish, empty1, empty2, full1, full2,
                                ldC, ldX, ldY, Izc, SelMux5, Din, push1, pop1, push2, pop2, cen, WR, RD, Fail, Done);

endmodule