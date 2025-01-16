//----------------------------------------------------------------------
// This File: dut_if.svh
// Author:    cliff.cummings@paradigm-works.com
// SPDX-License-Identifier: MIT
//----------------------------------------------------------------------

//----------------------------------------------------------------------
// Drive the stimulus 20% of the CYCLE time after posedge clk
//----------------------------------------------------------------------
`include "CYCLE.sv"
`define Tdrive #(0.2*`CYCLE)

interface dut_if (input clk);
  logic [15:0] dout;
  logic [15:0] din;
  logic        rst_n;

  clocking cb1 @(posedge clk);
    default input #1step output `Tdrive;
    input  dout;
    output din;
    output rst_n;
  endclocking
endinterface
