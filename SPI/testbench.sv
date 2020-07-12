//testbench of Slave mode 0 SPI
`include "random_test.sv"
`include "interface.sv"
module tb;

  bit sclk;
  
  initial begin
    
   	forever #5 sclk = ~sclk;
  end
  
  intf in(sclk);
  test t(in);
  slave dut(in.miso, in.mosi, in.sclk, in.rd_wr, in.ssel);
  
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule
