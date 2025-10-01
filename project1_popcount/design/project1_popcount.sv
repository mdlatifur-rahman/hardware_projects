// Code your design here
//Streaming Popcount
module stpopcnt(
  
  input logic clk,
  input logic rst,
  input logic [31:0]a,
  output logic [5:0]count);
 
  logic [5:0] temp_sum;
  
  always@(posedge clk)
    if (rst==0)begin
      count<='0;
      temp_sum<='0;
    end 
    else begin 
	  temp_sum=0;
      for(int i=0;i<32;i++) begin 
        temp_sum += a[i];
        end
      count<= temp_sum;
    end
  
endmodule       
      
