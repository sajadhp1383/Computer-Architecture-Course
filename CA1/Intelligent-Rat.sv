module INTG_RAT(input CLK, RST, Start, Run, Dout,
                 output logic Fail, Done, RD, WR, Din, output logic [1:0] Move, output logic [3:0] X,Y);

    logic ldX, ldY, ldR, ldC, enMBuff, cen, Izc, IzR, push1, pop1, push2, pop2, SelMux5, SelMux6, SelMux7,
        full1, empty1, full2, empty2, finish, invalid, resetDataPath;

    logic [1:0] Creg;

    Rat_DataPath Datapath(CLK, resetDataPath,  Dout, ldX, ldY, ldR, ldC, enMBuff, cen, Izc, IzR, SelMux5, SelMux6, SelMux7, push1, pop1, push2, pop2,
                            finish, invalid, empty1, empty2, full1, full2, Move, Creg, X, Y);

    Rat_Controller Controller(CLK, RST, Start, Run, invalid, finish, empty1, empty2, full1, full2, Creg,
                                ldC, ldX, ldY, ldR, Izc, IzR, enMBuff, SelMux5, SelMux6, SelMux7, Din, push1, pop1, push2, pop2, cen, WR, RD, Fail, Done, resetDataPath);

endmodule