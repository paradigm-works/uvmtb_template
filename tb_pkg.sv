//----------------------------------------------------------------------
// This File: tb_pkg.sv
// Author:    cliff.cummings@paradigm-works.com
// SPDX-License-Identifier: MIT
//----------------------------------------------------------------------

// Only include the code if it has not already been included
`ifndef TB_PKG__SV
`define TB_PKG__SV

`include "CYCLE.sv"

`include "uvm_macros.svh"

package tb_pkg;
  import uvm_pkg::*;

  `include "trans1.svh"

  `include "tb_cover.svh"
  `include "tb_driver.svh"
  `include "tb_sequencer.svh"
  `include "tb_monitor.svh"
  `include "tb_agent.svh"

  `include "sb_predictor.svh"
  `include "sb_comparator.svh"
  `include "tb_scoreboard.svh"
  `include "env.svh"

  `include "tr_sequence.svh"

  `include "test_base.svh"
  `include "test1.svh"
  `include "sb_calc_exp.svh"
endpackage                        

`endif
