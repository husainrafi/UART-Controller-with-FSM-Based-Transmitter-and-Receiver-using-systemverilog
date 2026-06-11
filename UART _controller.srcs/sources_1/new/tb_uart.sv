module uart_tb;

logic clk;

logic rst;

logic tx_start;

logic [7:0] tx_data;

logic tx;

logic busy;

logic [7:0] rx_data;

logic done;


// Clock

initial

begin

clk = 0;

forever #5 clk = ~clk;

end


// TX

uart_tx tx_inst(

.clk(clk),
.rst(rst),

.tx_start(tx_start),

.tx_data(tx_data),

.tx(tx),

.busy(busy)

);


// RX

uart_rx rx_inst(

.clk(clk),

.rst(rst),

.rx(tx),

.data(rx_data),

.done(done)

);


// Test

initial

begin

rst = 1;

tx_start = 0;

tx_data = 0;

#20;

rst = 0;


// Send data

#20;

tx_data = 8'h55;

tx_start = 1;

#10;

tx_start = 0;


#300;

$finish;

end


initial

begin

$monitor(

"TIME=%0t TX=%b RX=%h DONE=%b",

$time,

tx,

rx_data,

done

);

end

endmodule
