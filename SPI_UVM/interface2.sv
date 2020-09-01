interface intf2(input logic sclk);
  logic mosi;
  logic miso;
  logic ssel;
  
clocking monitor_cb @(negedge sclk);
    default input #1 output #1;
    input miso;
    input mosi;
    input ssel;
  endclocking
  
  modport MONITOR(clocking monitor_cb, input sclk);
  
endinterface