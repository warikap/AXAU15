
################################################################
# This is a generated script based on design: system
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2024.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   common::send_gid_msg -ssname BD::TCL -id 2040 -severity "CRITICAL WARNING" "This script was generated using Vivado <$scripts_vivado_version> without IP versions in the create_bd_cell commands, but is now being run in <$current_vivado_version> of Vivado. There may have been changes to the IP between Vivado <$scripts_vivado_version> and <$current_vivado_version>, which could impact the functionality and configuration of the design."

}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source system_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# eth_mac_10g_fifo_core, eth_mac_10g_fifo_core

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcau15p-ffvb676-2-i
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name system

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:ethernet_1_10_25g:*\
xilinx.com:inline_hdl:ilconstant:*\
xilinx.com:ip:clk_wiz:*\
xilinx.com:ip:proc_sys_reset:*\
xilinx.com:ip:system_ila:*\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
eth_mac_10g_fifo_core\
eth_mac_10g_fifo_core\
"

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set gt_ref_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 gt_ref_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {156250000} \
   ] $gt_ref_clk

  set gt_rx_0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:display_ethernet_1_10_25g:gt_ports:2.0 gt_rx_0 ]

  set gt_tx_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_ethernet_1_10_25g:gt_ports:2.0 gt_tx_0 ]

  set SYS_CLK [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 SYS_CLK ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {200000000} \
   ] $SYS_CLK


  # Create ports
  set ext_reset [ create_bd_port -dir I -type rst ext_reset ]

  # Create instance: ethernet_1_10_25g_0, and set properties
  set ethernet_1_10_25g_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ethernet_1_10_25g ethernet_1_10_25g_0 ]
  set_property -dict [list \
    CONFIG.CORE {Ethernet PCS/PMA 32-bit} \
    CONFIG.GT_DRP_CLK {50.00} \
    CONFIG.GT_GROUP_SELECT {Quad_X0Y1} \
    CONFIG.INCLUDE_AXI4_INTERFACE {0} \
    CONFIG.NUM_OF_CORES {2} \
  ] $ethernet_1_10_25g_0


  # Create instance: ONE, and set properties
  set ONE [ create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilconstant ONE ]

  # Create instance: ZERO, and set properties
  set ZERO [ create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilconstant ZERO ]
  set_property CONFIG.CONST_VAL {0} $ZERO


  # Create instance: clk_wiz, and set properties
  set clk_wiz [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz clk_wiz ]
  set_property -dict [list \
    CONFIG.CLKIN1_JITTER_PS {50.0} \
    CONFIG.CLKOUT1_JITTER {121.478} \
    CONFIG.CLKOUT1_PHASE_ERROR {82.655} \
    CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {50.0} \
    CONFIG.MMCM_CLKFBOUT_MULT_F {6.000} \
    CONFIG.MMCM_CLKIN1_PERIOD {5.000} \
    CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
    CONFIG.MMCM_CLKOUT0_DIVIDE_F {24.000} \
    CONFIG.OPTIMIZE_CLOCKING_STRUCTURE_EN {true} \
    CONFIG.PRIM_IN_FREQ {200.000} \
    CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} \
    CONFIG.RESET_PORT {resetn} \
    CONFIG.RESET_TYPE {ACTIVE_LOW} \
  ] $clk_wiz


  # Create instance: rst_clk_wiz_200M, and set properties
  set rst_clk_wiz_200M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_clk_wiz_200M ]

  # Create instance: speed_sel, and set properties
  set speed_sel [ create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilconstant speed_sel ]
  set_property -dict [list \
    CONFIG.CONST_VAL {0b10} \
    CONFIG.CONST_WIDTH {2} \
  ] $speed_sel


  # Create instance: txd, and set properties
  set txd [ create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilconstant txd ]
  set_property -dict [list \
    CONFIG.CONST_VAL {0} \
    CONFIG.CONST_WIDTH {8} \
  ] $txd


  # Create instance: system_ila_0, and set properties
  set system_ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila system_ila_0 ]
  set_property -dict [list \
    CONFIG.C_DATA_DEPTH {4096} \
    CONFIG.C_MON_TYPE {INTERFACE} \
    CONFIG.C_NUM_MONITOR_SLOTS {2} \
    CONFIG.C_NUM_OF_PROBES {0} \
    CONFIG.C_PROBE0_WIDTH {1} \
    CONFIG.C_PROBE1_WIDTH {1} \
    CONFIG.C_PROBE_WIDTH_PROPAGATION {MANUAL} \
    CONFIG.C_SLOT {1} \
    CONFIG.C_SLOT_0_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
    CONFIG.C_SLOT_1_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
  ] $system_ila_0


  # Create instance: loopback, and set properties
  set loopback [ create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilconstant loopback ]
  set_property -dict [list \
    CONFIG.CONST_VAL {0} \
    CONFIG.CONST_WIDTH {3} \
  ] $loopback


  # Create instance: config_vector, and set properties
  set config_vector [ create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilconstant config_vector ]
  set_property -dict [list \
    CONFIG.CONST_VAL {0} \
    CONFIG.CONST_WIDTH {5} \
  ] $config_vector


  # Create instance: eth_mac_10g_fifo_core_0, and set properties
  set block_name eth_mac_10g_fifo_core
  set block_cell_name eth_mac_10g_fifo_core_0
  if { [catch {set eth_mac_10g_fifo_core_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $eth_mac_10g_fifo_core_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: eth_mac_10g_fifo_core_1, and set properties
  set block_name eth_mac_10g_fifo_core
  set block_cell_name eth_mac_10g_fifo_core_1
  if { [catch {set eth_mac_10g_fifo_core_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $eth_mac_10g_fifo_core_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create interface connections
  connect_bd_intf_net -intf_net CLK_IN1_D_0_1 [get_bd_intf_ports SYS_CLK] [get_bd_intf_pins clk_wiz/CLK_IN1_D]
  connect_bd_intf_net -intf_net eth_mac_10g_fifo_core_0_rx_axis [get_bd_intf_pins eth_mac_10g_fifo_core_0/rx_axis] [get_bd_intf_pins eth_mac_10g_fifo_core_1/tx_axis]
connect_bd_intf_net -intf_net [get_bd_intf_nets eth_mac_10g_fifo_core_0_rx_axis] [get_bd_intf_pins eth_mac_10g_fifo_core_0/rx_axis] [get_bd_intf_pins system_ila_0/SLOT_0_AXIS]
  connect_bd_intf_net -intf_net eth_mac_10g_fifo_core_1_rx_axis [get_bd_intf_pins eth_mac_10g_fifo_core_1/rx_axis] [get_bd_intf_pins eth_mac_10g_fifo_core_0/tx_axis]
connect_bd_intf_net -intf_net [get_bd_intf_nets eth_mac_10g_fifo_core_1_rx_axis] [get_bd_intf_pins eth_mac_10g_fifo_core_1/rx_axis] [get_bd_intf_pins system_ila_0/SLOT_1_AXIS]
  connect_bd_intf_net -intf_net ethernet_1_10_25g_0_gt_tx [get_bd_intf_ports gt_tx_0] [get_bd_intf_pins ethernet_1_10_25g_0/gt_tx]
  connect_bd_intf_net -intf_net gt_ref_clk_0_1 [get_bd_intf_ports gt_ref_clk] [get_bd_intf_pins ethernet_1_10_25g_0/gt_ref_clk]
  connect_bd_intf_net -intf_net gt_rx_0_1 [get_bd_intf_ports gt_rx_0] [get_bd_intf_pins ethernet_1_10_25g_0/gt_rx]

  # Create port connections
  connect_bd_net -net ONE_dout  [get_bd_pins ONE/dout] \
  [get_bd_pins ethernet_1_10_25g_0/signal_detect_0] \
  [get_bd_pins ethernet_1_10_25g_0/signal_detect_1]
  connect_bd_net -net ZERO_dout  [get_bd_pins ZERO/dout] \
  [get_bd_pins ethernet_1_10_25g_0/gmii_tx_en_0] \
  [get_bd_pins ethernet_1_10_25g_0/gmii_tx_er_0] \
  [get_bd_pins ethernet_1_10_25g_0/ctl_tx_test_pattern_0] \
  [get_bd_pins ethernet_1_10_25g_0/ctl_tx_test_pattern_enable_0] \
  [get_bd_pins ethernet_1_10_25g_0/ctl_rx_test_pattern_0] \
  [get_bd_pins ethernet_1_10_25g_0/ctl_rx_test_pattern_enable_0] \
  [get_bd_pins ethernet_1_10_25g_0/gmii_tx_en_1] \
  [get_bd_pins ethernet_1_10_25g_0/gmii_tx_er_1] \
  [get_bd_pins ethernet_1_10_25g_0/ctl_rx_test_pattern_enable_1] \
  [get_bd_pins ethernet_1_10_25g_0/ctl_rx_test_pattern_1] \
  [get_bd_pins ethernet_1_10_25g_0/ctl_tx_test_pattern_1] \
  [get_bd_pins ethernet_1_10_25g_0/ctl_tx_test_pattern_enable_1]
  connect_bd_net -net clk_wiz_clk_out1  [get_bd_pins clk_wiz/clk_out1] \
  [get_bd_pins ethernet_1_10_25g_0/dclk] \
  [get_bd_pins rst_clk_wiz_200M/slowest_sync_clk]
  connect_bd_net -net clk_wiz_locked  [get_bd_pins clk_wiz/locked] \
  [get_bd_pins rst_clk_wiz_200M/dcm_locked]
  connect_bd_net -net eth_mac_10g_fifo_core_0_xgmii_txc  [get_bd_pins eth_mac_10g_fifo_core_0/xgmii_txc] \
  [get_bd_pins ethernet_1_10_25g_0/tx_mii_c_0]
  connect_bd_net -net eth_mac_10g_fifo_core_0_xgmii_txd  [get_bd_pins eth_mac_10g_fifo_core_0/xgmii_txd] \
  [get_bd_pins ethernet_1_10_25g_0/tx_mii_d_0]
  connect_bd_net -net eth_mac_10g_fifo_core_1_xgmii_txc  [get_bd_pins eth_mac_10g_fifo_core_1/xgmii_txc] \
  [get_bd_pins ethernet_1_10_25g_0/tx_mii_c_1]
  connect_bd_net -net eth_mac_10g_fifo_core_1_xgmii_txd  [get_bd_pins eth_mac_10g_fifo_core_1/xgmii_txd] \
  [get_bd_pins ethernet_1_10_25g_0/tx_mii_d_1]
  connect_bd_net -net ethernet_1_10_25g_0_rx_clk_out_0  [get_bd_pins ethernet_1_10_25g_0/rx_clk_out_0] \
  [get_bd_pins system_ila_0/clk] \
  [get_bd_pins eth_mac_10g_fifo_core_0/logic_clk] \
  [get_bd_pins eth_mac_10g_fifo_core_0/xgmii_rx_clk] \
  [get_bd_pins eth_mac_10g_fifo_core_1/logic_clk]
  connect_bd_net -net ethernet_1_10_25g_0_rx_clk_out_1  [get_bd_pins ethernet_1_10_25g_0/rx_clk_out_1] \
  [get_bd_pins eth_mac_10g_fifo_core_1/xgmii_rx_clk]
  connect_bd_net -net ethernet_1_10_25g_0_rx_mii_c_0  [get_bd_pins ethernet_1_10_25g_0/rx_mii_c_0] \
  [get_bd_pins eth_mac_10g_fifo_core_0/xgmii_rxc]
  connect_bd_net -net ethernet_1_10_25g_0_rx_mii_c_1  [get_bd_pins ethernet_1_10_25g_0/rx_mii_c_1] \
  [get_bd_pins eth_mac_10g_fifo_core_1/xgmii_rxc]
  connect_bd_net -net ethernet_1_10_25g_0_rx_mii_d_0  [get_bd_pins ethernet_1_10_25g_0/rx_mii_d_0] \
  [get_bd_pins eth_mac_10g_fifo_core_0/xgmii_rxd]
  connect_bd_net -net ethernet_1_10_25g_0_rx_mii_d_1  [get_bd_pins ethernet_1_10_25g_0/rx_mii_d_1] \
  [get_bd_pins eth_mac_10g_fifo_core_1/xgmii_rxd]
  connect_bd_net -net ethernet_1_10_25g_0_tx_mii_clk_0  [get_bd_pins ethernet_1_10_25g_0/tx_mii_clk_0] \
  [get_bd_pins eth_mac_10g_fifo_core_0/xgmii_tx_clk]
  connect_bd_net -net ethernet_1_10_25g_0_tx_mii_clk_1  [get_bd_pins ethernet_1_10_25g_0/tx_mii_clk_1] \
  [get_bd_pins eth_mac_10g_fifo_core_1/xgmii_tx_clk]
  connect_bd_net -net ethernet_1_10_25g_0_user_rx_reset_0  [get_bd_pins ethernet_1_10_25g_0/user_rx_reset_0] \
  [get_bd_pins eth_mac_10g_fifo_core_0/logic_rst] \
  [get_bd_pins eth_mac_10g_fifo_core_0/xgmii_rx_rst] \
  [get_bd_pins eth_mac_10g_fifo_core_1/logic_rst]
  connect_bd_net -net ethernet_1_10_25g_0_user_rx_reset_1  [get_bd_pins ethernet_1_10_25g_0/user_rx_reset_1] \
  [get_bd_pins eth_mac_10g_fifo_core_1/xgmii_rx_rst]
  connect_bd_net -net ethernet_1_10_25g_0_user_tx_reset_0  [get_bd_pins ethernet_1_10_25g_0/user_tx_reset_0] \
  [get_bd_pins eth_mac_10g_fifo_core_0/xgmii_tx_rst]
  connect_bd_net -net ethernet_1_10_25g_0_user_tx_reset_1  [get_bd_pins ethernet_1_10_25g_0/user_tx_reset_1] \
  [get_bd_pins eth_mac_10g_fifo_core_1/xgmii_tx_rst]
  connect_bd_net -net ext_reset_in  [get_bd_ports ext_reset] \
  [get_bd_pins rst_clk_wiz_200M/ext_reset_in] \
  [get_bd_pins clk_wiz/resetn]
  connect_bd_net -net ilconstant_2_dout  [get_bd_pins config_vector/dout] \
  [get_bd_pins ethernet_1_10_25g_0/configuration_vector_0] \
  [get_bd_pins ethernet_1_10_25g_0/configuration_vector_1]
  connect_bd_net -net loopback_dout  [get_bd_pins loopback/dout] \
  [get_bd_pins ethernet_1_10_25g_0/gt_loopback_in_0] \
  [get_bd_pins ethernet_1_10_25g_0/gt_loopback_in_1]
  connect_bd_net -net rst_clk_wiz_200M_peripheral_reset  [get_bd_pins rst_clk_wiz_200M/peripheral_reset] \
  [get_bd_pins ethernet_1_10_25g_0/sys_reset] \
  [get_bd_pins ethernet_1_10_25g_0/rx_reset_0] \
  [get_bd_pins ethernet_1_10_25g_0/tx_reset_0] \
  [get_bd_pins ethernet_1_10_25g_0/gtwiz_reset_tx_datapath_0] \
  [get_bd_pins ethernet_1_10_25g_0/gtwiz_reset_rx_datapath_0] \
  [get_bd_pins ethernet_1_10_25g_0/tx_reset_1] \
  [get_bd_pins ethernet_1_10_25g_0/rx_reset_1] \
  [get_bd_pins ethernet_1_10_25g_0/gtwiz_reset_rx_datapath_1] \
  [get_bd_pins ethernet_1_10_25g_0/gtwiz_reset_tx_datapath_1]
  connect_bd_net -net speed_sel_dout  [get_bd_pins speed_sel/dout] \
  [get_bd_pins ethernet_1_10_25g_0/ctl_core_speed_sel_0] \
  [get_bd_pins ethernet_1_10_25g_0/ctl_core_speed_sel_1]
  connect_bd_net -net txd_dout  [get_bd_pins txd/dout] \
  [get_bd_pins ethernet_1_10_25g_0/gmii_txd_0] \
  [get_bd_pins ethernet_1_10_25g_0/gmii_txd_1]

  # Create address segments

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   "ActiveEmotionalView":"Default View",
   "Default View_ScaleFactor":"1.08772",
   "Default View_TopLeft":"1269,283",
   "ExpandedHierarchyInLayout":"",
   "guistr":"# # String gsaved with Nlview 7.8.0 2024-04-26 e1825d835c VDI=44 GEI=38 GUI=JA:21.0 TLS
#  -string -flagsOSRD
preplace port gt_ref_clk -pg 1 -lvl 0 -x -10 -y 570 -defaultsOSRD
preplace port gt_rx_0 -pg 1 -lvl 0 -x -10 -y 590 -defaultsOSRD
preplace port gt_tx_0 -pg 1 -lvl 5 -x 2250 -y 610 -defaultsOSRD
preplace port SYS_CLK -pg 1 -lvl 0 -x -10 -y 1070 -defaultsOSRD
preplace port port-id_ext_reset -pg 1 -lvl 0 -x -10 -y 1090 -defaultsOSRD
preplace inst ethernet_1_10_25g_0 -pg 1 -lvl 3 -x 1280 -y 1000 -defaultsOSRD
preplace inst ONE -pg 1 -lvl 2 -x 710 -y 1430 -defaultsOSRD
preplace inst ZERO -pg 1 -lvl 2 -x 710 -y 1010 -defaultsOSRD
preplace inst clk_wiz -pg 1 -lvl 1 -x 260 -y 1080 -defaultsOSRD
preplace inst rst_clk_wiz_200M -pg 1 -lvl 2 -x 710 -y 870 -defaultsOSRD
preplace inst speed_sel -pg 1 -lvl 2 -x 710 -y 1530 -defaultsOSRD
preplace inst txd -pg 1 -lvl 2 -x 710 -y 1130 -defaultsOSRD
preplace inst system_ila_0 -pg 1 -lvl 4 -x 2000 -y 370 -defaultsOSRD
preplace inst loopback -pg 1 -lvl 2 -x 710 -y 1230 -defaultsOSRD
preplace inst config_vector -pg 1 -lvl 2 -x 710 -y 1330 -defaultsOSRD
preplace inst eth_mac_10g_fifo_core_0 -pg 1 -lvl 4 -x 2000 -y 870 -defaultsOSRD
preplace inst eth_mac_10g_fifo_core_1 -pg 1 -lvl 4 -x 2000 -y 1270 -defaultsOSRD
preplace netloc ONE_dout 1 2 1 970 1370n
preplace netloc ZERO_dout 1 2 1 1000 750n
preplace netloc clk_wiz_clk_out1 1 1 2 520 1070 NJ
preplace netloc clk_wiz_locked 1 1 1 530 910n
preplace netloc eth_mac_10g_fifo_core_0_xgmii_txc 1 2 3 970 480 N 480 2210
preplace netloc eth_mac_10g_fifo_core_0_xgmii_txd 1 2 3 980 490 N 490 2200
preplace netloc eth_mac_10g_fifo_core_1_xgmii_txc 1 2 3 1000 510 N 510 2190
preplace netloc eth_mac_10g_fifo_core_1_xgmii_txd 1 2 3 990 500 N 500 2180
preplace netloc ethernet_1_10_25g_0_rx_clk_out_0 1 3 1 1780 380n
preplace netloc ethernet_1_10_25g_0_rx_clk_out_1 1 3 1 1610 930n
preplace netloc ethernet_1_10_25g_0_rx_mii_c_0 1 3 1 1810 650n
preplace netloc ethernet_1_10_25g_0_rx_mii_c_1 1 3 1 1580 710n
preplace netloc ethernet_1_10_25g_0_rx_mii_d_0 1 3 1 1800 670n
preplace netloc ethernet_1_10_25g_0_rx_mii_d_1 1 3 1 1570 730n
preplace netloc ethernet_1_10_25g_0_tx_mii_clk_0 1 3 1 1590 830n
preplace netloc ethernet_1_10_25g_0_tx_mii_clk_1 1 3 1 1620 890n
preplace netloc ethernet_1_10_25g_0_user_rx_reset_0 1 3 1 1790 850n
preplace netloc ethernet_1_10_25g_0_user_rx_reset_1 1 3 1 1590 1030n
preplace netloc ethernet_1_10_25g_0_user_tx_reset_0 1 3 1 1600 870n
preplace netloc ethernet_1_10_25g_0_user_tx_reset_1 1 3 1 1560 1230n
preplace netloc ext_reset_in 1 0 2 140 850 N
preplace netloc ilconstant_2_dout 1 2 1 970 1330n
preplace netloc loopback_dout 1 2 1 970 1230n
preplace netloc rst_clk_wiz_200M_peripheral_reset 1 2 1 980 870n
preplace netloc speed_sel_dout 1 2 1 1000 1410n
preplace netloc txd_dout 1 2 1 990 1130n
preplace netloc CLK_IN1_D_0_1 1 0 1 NJ 1070
preplace netloc eth_mac_10g_fifo_core_0_rx_axis 1 3 2 1820 700 2170
preplace netloc eth_mac_10g_fifo_core_1_rx_axis 1 3 2 1830 1040 2170
preplace netloc ethernet_1_10_25g_0_gt_tx 1 3 2 N 610 N
preplace netloc gt_ref_clk_0_1 1 0 3 NJ 570 NJ 570 NJ
preplace netloc gt_rx_0_1 1 0 3 NJ 590 NJ 590 NJ
levelinfo -pg 1 -10 260 710 1280 2000 2250
pagesize -pg 1 -db -bbox -sgen -130 -10 2360 1590
"
}

  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


