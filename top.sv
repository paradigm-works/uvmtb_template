//----------------------------------------------------------------------
// This File: top.svh
// Author:    cliff.cummings@paradigm-works.com
// SPDX-License-Identifier: MIT
//----------------------------------------------------------------------

`include "CYCLE.sv"
`include "uvm_macros.svh"
module top;
  import uvm_pkg::*; // import uvm base  classes
  import  tb_pkg::*; // import testbench classes

  logic       clk;

  // Instantiate clkgen
  clkgen         ck  (clk);

  // Instantiate DUT
  // DUT must connect to internal interface signals hierarchically
  dut            i1  (.dout(dif.dout), .din  (dif.din),
                      .clk (clk),      .rst_n(dif.rst_n));

  // instantiate real DUT interface
  dut_if         dif (clk);

  initial begin
    uvm_resource_db#(virtual dut_if)::set("*", "vif", dif);  // UVM-style
    run_test();
  end
endmodule
