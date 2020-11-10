// Design
// Avalon memory interface
module avs_mm_wraper( 
  	         clk, // clock.clk
             reset, // reset.reset

             // Memory mapped read/write slave interface
             avs_address,
             avs_read,
             avs_write,
             avs_writedata,
             avs_readdata);
    
  //Clk and reset
  input      clk;
  input      reset;
  // Memory mapped read/write slave interface
  input [7:0]    avs_address;
  input	  avs_read;
  input	  avs_write;
  input  [31:0] avs_writedata;
  output [31:0]  avs_readdata;
  
  //--- Internal Reg and fun
    reg [31:0] 	 out_data;

  //Reset chip on start up
  always @(posedge clk or posedge reset)
  begin
    if (reset) begin
      // Asynchronous reset when reset goes high
       out_data  = 32'h00000000;
       crc32_sum = 32'h00000000;            
    end
  end

  //When Read signal is issued put out data
  always @(posedge avs_read)
  begin
           case (avs_address)
             8'h00   :   out_data=out_data+1;   // Incr val by 1 for each read
             8'h01   :   out_data=32'h204E5355;   // Display (USN)                        
             default :   out_data=32'h00000000;   // Display ZERO
          endcase    
  end
  
 // write data      
  assign avs_readdata = out_data;

endmodule
