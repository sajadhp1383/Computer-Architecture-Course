`define S0 5'b00000
`define S1 5'b00001
`define S2 5'b00010
`define S3 5'b00011
`define S4 5'b00100
`define S5 5'b00101
`define S6 5'b00110
`define S7 5'b00111
`define S8 5'b01000
`define S9 5'b01001
`define S10 5'b01010
`define S11 5'b01011
`define S12 5'b01100
`define S13 5'b01101
`define S14 5'b01110
`define S15 5'b01111
`define S16 5'b10000
`define S17 5'b10001
`define S18 5'b10010


module Rat_Controller(input clk, rst, start, run, invalid, finish, empty1, empty2, emptyq, full1, full2, enqueue, input [1:0] Creg,
                      output logic ldC, ldX, ldY, ldR, Izc, IzR, enMBuff, SelMux5, SelMux6, SelMux7, DinMem, push1, pop1, push2, pop2,
                        cen, WR, RD, fail, done, resetDataPath, dequeue, recover);

    reg [3:0] ps, ns;
    always @(posedge clk) begin
        if (rst) begin
            ps = 5'b0;
            resetDataPath = 1'b1;
        end
        else
            ps = ns;
    end

    always @(ps, start, invalid, finish, empty1, empty2, run, Creg) begin
        case(ps)
            `S0: ns = start ? `S1 : `S0;
            `S1: ns = ~start ? `S2 : `S1;
            `S2: if(invalid) begin
                    ns=`S3;
                end
                else  if(~invalid) begin
                    ns=`S9;
                end
            `S3: if(~(&{Creg})) begin
                    ns=`S2;
                end
                else if(&{Creg} & empty1) begin
                    ns=`S8;
                end
                else if(&{Creg} & ~empty1) begin
                    ns=`S4;
                end 
            `S4: ns = `S5;
            `S5: ns = `S6;
            `S6: ns = `S7;
            `S7: ns = `S2;
            `S8: ns = `S8;
            `S9: ns = `S10;
            `S10: ns = finish ? `S11 : `S2;
            `S11: ns = `S12;
            `S12: ns = empty1 ? `S13 : `S11;
            `S13: ns = `S14;
            `S14: ns = empty2 ? `S15 : `S13;
            `S15: ns = run? `S16:`S15;
            `S16: if (~emptyq)begin
                ns = `S17;
            end
            else
                ns = `S18;
            `S17: ns = `S16;
            `S18: ns = `S15;

            re
            
        endcase
    end

    always @(ps, start, invalid, finish, empty1, empty2, run, Creg) begin
        {resetDataPath, ldC, ldR, ldX, ldY, Izc, IzR, SelMux5, enMBuff, SelMux6, SelMux7, DinMem, push1, pop1, push2, pop2, cen, WR, RD, fail, done} = 22'b0;
        case(ps)
            `S0: ;
            `S1: resetDataPath = 1'b1;
            `S2: {cen,RD,ldR,SelMux6,SelMux7} = 5'b11111;
            `S3: ldR = 1'b1;
            `S4: {ldR,SelMux5,WR,DinMem} = 4'b1111;
            `S5: {SelMux6,SelMux7,WR} = 3'b111;
            `S6: begin ldX = ~(Creg[0]^Creg[1]);  ldY = Creg[0]^Creg[1]; ldC = 1'b1; end
            `S7: {ldR, pop1} = 2'b11;
            `S8: fail = 1'b1;
            `S9: {WR, DinMem} = 2'b11;
            `S10: begin ldX = ~(Creg[0]^Creg[1]); ldY = Creg[0]^Creg[1];  {push1,Izc,IzR} = 3'b111; end
            `S11: {push2,pop1} = 2'b11;
            `S12: ;
            `S13: {pop2,enqueue} = 2'b11;
            `S14: ; 
            `S15: done = 1'b1;
            `S16: enMBuff = 1'b1;
            `S17: dequeue = 1'b1;
            `S18: recover = 1'b1;
        endcase
    end

endmodule