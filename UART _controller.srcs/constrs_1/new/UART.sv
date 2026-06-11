module uart_tx(

input logic clk,
input logic rst,

input logic tx_start,
input logic [7:0] tx_data,

output logic tx,
output logic busy
);

typedef enum logic[1:0] {

IDLE,
START,
DATA,
STOP

} state_t;

state_t state;

logic [7:0] shift;
logic [2:0] bit_cnt;

always_ff @(posedge clk) begin

if(rst) begin

state<=IDLE;

tx<=1;

busy<=0;

bit_cnt<=0;

end

else begin

case(state)

IDLE:

begin

tx<=1;

busy<=0;

if(tx_start) begin

shift<=tx_data;

state<=START;

busy<=1;

end

end


START:

begin

tx<=0;

state<=DATA;

end


DATA:

begin

tx<=shift[0];

shift<=shift>>1;

if(bit_cnt==7)

state<=STOP;

else

bit_cnt<=bit_cnt+1;

end


STOP:

begin

tx<=1;

state<=IDLE;

bit_cnt<=0;

end

endcase

end

end

endmodule

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