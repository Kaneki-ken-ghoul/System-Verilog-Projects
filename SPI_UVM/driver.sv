`define DR vif1.DRIVER.driver_cb
class driver extends uvm_driver#(transaction);
  
  `uvm_component_utils(driver)
  
  virtual intf1 vif1;
  bit [0:7]data_gen;
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual intf1)::get(this, "", "vif1", vif1))
      `uvm_fatal("NO VIF", {"virtual interface must be set for :", get_full_name(), ".vif1"})
      endfunction
     
  virtual task run_phase(uvm_phase phase);
    forever begin
    seq_item_port.get_next_item(req);
    drive;
    seq_item_port.item_done();
    end
  endtask
    
  task drive;
    $display("data = %0h", req.data);
    data_gen = req.data;
    @(posedge vif1.DRIVER.sclk);
      `DR.ssel <= 0;     
    //if(data_gen[8]) begin
         write;
     // end
     // else begin
         read;
    //  end
  endtask
    
    task write;
      `DR.mosi <= 1;
      for(int i = 0; i <= 8; i++)begin
      req.mosi = data_gen[i];
        @(posedge vif1.DRIVER.sclk);
      `DR.mosi <= req.mosi;
    end
  endtask
  
  task read;
    `DR.mosi <= 0;
    repeat (8) begin @(posedge vif1.DRIVER.sclk);
      req.miso = `DR.miso;
    end
  endtask
    
endclass