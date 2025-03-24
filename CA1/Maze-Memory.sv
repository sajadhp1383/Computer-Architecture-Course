module MAZE_MEM(input clk, RD, WR, Din, input [3:0]X,Y, output logic Dout);

    logic Memory [0:15][0:15];

    initial begin
        $readmemb("Mem_init.bin", Memory);
    end

    always_comb begin
        if (RD)  
            Dout = Memory[X][Y];  
        else  
            Dout = 1'bz;
    end  

    always_ff @(posedge clk) begin
        if(WR)
            Memory[X][Y] <= Din;
        
    end

endmodule