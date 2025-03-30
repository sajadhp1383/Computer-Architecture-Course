module Stack_2bitWide(input clk, rst, Push, Pop, input [1:0] Din,
                         output logic Full, Empty, output logic [1:0] Top);

    logic [1:0] stack [255:0];
    logic [7:0] ptr;

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            ptr <= 0;
            Full <= 0;
            Empty <= 1;
            Top <= 2'bX;
        end
        else begin 

            if(Push && !Full) begin 
                stack[ptr] <= Din;
                ptr <= ptr +1;
            end
            else if(Pop && !Empty) begin
                ptr <= ptr -1;
            end
            if(ptr > 0)
                Top <= stack[ptr-1];
            else
                Top <= 2'bx;

            Empty <= (ptr == 0);
            Full <= (ptr == 256);  
        end 
    end

endmodule