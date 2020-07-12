//Slave mode 0
module slave(output reg miso,
             input mosi,
             input sclk,
             input rd_wr,
             input ssel
            );
  
  parameter idle = 2'b00;
  parameter receive = 2'b01;
  parameter send = 2'b10;
  
  reg [7:0]r1=0;
  reg [1:0]state = 2'b00;
  reg [3:0] c1 = 4'b0111 , c2 = 4'b0000;

  always @(posedge sclk) begin
    if(ssel == 1'b0) begin
      case (state)
        idle:
          begin
            if(rd_wr)
                state = receive; 
            else 
              state = send;
          end
        
        receive: 
          begin
          	r1[c1] = mosi;
          	c1 = c1 - 1;
            if(c1 == 4'b1111) begin
        		c1 = 4'b0111;
          		state = idle;
        	end
          end
        
        send:
          begin
            miso = r1[c2];
            r1[c2] = 1'b0;
            c2 = c2 + 1;
            if(c2 == 4'b1000) begin
            	c2 = 4'b0000;
                state = idle; 
            end
          end
        
        default:
          state = idle;
      endcase
    end
  end
  
  
endmodule
