`define Fetch 3'b000
`define Decode 3'b001
`define ReadyX 3'b010
`define ReadyY 3'b011
`define Operation 3'b100
`define StoreOrLoad 3'b101
`define Jump 3'b110

module Controller(clk, rst, opCode, NorTop,
                     IRwrite, StackSrc, ALUControl, Push, Pop, PCUpdate, AdrSrc, MemWrite, PCwrite, Xwrite, Ywrite);

    input clk, rst, NorTop;
    input [2:0] opCode;
    output logic IRwrite, StackSrc, Push, Pop, PCUpdate, AdrSrc, MemWrite, PCwrite, Xwrite, Ywrite;
    output logic [1:0] ALUControl;

    logic [2:0] ps, ns;

    always @(posedge clk, posedge rst) begin
        if(rst)
            ps <= `Fetch;
        else
            ps <= ns;
    end

    always @(ps, opCode) begin
        case(ps)
            `Fetch: ns = `Decode;
            `Decode: ns = (opCode == 3'b0 || opCode == 3'b001 || opCode == 3'b010 || opCode == 3'b011) ? `ReadyX:
                            (opCode == 3'b100 || opCode == 3'b101) ? `StoreOrLoad:
                            (opCode == 3'b110 || opCode == 3'b111) ? `Jump: `Decode;
            `ReadyX: ns = (opCode == 3'b011) ? `Operation: `ReadyY;
            `ReadyY: ns = `Operation;
            `Operation: ns = `Fetch;
            `StoreOrLoad: ns = `Fetch;
            `Jump: ns = `Fetch;
        endcase
    end

    always @(ps, opCode) begin
        {StackSrc, Push, Pop, PCUpdate, AdrSrc, MemWrite, PCwrite, Xwrite, Ywrite, IRwrite} = 10'b0;
        case(ps)
            `Fetch: begin AdrSrc <= 1'b0; IRwrite <= 1'b1; PCUpdate <= 1'b1; end
            `Decode: AdrSrc <= 1'b1;
            `ReadyX: begin Xwrite <= 1'b1; Pop <= 1'b1; end
            `ReadyY: begin Ywrite <= 1'b1; Pop <= 1'b1; end
            `Operation: begin ALUControl <= opCode[1:0]; StackSrc <= 1'b0; Push <= 1'b1; end
            `StoreOrLoad: begin AdrSrc <= 1'b1; StackSrc <= 1'b1; MemWrite <= opCode[0]; Push <= ~(opCode[0]); Pop <= opCode[0]; end
            `Jump: PCwrite <= (opCode[0]) ? NorTop : 1'b1;
        endcase
    end

endmodule