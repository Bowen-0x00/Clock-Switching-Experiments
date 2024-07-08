
`ifndef M_DFF
`define M_DFF

module DFF #(
    parameter RESET_VALUE = 0
)(
    input clk,
    input rst_n,
    input d,
    output reg q
);
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) q <= RESET_VALUE;
        else #1 q <= d;
    end 

endmodule

`endif


`ifndef m_DFF_N
`define m_DFF_N

module DFF_N #(
    parameter RESET_VALUE = 0
)(
    input clk,
    input rst_n,
    input d,
    output reg q
);
    always @(negedge clk or negedge rst_n) begin
        if (~rst_n) q <= RESET_VALUE;
        else #2 q <= d;
    end 

endmodule

`endif