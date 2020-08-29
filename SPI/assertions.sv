module assertion(input mosi, sclk, rd_wr, ssel, miso, input [1:0]state);
  
  
// Check ssel is not unknown 
  property p1;
    @(posedge sclk) ($fell(mosi) || $rose(mosi)) |-> !$isunknown(ssel);
  endproperty
  
  ssel_zero: assert property(p1)
    else 
      $display("FAILED SSEL_ZERO");
  
    
// Check miso is unknown if ssel is unknown  
   property p2;
     @(posedge sclk) $isunknown(ssel) |-> $isunknown(miso); 
   endproperty
    
  start_ssel_miso: assert property(p2)
   else
     $display("FAILED START_SSEL_MISO");
    
// Check mosi is not an unknown value when rd_wr is high    
    property p3;
      disable iff(ssel)
      @(posedge sclk) rd_wr |-> !$isunknown(mosi);
    endproperty
    
    mosi_write_check: assert property(p3)
      else
        $display("FAILED WRITE_CHECK");
    
// Check miso is zero or unknown when we are writing
    property p4;
      disable iff(ssel)
      @(posedge sclk) rd_wr |-> !miso || $isunknown(miso);
    endproperty
      
      miso_zero_wr: assert property(p4)
        else
          $display("FAILED MISO_ZERO_WR");
        
// Check transtition of state when rd_wr is high
     property p5;
       disable iff(ssel)
       @(posedge sclk) $rose(rd_wr) |-> (state == 2'b00) |=> (state == 2'b01);
     endproperty
        
     check_state_transition_write: assert property(p5)
       else
         $display("FAILED CHECK_STATE_TRANSITION_WRITE");         
       
// Check transition of state when rd_wr is low       
     property p6;
       disable iff(ssel)
       @(posedge sclk) state == 2'b10 |-> ($past(rd_wr,1) == 0);
     endproperty
     
     check_state_transition_read: assert property(p6)
       else
         $display("FAILED CHECK_STATE_TRANSITION_READ");         
// Check for state zero during write
     property p7;
       disable iff(ssel)
       @(posedge sclk) $rose(rd_wr) |-> (state == 2'b00); 
     endproperty
       
      check_state_zero_write: assert property(p7)
      	else 
          $display("FAILED CHECK_STATE_ZERO_WRITE");
// Check for state zero during read
      
     property p8;
       disable iff(ssel)
       @(posedge sclk) $fell(rd_wr) |-> (state == 2'b00);
     endproperty
     
         check_state_zero_read: assert property(p8)
           else
             $display("FAILED CHECK_STATE_ZERO_READ");
           
// Check for rd_wr is not unknown
     property p9;
       @(posedge sclk) $fell(ssel) |-> !$isunknown(rd_wr);
     endproperty
           
     check_rd_wr_unknown: assert property(p9) 
       else
         $display("FAILED CHECK_RD_WR_UNKNOWN");
       
// Check for rd_wr high for 8 clk cycles
       property p10;
         @(posedge sclk) $rose(rd_wr) |=> rd_wr[*8];
       endproperty
       
       write_clk_8_cycles: assert property(p10)
         else
           $display("FAILED WRITE_CLK_8_CYCLES");
// Check for rd_wr low for 8 clk cycles        
       property p11;
         @(posedge sclk) $fell(rd_wr) |=> !rd_wr[*8];
       endproperty
       
       read_clk_8_cycles: assert property(p11)
         else
           $display("FAILED READ_CLK_8_CYCLES");
endmodule        
