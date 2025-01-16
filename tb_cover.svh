//----------------------------------------------------------------------
// This File: tb_cover.svh
// Author:    cliff.cummings@paradigm-works.com
// SPDX-License-Identifier: MIT
//----------------------------------------------------------------------

class tb_cover extends uvm_subscriber #(trans1);
  `uvm_component_utils(tb_cover)

  trans1 tr;

  // Modify the covergroup to sample desired signals
  covergroup cg;
    option.per_instance = 1;
    option.at_least     = 10;
    dout      : coverpoint tr.dout  {bins dout[8]  = {[0:$]};}
    din       : coverpoint tr.din   {bins  din[8]  = {[0:$]};}
    rst       : coverpoint tr.rst_n {bins dorst    = {'0};}
    norst     : coverpoint tr.rst_n {bins norst    = {'1};}
    doutXnorst: cross dout, norst; 
  endgroup

  function new (string name, uvm_component parent);
    super.new(name, parent);
    cg = new();
  endfunction

  function void write (trans1 t);
    tr = t;
    `uvm_info("tb_cover", "Taking covergroup sample ...", UVM_FULL)
    cg.sample();
  endfunction
endclass
