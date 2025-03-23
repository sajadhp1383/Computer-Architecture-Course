module MAZE_MEM(input clk, RD, WR, Din, input [3:0]X,Y, output logic Dout);

    logic Memory [0:3][0:3];

    initial begin
        $readmemb("Mem_init.bin", Memory);
    end

    always @(posedge clk) begin
        if(WR) begin 
            Memory[X][Y] <= Din;
        end
        else if(RD) begin
            Dout <= Memory[X][Y];
        end
    end

endmodule