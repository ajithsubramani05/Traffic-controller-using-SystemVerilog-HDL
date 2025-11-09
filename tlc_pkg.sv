package tlc_pkg;
    // Traffic light color encoding {R,Y,G}
    typedef enum logic [2:0] {RED=3'b100, YEL=3'b010, GRN=3'b001} light_t;

    // FSM States
    typedef enum logic [2:0] {
        S_NS_G      = 3'd0,
        S_NS_Y      = 3'd1,
        S_ALL_RED_1 = 3'd2,
        S_EW_G      = 3'd3,
        S_EW_Y      = 3'd4,
        S_ALL_RED_2 = 3'd5
    } state_t;
endpackage
