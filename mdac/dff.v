module dff (
    input  wire clk,
    input  wire reset,
    input  wire d,
    output reg  q
);

wire nd, gda,gdb,gdc,gdd;

and_gate gd1(d, clk, gda);
not_gate gd2(gda,gdb);

not_gate(d,nd);

and_gate(nd, clk, gdc);
not_gate(gdc, gdd);



    always @(posedge clk) begin

    end

endmodule
