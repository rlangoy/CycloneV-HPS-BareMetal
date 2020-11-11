// Design
// Avalon memory interface
module avs_mm_crc32_wraper( 
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
  reg [31:0] 	 crc32_sum;
  reg [7:0]      data;
  wire[31:0]     out;

  crc crc32(.crcIn(crc32_sum),.data(data),.crcOut(out));

   //When Read signal is issued put out data
  always @(posedge avs_read or posedge reset or posedge avs_write)
  begin

    if (reset) // Asynchronous reset when reset goes high			
      begin
	        out_data  = 32'h00000000;
    		crc32_sum = 32'h00000000;
      end
    else if(avs_read)             // if pos edge of read
      begin
        if (avs_address == 8'h00) begin
          //    decode address and execute        
                            out_data=out;     // Incr val by 1 for each read
                            crc32_sum=out;
         end
      end         
  end
  
  always @(posedge avs_write)
  begin
	     if (avs_address == 8'h00)          //    decode address and execute
            data = avs_writedata & 8'hff;          
  
  end
  
 // write data from reg to outport     
  assign avs_readdata = out_data;

endmodule




module crc (crcIn, data, crcOut);
	input [31:0] crcIn;
	input [7:0] data;
	output [31:0] crcOut;

	assign crcOut[0] = (crcIn[2] ^ crcIn[8] ^ data[2]);
	assign crcOut[1] = (crcIn[0] ^ crcIn[3] ^ crcIn[9] ^ data[0] ^ data[3]);
	assign crcOut[2] = (crcIn[0] ^ crcIn[1] ^ crcIn[4] ^ crcIn[10] ^ data[0] ^ data[1] ^ data[4]);
	assign crcOut[3] = (crcIn[1] ^ crcIn[2] ^ crcIn[5] ^ crcIn[11] ^ data[1] ^ data[2] ^ data[5]);
	assign crcOut[4] = (crcIn[0] ^ crcIn[2] ^ crcIn[3] ^ crcIn[6] ^ crcIn[12] ^ data[0] ^ data[2] ^ data[3] ^ data[6]);
	assign crcOut[5] = (crcIn[1] ^ crcIn[3] ^ crcIn[4] ^ crcIn[7] ^ crcIn[13] ^ data[1] ^ data[3] ^ data[4] ^ data[7]);
	assign crcOut[6] = (crcIn[4] ^ crcIn[5] ^ crcIn[14] ^ data[4] ^ data[5]);
	assign crcOut[7] = (crcIn[0] ^ crcIn[5] ^ crcIn[6] ^ crcIn[15] ^ data[0] ^ data[5] ^ data[6]);
	assign crcOut[8] = (crcIn[1] ^ crcIn[6] ^ crcIn[7] ^ crcIn[16] ^ data[1] ^ data[6] ^ data[7]);
	assign crcOut[9] = (crcIn[7] ^ crcIn[17] ^ data[7]);
	assign crcOut[10] = (crcIn[2] ^ crcIn[18] ^ data[2]);
	assign crcOut[11] = (crcIn[3] ^ crcIn[19] ^ data[3]);
	assign crcOut[12] = (crcIn[0] ^ crcIn[4] ^ crcIn[20] ^ data[0] ^ data[4]);
	assign crcOut[13] = (crcIn[0] ^ crcIn[1] ^ crcIn[5] ^ crcIn[21] ^ data[0] ^ data[1] ^ data[5]);
	assign crcOut[14] = (crcIn[1] ^ crcIn[2] ^ crcIn[6] ^ crcIn[22] ^ data[1] ^ data[2] ^ data[6]);
	assign crcOut[15] = (crcIn[2] ^ crcIn[3] ^ crcIn[7] ^ crcIn[23] ^ data[2] ^ data[3] ^ data[7]);
	assign crcOut[16] = (crcIn[0] ^ crcIn[2] ^ crcIn[3] ^ crcIn[4] ^ crcIn[24] ^ data[0] ^ data[2] ^ data[3] ^ data[4]);
	assign crcOut[17] = (crcIn[0] ^ crcIn[1] ^ crcIn[3] ^ crcIn[4] ^ crcIn[5] ^ crcIn[25] ^ data[0] ^ data[1] ^ data[3] ^ data[4] ^ data[5]);
	assign crcOut[18] = (crcIn[0] ^ crcIn[1] ^ crcIn[2] ^ crcIn[4] ^ crcIn[5] ^ crcIn[6] ^ crcIn[26] ^ data[0] ^ data[1] ^ data[2] ^ data[4] ^ data[5] ^ data[6]);
	assign crcOut[19] = (crcIn[1] ^ crcIn[2] ^ crcIn[3] ^ crcIn[5] ^ crcIn[6] ^ crcIn[7] ^ crcIn[27] ^ data[1] ^ data[2] ^ data[3] ^ data[5] ^ data[6] ^ data[7]);
	assign crcOut[20] = (crcIn[3] ^ crcIn[4] ^ crcIn[6] ^ crcIn[7] ^ crcIn[28] ^ data[3] ^ data[4] ^ data[6] ^ data[7]);
	assign crcOut[21] = (crcIn[2] ^ crcIn[4] ^ crcIn[5] ^ crcIn[7] ^ crcIn[29] ^ data[2] ^ data[4] ^ data[5] ^ data[7]);
	assign crcOut[22] = (crcIn[2] ^ crcIn[3] ^ crcIn[5] ^ crcIn[6] ^ crcIn[30] ^ data[2] ^ data[3] ^ data[5] ^ data[6]);
	assign crcOut[23] = (crcIn[3] ^ crcIn[4] ^ crcIn[6] ^ crcIn[7] ^ crcIn[31] ^ data[3] ^ data[4] ^ data[6] ^ data[7]);
	assign crcOut[24] = (crcIn[0] ^ crcIn[2] ^ crcIn[4] ^ crcIn[5] ^ crcIn[7] ^ data[0] ^ data[2] ^ data[4] ^ data[5] ^ data[7]);
	assign crcOut[25] = (crcIn[0] ^ crcIn[1] ^ crcIn[2] ^ crcIn[3] ^ crcIn[5] ^ crcIn[6] ^ data[0] ^ data[1] ^ data[2] ^ data[3] ^ data[5] ^ data[6]);
	assign crcOut[26] = (crcIn[0] ^ crcIn[1] ^ crcIn[2] ^ crcIn[3] ^ crcIn[4] ^ crcIn[6] ^ crcIn[7] ^ data[0] ^ data[1] ^ data[2] ^ data[3] ^ data[4] ^ data[6] ^ data[7]);
	assign crcOut[27] = (crcIn[1] ^ crcIn[3] ^ crcIn[4] ^ crcIn[5] ^ crcIn[7] ^ data[1] ^ data[3] ^ data[4] ^ data[5] ^ data[7]);
	assign crcOut[28] = (crcIn[0] ^ crcIn[4] ^ crcIn[5] ^ crcIn[6] ^ data[0] ^ data[4] ^ data[5] ^ data[6]);
	assign crcOut[29] = (crcIn[0] ^ crcIn[1] ^ crcIn[5] ^ crcIn[6] ^ crcIn[7] ^ data[0] ^ data[1] ^ data[5] ^ data[6] ^ data[7]);
	assign crcOut[30] = (crcIn[0] ^ crcIn[1] ^ crcIn[6] ^ crcIn[7] ^ data[0] ^ data[1] ^ data[6] ^ data[7]);
	assign crcOut[31] = (crcIn[1] ^ crcIn[7] ^ data[1] ^ data[7]);
endmodule
