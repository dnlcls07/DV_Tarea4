module CounterWithFunction
#(
	// Parameter Declarations
	parameter BASE_CLK = 50000000,	//FPGA base clock frequency obtained internally
	parameter TARGET_FREQUENCY = 100000,	//Frequency to obtain at the output
	parameter MAXIMUM_VALUE = CountValue(TARGET_FREQUENCY,BASE_CLK),	//Count to obtain the target frequency
	parameter NBITS_FOR_COUNTER = CeilLog2(MAXIMUM_VALUE)					//
)

(
	// Input Ports
	input clk,
	input reset,
	input enable,
	
	// Output Ports
	output flag,
	output[NBITS_FOR_COUNTER-1:0] CountOut 
);

bit MaxValue_Bit;

logic [NBITS_FOR_COUNTER-1 : 0] Count_logic;
	
	always_ff@(posedge clk or negedge reset) begin
		if (reset == 1'b0)
			begin
			Count_logic <= {NBITS_FOR_COUNTER{1'b0}};
			MaxValue_Bit <= 1'b0;
			end
		else begin
				if(enable == 1'b1)
					if(Count_logic == MAXIMUM_VALUE - 1)
						begin
						Count_logic <= 0;
						MaxValue_Bit <= ~(MaxValue_Bit);
						end
					else
						Count_logic <= Count_logic + 1'b1;
		end
	end

//--------------------------------------------------------------------------------------------
/*
always_comb
	if(Count_logic == MAXIMUM_VALUE-1)
		MaxValue_Bit = 1;
	else
		MaxValue_Bit = 0;

*/		
//---------------------------------------------------------------------------------------------
assign flag = MaxValue_Bit;

assign CountOut = Count_logic;
//----------------------------------------------------------------------------------------------

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
