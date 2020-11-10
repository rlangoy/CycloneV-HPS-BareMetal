// Testbench
module test;

  reg clk;
  reg reset;
   
  reg [7:0] address;
  reg read;
  reg [31:0]readdata;
  reg write;
  reg [31:0] writedata;
  
  
  // Instantiate design under test
  avs_mm_wraper DUT(.clk(clk), .reset(reset),
                    .avs_address(address),                     
                    .avs_read(read), 
                    .avs_readdata(readdata),
                    .avs_write(write),
                    .avs_writedata(writedata));
  
  
    initial 
    begin 
      clk   = 0; 
      reset = 1;
      #1
      reset = 0; 
      #1
      read  = 1;
      address =8'b0;
    end 

  
    always  
      #5  clk =  ! clk; 
  	always
  	  #50  address= 8'h01;

  
  
  initial  begin
    $display("\t\ttime,\tclk,\treset,\tread\taddress\treaddatat"); 
    $monitor("%d,\t%b,\t%b,\t%b,\t0x%h,\t0x%h",$time, clk,reset,read,address,readdata); 
    end 
   
  initial 
    #100  $finish; 
  

endmodule
