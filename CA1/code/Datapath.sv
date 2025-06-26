module Rat_DataPath(input clk, rst, Dout, ldX, ldY, ldR, ldC, enMBuff, cen, Izc, IzR, SelMux5, SelMux6, SelMux7, push1, pop1, push2, pop2, enqueue, dequeue, recover,
                 output logic finish, invalid, empty1, empty2, full1, full2, fullQ, emptyQ, output logic [1:0] Move, Creg, output logic [3:0] X,Y);

    wire [3:0] currentX, currentY, nextX, nextY, IncOut, DecOut;
    logic [1:0] count, TopStack1, TopStack2, M5out, Qout;
    logic [3:0] M1out, M2out;
    wire [1:0] PIcounter, invTopStack1;
    wire Sel1, Sel2, Sel3, Sel4, cout;

    
    assign Sel1 = Creg[0] ^ Creg[1];
    assign Sel2 = ~Creg[0];
    assign Sel3 = ~Sel1;
    assign Sel4 = Sel1;

    assign invTopStack1[0] = ~TopStack1[0];
    assign invTopStack1[1] = ~TopStack1[1];

    assign invalid = ( ~|{currentX} & ~Creg[0] & ~Creg[1] ) | ( &{currentY} & Creg[0] & ~Creg[1] ) |
                        ( ~|{currentY} & ~Creg[0] & Creg[1] ) | ( &{currentX} & ~Creg[0] & Creg[1] ) | Dout; 

    assign finish = ( &{nextX} ) & ( &{nextY} );
    
    Reg_4Bit Reg1(clk, rst, ldX, M2out, currentX);
    Reg_4Bit Reg2(clk, rst, ldY, M2out, currentY);
    Reg_2Bit CounterReg(clk, rst, ldR, IzR, M5out, Creg);

    INC_4Bit Inc(M1out, IncOut);
    INC_2Bit Inc2(TopStack1, PIcounter);
    DEC_4Bit Dec(M1out, DecOut);

    QuadMUX_2to1 Mux1(currentX, currentY, Sel1, M1out);
    QuadMUX_2to1 Mux2(IncOut, DecOut, Sel2, M2out);
    QuadMUX_2to1 Mux3(currentX, M2out, Sel3, nextX);
    QuadMUX_2to1 Mux4(currentY, M2out, Sel4, nextY);
    QuadMUX_2to1 Mux6(currentX, nextX, SelMux6, X);
    QuadMUX_2to1 Mux7(currentY, nextY, SelMux7, Y);
    MUX2Bit_2to1 Mux5(count, invTopStack1, SelMux5, M5out);

    Counter_2Bit Counter(clk, rst, ldC, cen, Izc, PIcounter, count, cout);

    Stack_2bitWide Stack1(clk, rst, push1, pop1, Creg,
                             full1, empty1, TopStack1);
    Stack_2bitWide Stack2(clk, rst, push2, pop2, TopStack1,
                             full2, empty2, TopStack2);
    Queue queue(clk, rst, enqueue, dequeue, recover, TopStack2,fullQ, emptyQ, Qout);
    Buffer_2bit MoveBuffer(enMBuff, Qout, Move);
endmodule