
`ifndef M_sync
`define M_sync

`ifndef MAKE
`include "src/DFF.v"
`endif

module sync #(
    parameter STAGES = 2,
    parameter RESET_VALUE = 0
)(
    input clk_in,
    input rst_ni,
    input serial_in,
    output serial_out
);
    wire [STAGES+1:0] reg_q;
    assign reg_q[0] = serial_in;
    genvar i;
    generate
        for (i = 0; i < STAGES; i=i+1) begin
            DFF #(
                .RESET_VALUE(RESET_VALUE)
            )u_dff(
                .clk(clk_in),
                .rst_n(rst_ni),
                .d(reg_q[i]),
                .q(reg_q[i+1])
            );
        end  
    endgenerate
    assign serial_out = reg_q[STAGES];
endmodule
`endif