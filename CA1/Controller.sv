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
`define S14 4'b1110
`define S15 4'b1111


module Rat_Controller(input clk, rst, start, run, invalid, finish, empty1, empty2, full1, full2, input [1:0] Creg,
                      output logic ldC, ldX, ldY, ldR, Izc, IzR, enMBuff, SelMux5, SelMux6, SelMux7, DinMem, push1, pop1, push2, pop2,
                        cen, WR, RD, fail, done, resetDataPath);

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
            `S13: ns = run ? `S14 : `S13;
            `S14: ns = empty2 ? `S0 : `S15;
            `S15: ns = `S14;
            
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
            `S13: done = 1'b1;
            `S14: enMBuff = 1'b1; 
            `S15: pop2 = 1'b1;
        endcase
    end

endmodule