

module tb_mdac;

    reg        clk;
    reg        reset;
    reg [3:0]  btn;
    reg        enter;
    reg        clear;

    wire       locked;
    wire       unlocked;
    wire       error;
    wire [2:0] state;

    mdac_top dut (
        .clk(clk),
        .reset(reset),
        .btn(btn),
        .enter(enter),
        .clear(clear),
        .locked(locked),
        .unlocked(unlocked),
        .error(error),
        .state(state)
    );

    // Toggle the clock every 5 ns, giving a full period of 10 ns.
    always #5 clk = ~clk;

    task press_button;
        input [3:0] value;
        begin
            @(negedge clk);
            btn = value;
            @(negedge clk);
            btn = 4'b0000;
        end
    endtask

    task press_enter;
        begin
            @(negedge clk);
            enter = 1'b1;
            @(negedge clk);
            enter = 1'b0;
        end
    endtask

    initial begin
        // Optional waveform output; open mdac.vcd with GTKWave to inspect it.
        $dumpfile("mdac.vcd");
        $dumpvars(0, tb_mdac);

        clk   = 1'b0;
        reset = 1'b1;
        btn   = 4'b0000;
        enter = 1'b0;
        clear = 1'b0;

        // Initialize all inputs, then hold synchronous reset through clock edges.
        repeat (3) @(posedge clk);
        @(negedge clk);
        reset = 1'b0;

        press_button(4'b0001);

        // An invalid multi-button press must not advance the stored sequence.
        @(negedge clk);
        btn = 4'b0011;
        @(negedge clk);
        btn = 4'b0000;

        press_button(4'b0010);
        press_button(4'b0100);
        press_button(4'b1000);
        press_enter();
        repeat (2) @(posedge clk);

        // Clear returns the controller to LOCKED.
        @(negedge clk);
        clear = 1'b1;
        @(negedge clk);
        clear = 1'b0;

        // End the simulation. Note: this testbench prints a waveform but does
        // not yet contain assertions that automatically pass/fail each test.
        repeat (3) @(posedge clk);
        $finish;
    end

endmodule
