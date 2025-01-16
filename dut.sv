//----------------------------------------------------------------------
// This File: dut.sv
// Author:    cliff.cummings@paradigm-works.com
// SPDX-License-Identifier: MIT
//
// Dummy DUT for uvmtb_template - Simple register model
//----------------------------------------------------------------------

module dut (
  output logic [15:0] dout,
  input        [15:0] din,
  input               clk, rst_n);

  always_ff @(posedge clk, negedge rst_n)
    if   (!rst_n) dout <= '0;
    else          dout <= din;
endmodule
