interface intf(input logic sclk);
  logic mosi;
  logic miso;
  logic ssel;
  logic rd_wr;
  
  clocking driver_cb @(posedge sclk);
    default input #1 output #1;
    input miso;
    output mosi;
    output ssel;
    output rd_wr;
  endclocking
  
  clocking monitor_cb @(posedge sclk);
    default input #1 output #1;
    input miso;
    input mosi;
    input ssel;
    input rd_wr;
  endclocking
  
  modport DRIVER(clocking driver_cb, input sclk);
  modport MONITOR(clocking monitor_cb, input sclk);
  
endinterface
