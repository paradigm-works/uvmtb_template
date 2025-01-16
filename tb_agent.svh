//----------------------------------------------------------------------
// This File: tb_agent.sv
// Author:    cliff.cummings@paradigm-works.com
// SPDX-License-Identifier: MIT
//----------------------------------------------------------------------

class tb_agent extends uvm_agent;
  `uvm_component_utils(tb_agent)
                                                                                
  // is_active flag declaration inherited from uvm_agent
  // uvm_active_passive_enum is_active = UVM_ACTIVE;

  virtual dut_if vif;

  uvm_analysis_port #(trans1) ap;
  tb_driver     drv;
  tb_monitor    mon;
  tb_sequencer  sqr;

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (is_active == UVM_ACTIVE) begin
      drv =    tb_driver::type_id::create("drv", this);
      sqr = tb_sequencer::type_id::create("sqr", this);
    end
    mon   =   tb_monitor::type_id::create("mon", this);
    ap    = new("ap", this);
    get_vif();
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if (is_active == UVM_ACTIVE) begin
      drv.seq_item_port.connect(sqr.seq_item_export);
      drv.vif = vif;
    end
    mon.ap.connect(ap);
    mon.vif = vif;
  endfunction

  function void get_vif();
    string passwd = get_full_name();
    if(!uvm_resource_db#(virtual dut_if)::read_by_name(passwd, "vif", vif, this))
        `uvm_fatal("NOVIF",{"virtual interface must be set for:", passwd,".vif"})
  endfunction

    //---------------------------------------------------------------------------
    // Could also replace above uvm_resource_db command with one of the 
    // following commands
    //---------------------------------------------------------------------------
    //if(!uvm_config_db#(virtual dut_if)::get(this, "", "vif", vif))
    //if(!uvm_resource_db#(virtual dut_if)::read_by_type(passwd,        vif, this))
endclass
