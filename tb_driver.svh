//----------------------------------------------------------------------
// This File: tb_driver.svh
// Author:    cliff.cummings@paradigm-works.com
// SPDX-License-Identifier: MIT
//----------------------------------------------------------------------

class tb_driver extends uvm_driver #(trans1);
  `uvm_component_utils(tb_driver)

  virtual dut_if vif;

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    trans1 tr;
    initialize();
    forever begin
      `uvm_info("DEBUG: Driver Run",  "... getting next item ...", UVM_FULL)
      seq_item_port.get_next_item(tr);
      drive_item(tr);
      seq_item_port.item_done();
      `uvm_info("DEBUG: Driver Run",     "... next item done ...", UVM_FULL)
    end
  endtask


  virtual task initialize (); // @0 - Does not use clocking block
    `uvm_info("INIT", "Initialize (time @0)", UVM_HIGH)
    vif.rst_n <= '0;
    vif.din   <= '1;  // Initialize din with 1's to verify that reset works
    @vif.cb1;         // @(posedge vif.clk); 
  endtask

  virtual task drive_item (trans1 tr);
    `uvm_info("drive_item", tr.input2string(), UVM_FULL)
    vif.cb1.rst_n <= tr.rst_n;
    vif.cb1.din   <= tr.din;
    @vif.cb1;         // @(posedge vif.clk); 
  endtask
endclass
