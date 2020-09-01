`include "interface1.sv"
`include "interface2.sv"
`include "test.sv"
`include "random_test.sv"

module tb;
  
  bit sclk;
  
  always #5 sclk = ~sclk;
  
  
  intf1 in1(sclk);
  intf2 in2(sclk);
  
  slave dut(.miso(in1.miso), .mosi(in1.mosi), .sclk(in1.sclk), .ssel(in1.ssel));
  
  initial begin
    uvm_config_db#(virtual intf1)::set(uvm_root::get(), "*", "vif1", in1);
    uvm_config_db#(virtual intf2)::set(uvm_root::get(), "*", "vif2", in2);
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
  initial begin
    run_test("random_test");
  end
  
endmodule 