//----------------------------------------------------------------------
// This File: tr_sequence.svh
// Author:    cliff.cummings@paradigm-works.com
// SPDX-License-Identifier: MIT
//----------------------------------------------------------------------

class tr_sequence extends uvm_sequence #(trans1);
  `uvm_object_utils(tr_sequence)

  function new (string name = "tr_sequence");
    super.new(name);
  endfunction

  task body;
    trans1 tr = trans1::type_id::create("tr");
    //---------------------------------
    `uvm_info("body", "about to do do_item", UVM_FULL)
    repeat(100) do_item(tr);
  endtask

  task do_item (trans1 tr);
    `uvm_info("do_item", "executing", UVM_FULL)
    start_item(tr);
    if (!(tr.randomize() with {tr.rst_n=='1;}))
        `uvm_fatal("TR_S", "tr_sequence randomization failed")
    `uvm_info("do_item", tr.input2string(), UVM_FULL)
    finish_item(tr);
  endtask
endclass
