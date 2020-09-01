
module slave(
    input sclk,
    input mosi,
    input ssel,
    output miso
    );
    
    parameter IDLE = 2'b00, RECEIVE = 2'b01, SEND = 2'b10;
    reg [7:0]mem = 8'b0;
    reg [1:0]ps = IDLE;
    reg [3:0]count = 0;
    reg mi;
    
    
  always @(posedge sclk) begin
        if(!ssel) begin
        case (ps)
        IDLE: begin
            if(mosi)
                ps <= RECEIVE;
            else
                ps <= SEND;
            end
        
        RECEIVE: begin
               if(count == 8)
                ps <= IDLE;
               else 
                 mem <= {mem[6:0], mosi};
                count <= count + 1;
            end
         
        SEND: begin
                 if(count == 0)
                ps <= IDLE;
               else 
                 mi <= mem[0];
          mem <= {1'b0, mem[7:1]};
                count <= count - 1;
            end
            
         default: ps <= IDLE;   
        endcase
        end
        else begin
            mi <= 1'bx;
        end
        end
        
        assign miso = mi;
endmodule
