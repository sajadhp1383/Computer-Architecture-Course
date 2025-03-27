`define S0 4'b0000
`define S1 4'b0001
`define S2 4'b0010
`define S3 4'b0011
`define S4 4'b0100
`define S5 4'b0101
`define S6 4'b0110
`define S7 4'b0111
`define S8 4'b1000
`define S9 4'b1001
`define S10 4'b1010
`define S11 4'b1011
`define S12 4'b1100
`define S13 4'b1101


module Rat_Controller(input clk, rst, start, run, cout, invalid, finish, empty1, empty2, full1, full2,
                      output logic ldC, ldX, ldY, Izc, SelMux5, DinMem, push1, pop1, push2, pop2,
                        cen, WR, RD, fail, done);

    reg [3:0] ps, ns;
    always @(posedge clk)
    begin
        if (rst)
            ps = 4'b0000;
        else
            ps = ns;
    end

    always @(posedge clk or start or run or cout or invalid or finish or empty1 or empty2 or full1 or full2)
    begin
        case(ps)
            `S0: ns= start ? `S1 : `S0;
            `S1: ns= ~start ? `S2 : `S1;
            `S2: if(invalid & ~cout)
                begin
                    ns=`S2;
                end
                else if(cout & empty1)
                begin
                    ns=`S3;
                end
                else if(cout & ~empty1)
                begin
                    ns=`S4;
                end
                else  if(~invalid)
                begin
                    ns=`S7;
                end
            `S3: ns=`S3;
            `S4: ns=`S5;
            `S5: ns=`S6;
            `S6: ns=`S2;
            `S7: ns=`S8;
            `S8: ns= finish ? `S9 : `S2;
            `S9: ns= `S10;
            `S10: ns= empty1? `S11 : `S9;
            `S11: ns= run? `S12 : `S11;
            `S12: empty2? ns= `S0 : `S13;
            `S13: ns= `S12;
        endcase
    end

    always @(ps)
    begin
        {ldC, ldX, ldY, Izc, SelMux5, DinMem, push1, pop1, push2, pop2, cen, WR, RD, fail, done} = 16'b0;
        case(ps)
        `S0:;
        `S1: rst=1'b1;
        `S2: {cen,RD,ldR}=3'b111;
        `S3: fail=1'b1;
        `S4: {ldR,Sel5,WR,DinMem}=4'b1111;
        `S5: {ldX,ldY,ldC}=3'b111;
        `S6: ldR=1'b1;
        `S7: {WR, DinMem}=2'b11;
        `S8:ldX=~(Creg[0]^Creg[1]),
            ldY=Creg[0]^Creg[1],
            {push1,Izc}=2'b11;
        `S9:push2=1'b1;
        `S10:pop1=1'b1;
        `S11:done=1'b1;
        `S12:;
        `S13:pop2=1'b1;

        endcase
    end


endmodule