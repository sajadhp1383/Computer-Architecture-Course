module Hazard_Unit(StallF, StallD, FlushD, Rs1D, Rs2D, FlushE, RdE, Rs1E,
                    Rs2E, PCSrcE, ForwardAE, ForwardBE, ResultSrcE0, RdM,
                    RegWriteM, RdW, RegWriteW);

    input Rs1D, Rs2D, Rs1E, Rs2E, RdE, PCSrcE, ResultSrcE0, RdM,
            RegWriteM, RdW, RegWriteW;
    output StallF, StallD, FlushD, FlushE, ForwardAE, ForwardBE;

    always @(Rs1E, RdM, RegWriteM) begin
        if((Rs1E == RdM) & RegWriteM) & (Rs1E != 0)
            ForwardAE = 2'b10;
        else if((Rs1E == RdW) & RegWriteW) & (Rs1E != 0)
            ForwardAE = 2'b01;
        else
            ForwardAE = 2'b00;
    end

    always @(Rs2E, RdM, RegWriteM) begin
        if((Rs2E == RdM) & RegWriteM) & (Rs2E != 0)
            ForwardBE = 2'b10;
        else if((Rs2E == RdW) & RegWriteW) & (Rs2E != 0)
            ForwardBE = 2'b01;
        else
            ForwardBE = 2'b00;
    end

    wire lwStall;

    assign lwStall = ResultSrcE0 & ((Rs1D == RdE) | (Rs2D == RdE));
    assign StallF = lwStall;
    assign StallD = lwStall;

    assign FlushD = PCSrcE;
    assign FlushE = lwStall | PCSrcE;

endmodule