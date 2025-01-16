//----------------------------------------------------------------------
// This File: tb_sequencer.sv
// Author:    cliff.cummings@paradigm-works.com
// SPDX-License-Identifier: MIT
//----------------------------------------------------------------------

class tb_sequencer extends uvm_sequencer #(trans1);
  `uvm_component_utils(tb_sequencer)

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction
endclass
