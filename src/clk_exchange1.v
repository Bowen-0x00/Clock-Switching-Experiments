`ifndef M_clk_exchange1
`define M_clk_exchange1

`ifndef MAKE
`include "src/DFF.v"
`include "src/sync.v"
`endif
module clk_exchange1(
    input clk_in_0,
    input clk_in_1,
    input rst_n_0,
    input rst_n_1,
    input sel,
    output clk_out
);
    wire sel_bar;
    wire sel_result_0;
    wire sel_sync_0;
    wire sel_sample_0;
    wire sel_fb_0;
    wire clk_and_0;

    wire sel_result_1;
    wire sel_sync_1;
    wire sel_sample_1;
    wire sel_fb_1;
    wire clk_and_1;

    assign sel_bar = ~sel;
    assign sel_result_0 = sel_bar & sel_fb_1;

    sync #(
        .STAGES(2),
        .RESET_VALUE(0)
    ) u_sync_0(
        .clk_in(clk_in_0),
        .rst_ni(rst_n_0),
        .serial_in(sel_result_0),
        .serial_out(sel_sync_0)
    );
    DFF_N #(
        .RESET_VALUE(0)
    )u_dffn_0(
        .clk(clk_in_0),
        .rst_n(rst_n_0),
        .d(sel_sync_0),
        .q(sel_sample_0)
    );
    assign sel_fb_0 = ~sel_sample_0;
    assign clk_and_0 = clk_in_0 & sel_sample_0;

    assign sel_result_1 = sel & sel_fb_0;

    sync #(
        .STAGES(2),
        .RESET_VALUE(1)
    ) u_sync_1(
        .clk_in(clk_in_1),
        .rst_ni(rst_n_1),
        .serial_in(sel_result_1),
        .serial_out(sel_sync_1)
    );
    DFF_N #(
        .RESET_VALUE(1)
    )u_dffn_1(
        .clk(clk_in_1),
        .rst_n(rst_n_1),
        .d(sel_sync_1),
        .q(sel_sample_1)
    );
    assign sel_fb_1 = ~sel_sample_1;
    assign clk_and_1 = clk_in_1 & sel_sample_1;

    assign clk_out = clk_and_0 | clk_and_1;

endmodule
`endif