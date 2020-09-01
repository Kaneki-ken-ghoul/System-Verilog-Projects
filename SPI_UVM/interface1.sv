interface intf1(input logic sclk);
  logic mosi;
  logic miso;
  logic ssel;

  
  clocking driver_cb @(posedge sclk);
    default input #2 output #1;
    input miso;
    output mosi;
    output ssel;
  endclocking
  
  clocking monitor_cb @(negedge sclk);
    default input #1 output #1;
    input miso;
    input mosi;
    input ssel;
  endclocking
  
  modport DRIVER(clocking driver_cb, input sclk);
  modport MONITOR(clocking monitor_cb, input sclk);
  
endinterface