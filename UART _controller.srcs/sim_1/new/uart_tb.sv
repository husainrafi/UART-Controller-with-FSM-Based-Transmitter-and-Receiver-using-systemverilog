module tb;

logic clk;
logic rst;

logic tx_start;
logic [7:0] tx_data;

logic tx;
logic busy;


// Clock generation
always #5 clk = ~clk;


// DUT Instantiation
uart_tx DUT(

.clk(clk),
.rst(rst),

.tx_start(tx_start),
.tx_data(tx_data),

.tx(tx),
.busy(busy)

);


// Test

initial begin

clk = 0;

rst = 1;

tx_start = 0;

tx_data = 8'h00;

#20;

rst = 0;

#10;

tx_data = 8'h55;

tx_start = 1;

#10;

tx_start = 0;

#200;

$finish;

end

endmodule