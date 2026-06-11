module uart_rx(

input logic clk,
input logic rst,

input logic rx,

output logic [7:0] data,
output logic done

);

logic [2:0] count;

always_ff @(posedge clk or posedge rst)

begin

if(rst)

begin

count <= 0;

done <= 0;

data <= 0;

end

else

begin

done <= 0;

if(rx == 0)

count <= 0;

else if(count < 8)

begin

data[count] <= rx;

count <= count + 1;

end

else

begin

done <= 1;

count <= 0;

end

end

end

endmodule
