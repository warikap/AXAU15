/*

Copyright (c) 2025 Marcin Zaremba

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

// Language: Verilog 2001

`timescale 1 ps / 1 ps

module Ethernet10Gtest
(
    input       SYS_CLK_N,
    input       SYS_CLK_P,
    input       GTH_CLK0_N,
    input       GTH_CLK0_P,
    
    input       KEY1,
    
    input       RX0_N,
    input       RX0_P,
    output      TX0_N,
    output      TX0_P,
    
    input       RX1_N,
    input       RX1_P,
    output      TX1_N,
    output      TX1_P
);

system system_i
(
    .SYS_CLK_clk_n(SYS_CLK_N),
    .SYS_CLK_clk_p(SYS_CLK_P),
    .ext_reset(KEY1),

    .gt_ref_clk_clk_n(GTH_CLK0_N),
    .gt_ref_clk_clk_p(GTH_CLK0_P),
    .gt_rx_0_gt_port_0_n(RX0_N),
    .gt_rx_0_gt_port_0_p(RX0_P),
    .gt_tx_0_gt_port_0_n(TX0_N),
    .gt_tx_0_gt_port_0_p(TX0_P),
    .gt_rx_0_gt_port_1_n(RX1_N),
    .gt_rx_0_gt_port_1_p(RX1_P),
    .gt_tx_0_gt_port_1_n(TX1_N),
    .gt_tx_0_gt_port_1_p(TX1_P)
);

endmodule
