module MAZE_MEM(input clk, RD, WR, Din, input [3:0] X,Y, output logic Dout);

    logic [0:15] Memory [0:15];

    initial begin
        $readmemb("C:/Users/Erfan/Desktop/ComputerArch/CA/Computer-Architecture-S04/CA1/test/2.txt", Memory);
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