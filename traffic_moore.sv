import tlc_pkg::*;

module traffic_moore(
    input  logic clk, rst_n,
    output light_t NS_light,
    output light_t EW_light
);
    state_t state, next_state;
    logic done;
    logic start_timer;
    logic [31:0] duration;

    timer u_timer(
        .clk(clk), .rst_n(rst_n),
        .start(start_timer),
        .load_value(duration),
        .done(done)
    );

    always_comb begin
        case(state)
            S_NS_G:      begin NS_light = GRN; EW_light = RED; duration = 32'd50; end
            S_NS_Y:      begin NS_light = YEL; EW_light = RED; duration = 32'd10; end
            S_ALL_RED_1: begin NS_light = RED; EW_light = RED; duration = 32'd5;  end
            S_EW_G:      begin NS_light = RED; EW_light = GRN; duration = 32'd50; end
            S_EW_Y:      begin NS_light = RED; EW_light = YEL; duration = 32'd10; end
            S_ALL_RED_2: begin NS_light = RED; EW_light = RED; duration = 32'd5;  end
        endcase
    end

    always_comb begin
        next_state = state;
        if(done) begin
            case(state)
                S_NS_G:      next_state = S_NS_Y;
                S_NS_Y:      next_state = S_ALL_RED_1;
                S_ALL_RED_1: next_state = S_EW_G;
                S_EW_G:      next_state = S_EW_Y;
                S_EW_Y:      next_state = S_ALL_RED_2;
                S_ALL_RED_2: next_state = S_NS_G;
            endcase
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            state <= S_NS_G;
        else
            state <= next_state;
    end

    assign start_timer = (state != next_state) | done;
endmodule
