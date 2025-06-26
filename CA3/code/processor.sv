module MultiCycleProcessor(clk, rst, adrBus, dataBus);
    input clk, rst;
    output [4:0] adrBus;
    output [7:0] dataBus;

    wire IRwrite, StackSrc, Push, Pop;
    wire PCUpdate, AdrSrc, MemWrite, PCwrite, Xwrite, Ywrite;
    wire NorTop;
    wire [2:0] opCode;
    wire [1:0] ALUControl;

    Datapath datapath(
        .clk(clk),
        .rst(rst),
        .IRwrite(IRwrite),
        .StackSrc(StackSrc),
        .ALUControl(ALUControl),
        .Push(Push),
        .Pop(Pop),
        .PCUpdate(PCUpdate),
        .AdrSrc(AdrSrc),
        .MemWrite(MemWrite),
        .PCwrite(PCwrite),
        .Xwrite(Xwrite),
        .Ywrite(Ywrite),
        .NorTop(NorTop),
        .opCode(opCode),
        .Stackout(dataBus),
        .MemoryIn(adrBus)
    );

    Controller controller(
        .clk(clk),
        .rst(rst),
        .opCode(opCode),
        .NorTop(NorTop),
        .IRwrite(IRwrite),
        .StackSrc(StackSrc),
        .ALUControl(ALUControl),
        .Push(Push),
        .Pop(Pop),
        .PCUpdate(PCUpdate),
        .AdrSrc(AdrSrc),
        .MemWrite(MemWrite),
        .PCwrite(PCwrite),
        .Xwrite(Xwrite),
        .Ywrite(Ywrite)
    );
    
endmodule