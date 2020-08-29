`define DR vif.DRIVER.driver_cb
class driver;
  
  transaction trans;
  mailbox gen2driv;
  virtual intf vif;
  bit [7:0]data_gen;
  bit c = 3'b111;
  int d;

  function new(mailbox gen2driv, virtual intf vif);
    this.vif = vif;
    this.gen2driv = gen2driv;
    this.cg = new();
  endfunction

  covergroup cg @(posedge vif.sclk);
        MISO :coverpoint trans.miso;
    
        MOSI :coverpoint trans.mosi;
    
    	RD_WR:coverpoint trans.rd_wr;
    
      endgroup: cg
  
  
  task reset;
    $display("Reset started");
    `DR.mosi <= 1'b1;
    `DR.ssel <= 1'b0;
    $display("Reset Ended");
  endtask
  
  task write;
    `DR.mosi <= 1;
    foreach (data_gen[i]) begin
      trans.mosi = data_gen[i];
      @(posedge vif.sclk);
      `DR.mosi <= trans.mosi;
    end
  endtask
  
  task read;
    `DR.mosi <= 0;
    repeat (8) begin @(posedge vif.sclk);
      trans.miso = `DR.miso;
    end
  endtask
  
  task main;
    forever begin
      gen2driv.get(trans);
      data_gen = trans.data;
      @(posedge vif.sclk);
      `DR.rd_wr <= trans.rd_wr;      
      if(trans.rd_wr) begin
         write;
      end
      else begin
         read;
      end
      d++;
    end
  endtask
  
endclass 
