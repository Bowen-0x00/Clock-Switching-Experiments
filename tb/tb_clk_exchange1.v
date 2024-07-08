`timescale  1ns / 1ps

`ifndef MAKE
`include "src/clk_exchange1.v"
`endif
module tb_clk_exchange1;

// clk_exchange1 Parameters
parameter PERIOD_0  = 10;
parameter PERIOD_1  = 42;

// clk_exchange1 Inputs
reg   clk_in_0                             = 0 ;
reg   clk_in_1                             = 0 ;
reg   rst_n_0                              = 1 ;
reg   rst_n_1                              = 1 ;
reg   sel                                  = 0 ;

// clk_exchange1 Outputs
wire  clk_out                              ;


initial begin
    $dumpfile("tb_clk_exchange1.vcd");
    $dumpvars(0, tb_clk_exchange1);
end


initial
begin
    clk_in_0 = 0;
    forever #(PERIOD_0/2)  clk_in_0=~clk_in_0;
end

initial
begin
    #1
    rst_n_0 = 0;
    #(PERIOD_0*2) rst_n_0  =  1;
end
initial
begin
    clk_in_1 <= 0;
    forever #(PERIOD_1/2)  clk_in_1=~clk_in_1;
end

initial
begin
    # 1
    rst_n_1 = 0;
    #(PERIOD_0*2) rst_n_1  =  1;
end

clk_exchange1  u_clk_exchange1 (
    .clk_in_0                ( clk_in_0   ),
    .clk_in_1                ( clk_in_1   ),
    .rst_n_0                 ( rst_n_0    ),
    .rst_n_1                 ( rst_n_1    ),
    .sel                     ( sel        ),
    .clk_out                 ( clk_out    )
);

initial
begin
    sel <= 0;
    #500
    sel <= 1;
    #200
    sel <= 0;
    #500
    $finish;
end

endmodule