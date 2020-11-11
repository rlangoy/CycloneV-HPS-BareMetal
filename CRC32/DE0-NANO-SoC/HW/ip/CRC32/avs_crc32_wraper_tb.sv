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
  avs_mm_crc32_wraper DUT(.clk(clk), .reset(reset),
                    .avs_address(address),                     
                    .avs_read(read), 
                    .avs_readdata(readdata),
                    .avs_write(write),
                    .avs_writedata(writedata));
  
  

  initial begin 
      read  = 0;
      clk   = 0; 
      reset = 1;
      write=0;
      address =8'b0;
      #1
      reset = 0; 
      #1
      writedata= 8'h1;
      write=1;
    
   	   
    end 

  
    always  
      #1  clk =  ! clk; 
   always
      #10  read=  ! read; 
   always
     #10  write=  ! write; 

  	always
  	  #50  writedata= 8'h2;
  	always
  	  #80  address= 8'h02;

  
  
  initial  begin
    $display("\t\ttime,\tclk,\treset,\tread\twrite\taddress\treaddatat"); 
    $monitor("%d,\t%b,\t%b,\t%b,\t0x%h,\t0x%h,\t0x%h",$time, clk,reset,read,write,address,readdata); 
    end 
   
  initial 
    #100  $finish; 
  

endmodule
