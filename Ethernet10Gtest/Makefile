# FPGA settings
FPGA_PART = xcau15p-ffvb676-2-i
FPGA_TOP = Ethernet10Gtest

# Files for synthesis
SYN_FILES = src/rtl/Ethernet10Gtest.v
SYN_FILES += src/rtl/eth_mac_10g_fifo_core.v
SYN_FILES += ../lib/verilog-axis/rtl/axis_adapter.v
SYN_FILES += ../lib/verilog-axis/rtl/axis_async_fifo.v
SYN_FILES += ../lib/verilog-axis/rtl/axis_async_fifo_adapter.v
SYN_FILES += ../lib/verilog-ethernet/rtl/axis_xgmii_rx_32.v
SYN_FILES += ../lib/verilog-ethernet/rtl/axis_xgmii_rx_64.v
SYN_FILES += ../lib/verilog-ethernet/rtl/axis_xgmii_tx_32.v
SYN_FILES += ../lib/verilog-ethernet/rtl/axis_xgmii_tx_64.v
SYN_FILES += ../lib/verilog-ethernet/rtl/eth_mac_10g.v
SYN_FILES += ../lib/verilog-ethernet/rtl/eth_mac_10g_fifo.v
SYN_FILES += ../lib/verilog-ethernet/rtl/lfsr.v
SYN_FILES += ../lib/verilog-ethernet/rtl/ptp_clock_cdc.v
SYN_FILES += ../lib/verilog-ethernet/rtl/mac_ctrl_tx.v
SYN_FILES += ../lib/verilog-ethernet/rtl/mac_ctrl_rx.v
SYN_FILES += ../lib/verilog-ethernet/rtl/mac_pause_ctrl_tx.v
SYN_FILES += ../lib/verilog-ethernet/rtl/mac_pause_ctrl_rx.v

# XDC files
XDC_FILES = src/constr/Ethernet10Gtest.xdc
XDC_FILES += ../lib/verilog-ethernet/syn/vivado/eth_mac_fifo.tcl
XDC_FILES += ../lib/verilog-ethernet/lib/axis/syn/vivado/axis_async_fifo.tcl

# IP and BD
TCL_FILES = src/bd/system.tcl

include ../common/vivado.mk
