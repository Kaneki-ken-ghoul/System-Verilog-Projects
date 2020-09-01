`include "environment.sv"
class test extends uvm_test;
  
  `uvm_component_utils(test)
  
  environment env;
  
  function new(string name, uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = environment::type_id::create("env", this);
  endfunction
  
  function void end_of_elaboration();
    print();	
  endfunction
endclass