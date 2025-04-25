set_property IOSTANDARD LVCMOS18 [get_ports KEY1]
set_property PACKAGE_PIN N26 [get_ports KEY1]

set_property IOSTANDARD LVDS [get_ports SYS_CLK_N]
set_property PACKAGE_PIN T24 [get_ports SYS_CLK_P]

set_property PACKAGE_PIN T7 [get_ports GTH_CLK0_P]
create_clock -period 6.400 -name gt_ref_clk [get_ports GTH_CLK0_P]


set_false_path -to [get_pins {system_i/ethernet_1_10_25g_0/inst/i_system_ethernet_1_10_25g_0_0_tx_reset_0_tx_clk_syncer_level/meta_reg[0]/D}]
set_false_path -to [get_pins {system_i/ethernet_1_10_25g_0/inst/i_system_ethernet_1_10_25g_0_0_rx_reset_0_rx_clk_syncer_level/meta_reg[0]/D}]
set_false_path -to [get_pins {system_i/ethernet_1_10_25g_0/inst/i_system_ethernet_1_10_25g_0_0_tx_reset_1_tx_clk_syncer_level/meta_reg[0]/D}]
set_false_path -to [get_pins {system_i/ethernet_1_10_25g_0/inst/i_system_ethernet_1_10_25g_0_0_rx_reset_1_rx_clk_syncer_level/meta_reg[0]/D}]

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 51.0 [current_design]

set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk]
