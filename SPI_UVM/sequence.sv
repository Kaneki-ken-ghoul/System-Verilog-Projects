class add_sequence extends uvm_sequence#(transaction);
  
  `uvm_object_utils(add_sequence)
  
  function new(string name = "add_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(2) begin
    req = transaction::type_id::create("req");
    wait_for_grant();
    req.randomize();
    send_request(req);
    wait_for_item_done();
   end 
  endtask
endclass