//----------------------------------------------------------------------
// This File: test1.sv
// Author:    cliff.cummings@paradigm-works.com
// SPDX-License-Identifier: MIT
//----------------------------------------------------------------------

class test1 extends test_base;
  `uvm_component_utils(test1)

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    tr_sequence seq;
    seq = tr_sequence::type_id::create("seq");
    //----------------------------------------
    phase.raise_objection(this);
    `uvm_info("test1", "about to do seq.start", UVM_FULL)
    seq.start(e.agnt.sqr);
    phase.drop_objection(this);
  endtask
endclass
