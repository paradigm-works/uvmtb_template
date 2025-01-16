//----------------------------------------------------------------------
// This File: tb_monitor.svh
// Author:    cliff.cummings@paradigm-works.com
// SPDX-License-Identifier: MIT
//----------------------------------------------------------------------

class tb_monitor extends uvm_monitor;
  `uvm_component_utils(tb_monitor)

  virtual dut_if vif;

  uvm_analysis_port #(trans1) ap;

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap = new("ap", this);
  endfunction

  task run_phase(uvm_phase phase);
    trans1 tr;
    //---------------------------------------
    forever begin
      sample_dut(tr);
      ap.write(tr);
    end
  endtask


  task sample_dut (output trans1 tr);
    trans1 t;
    t = trans1::type_id::create("t");
    //---------------------------------------------
    // Assumption is that sample_dut() is already
    // sync-ed to posedge clk
    // Sample DUT inputs now (on posedge clk)
    //---------------------------------------------
    t.din   = vif.din;
    t.rst_n = vif.rst_n;

    @vif.cb1;                // @(posedge vif.clk); 
    //---------------------------------------------
    // IF async-reset, Re-test async vif.rst_n and 
    // re-assign t.rst_n if vif.rst_n is now low
    //---------------------------------------------
    if (!vif.rst_n) t.rst_n = '0;
    //---------------------------------------------
    // Sample DUT outputs #1step before posedge clk.
    // Uses clocking block timing for #1step
    //---------------------------------------------
    t.dout   = vif.cb1.dout;
    //---------------------------------------------
    // Copy sampled signals to output tr
    //---------------------------------------------
    tr      = t;
    `uvm_info("sample_dut", tr.convert2string(), UVM_FULL)
  endtask
endclass
