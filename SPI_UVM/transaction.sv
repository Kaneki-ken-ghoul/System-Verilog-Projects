class transaction extends uvm_sequence_item;
  rand bit [8:0]data;
  bit mosi;
  bit miso;
  bit ssel;
  
  `uvm_object_utils_begin(transaction)
  `uvm_field_int(data, UVM_HEX)
  `uvm_field_int(mosi, UVM_HEX)
  `uvm_field_int(miso, UVM_HEX)
  `uvm_field_int(ssel, UVM_HEX)
  `uvm_object_utils_end
  
  function new(string name = "transaction");
    super.new(name);
  endfunction
  
/*  function void print();
    `uvm_info(get_type_name(), $sformatf("rd_wr = %0d", rd_wr), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("mosi = %0d", mosi), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("miso = %0d", miso), UVM_LOW)
    
  endfunction*/
  
endclass