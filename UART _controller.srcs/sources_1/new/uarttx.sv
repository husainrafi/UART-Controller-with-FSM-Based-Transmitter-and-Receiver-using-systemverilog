module uart_tx(

input logic clk,
input logic rst,

input logic tx_start,
input logic [7:0] tx_data,

output logic tx,
output logic busy

);

typedef enum logic [1:0] {

IDLE,
START,
DATA,
STOP

} state_t;

state_t state;

logic [7:0] shift_reg;
logic [2:0] bit_count;

always_ff @(posedge clk or posedge rst)

begin

if(rst)

begin

state <= IDLE;

tx <= 1'b1;

busy <= 0;

bit_count <= 0;

shift_reg <= 0;

end

else

begin

case(state)

IDLE:

begin

tx <= 1;

busy <= 0;

if(tx_start)

begin

busy <= 1;

shift_reg <= tx_data;

bit_count <= 0;

state <= START;

end

end


START:

begin

tx <= 0;

state <= DATA;

end


DATA:

begin

tx <= shift_reg[0];

shift_reg <= shift_reg >> 1;

if(bit_count == 7)

state <= STOP;

else

bit_count <= bit_count + 1;

end


STOP:

begin

tx <= 1;

busy <= 0;

state <= IDLE;

end


endcase

end

end

endmodule