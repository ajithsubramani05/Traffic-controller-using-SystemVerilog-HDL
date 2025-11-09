import tlc_pkg::*;

module top(
    input  logic clk, rst_n,
    output light_t NS_light, EW_light
);
    traffic_moore dut(
        .clk(clk), 
        .rst_n(rst_n),
        .NS_light(NS_light),
        .EW_light(EW_light)
    );
endmodule
