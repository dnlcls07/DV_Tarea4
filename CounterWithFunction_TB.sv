timeunit 1ps; //It specifies the time unit that all the delay will take in the simulation.
timeprecision 1ps;// It specifies the resolution in the simulation.

module CounterWithFunction_TB;

	parameter BASE_CLK = 50000000;
	parameter TARGET_FREQUENCY = 100000;
	parameter MAXIMUM_VALUE = CountValue(TARGET_FREQUENCY,BASE_CLK);
	parameter NBITS_FOR_COUNTER = CeilLog2(MAXIMUM_VALUE);

 // Input Ports
bit clk = 0;
bit reset;
bit enable;
	
  // Output Ports
logic [NBITS_FOR_COUNTER-1:0] CountOut; 
logic flag;

CounterWithFunction
#(
	// Parameter Declarations
	.BASE_CLK(BASE_CLK),
	.TARGET_FREQUENCY(TARGET_FREQUENCY),
	.MAXIMUM_VALUE(MAXIMUM_VALUE),
	.NBITS_FOR_COUNTER(NBITS_FOR_COUNTER)
)
DUT
(
	// Input Ports
	.clk(clk),
	.reset(reset),
	.enable(enable),
	
	// Output Ports
	.flag(flag),
	.CountOut(CountOut) 
);

//Procedural assignments
/*********************************************************/
initial // Clock generator
  begin
    forever #2 clk = !clk;
  end
/*********************************************************/
initial begin // reset generator
	#0 reset = 0;
	#5 reset = 1;
end

/*********************************************************/
initial begin // enable
	#0 enable = 1;
	#6 enable = 1;
end

/*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
   
 /*Log Function*/
     function integer CeilLog2;
       input integer data;
       integer i,result;
       begin
          for(i=0; 2**i < data; i=i+1)
             result = i + 1;
          CeilLog2 = result;
       end
    endfunction

/*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
 
  
 /*Counter Function*/
	function integer CountValue;
		input integer frequency;
		input integer base_clk;
		integer result;
		result = base_clk/(2*frequency);
		CountValue = result;
	endfunction
 
 /*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/

endmodule 