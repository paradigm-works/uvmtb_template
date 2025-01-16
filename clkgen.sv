//----------------------------------------------------------------------
// This File: clkgen.sv
// Author:    cliff.cummings@paradigm-works.com
// SPDX-License-Identifier: MIT
//----------------------------------------------------------------------

`include "CYCLE.sv"
module clkgen (
  output logic clk);

  initial begin
    clk <= '0;
    forever #(`CYCLE/2) clk = ~clk;
  end
endmodule 
