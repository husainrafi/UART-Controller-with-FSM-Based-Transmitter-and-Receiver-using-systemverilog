module uart_rx(

input clk,
input rst,

input rx,

output logic [7:0] data,
output logic done
);

logic [2:0] count;

always_ff @(posedge clk)

begin

if(rst)

begin

count<=0;

done<=0;

end

else

begin

if(rx==0)

begin

data[count]<=rx;

count<=count+1;

end

if(count==7)

done<=1;

end

end

endmodule
