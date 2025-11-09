module timer #(parameter WIDTH = 32)(
    input  logic clk, rst_n,
    input  logic start,
    input  logic [WIDTH-1:0] load_value,
    output logic done
);
    logic [WIDTH-1:0] count;
    logic run;

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            run  <= 1'b0;
            done <= 1'b0;
            count <= '0;
        end else begin
            done <= 1'b0;
            if(start) begin
                run <= 1'b1;
                count <= load_value;
            end else if(run) begin
                if(count == 0) begin
                    run <= 1'b0;
                    done <= 1'b1;
                end else begin
                    count <= count - 1;
                end
            end
        end
    end
endmodule
