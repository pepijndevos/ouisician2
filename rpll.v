/**
     * PLL configuration
     *
     * This Verilog module was generated automatically
     * using the gowin-pll tool.
     * Use at your own risk.
     *
     * Target-Device:                GW1NR-9 C6/I5
     * Given input frequency:        100.000 MHz
     * Requested output frequency:   25.000 MHz
     * Achieved output frequency:    25.000 MHz
     */

    module pll(
            input  clock_in,
            output clock_out,
            output locked
        );

        rPLL #(
            .FCLKIN("100.0"),
            .IDIV_SEL(3), // -> PFD = 25.0 MHz (range: 3-400 MHz)
            .FBDIV_SEL(0), // -> CLKOUT = 25.0 MHz (range: 400-600 MHz)
            .ODIV_SEL(32) // -> VCO = 800.0 MHz (range: 600-1200 MHz)
        ) pll (.CLKOUTP(), .CLKOUTD(), .CLKOUTD3(), .RESET(1'b0), .RESET_P(1'b0), .CLKFB(1'b0), .FBDSEL(6'b0), .IDSEL(6'b0), .ODSEL(6'b0), .PSDA(4'b0), .DUTYDA(4'b0), .FDLY(4'b0), 
            .CLKIN(clock_in), // 100.0 MHz
            .CLKOUT(clock_out), // 25.0 MHz
            .LOCK(locked)
        );

    endmodule

    
