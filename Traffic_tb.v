module Traffic_tb;
    // Inputs
    reg clk;
    reg rst;
    
    // Outputs
    wire [3:0] NS;
    wire [3:0] EW;
    
    // Instantiate the Traffic module
    Traffic uut (
        .clk(clk),
        .rst(rst),
        .NS(NS),
        .EW(EW)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Generate clock with 10ns period
    end
    
    // Test stimulus
    initial begin
        // Initialize inputs
        rst = 1;
        
        // Wait 100 ns for global reset
        #100;
        
        // Release reset
        rst = 0;
        
        // Wait and observe state transitions
        // Green time = 10000 cycles, Yellow time = 1500 cycles
        
        // Wait for NS_Green
        #100000;  // Wait for green time
        
        // Now should be in NS_Yellow
        #15000;   // Wait for yellow time
        
        // Now should be in EW_Green
        #100000;  // Wait for green time
        
        // Now should be in EW_Yellow
        #15000;   // Wait for yellow time
        
        // Test reset during operation
        #1000;
        rst = 1;
        #100;
        rst = 0;
        
        // Continue monitoring for a few more cycles
        #300000;
        
        $finish;
    end
    
    // Monitor changes
    initial begin
        $monitor("Time=%0t rst=%b NS=%b EW=%b", $time, rst, NS, EW);
    end
    
    // Optional: Generate VCD file for waveform viewing
    initial begin
        $dumpfile("traffic_wave.vcd");
        $dumpvars(0, Traffic_tb);
    end
    
endmodule
