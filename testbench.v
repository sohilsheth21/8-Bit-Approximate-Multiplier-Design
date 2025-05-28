`timescale 1ns / 1ps
module error_distance();
    reg [7:0]a,b;
    wire [15:0]p;
    reg [15:0]check; 
    integer  j,error;
    integer i =0;
    integer count = 0;
    integer t_e = 0;
    real med = 0.0;
    real mred=0.0;
    multiplier_8x8_struct uut(p,a,b);

   initial repeat(256) begin 
            a = i;
            i = i+1;
            #10;
            for (j=0; j<256; j=j+1) begin 
            b = j; 
            check = a*b;
            #20;            
            error = check - p ;
            #10;
            //calculating total error count
            if (error != 0)begin
                count = count+1;
            end
            if (error == 0)begin
                count = count;
            end
            if (error < 0) begin
                t_e = t_e - error;
            end
            if (error >= 0) begin
                t_e = t_e + error;
            end
	    if (check != 0) begin
    		if (error < 0) begin
        		mred = mred - (error*1.0 / check);
    		end
    	        if (error >= 0) begin
        		mred = mred + (error*1.0 / check);
   	        end
	    end

            #10;
            $display($time,"s %d*%d=%d(but %d)\nerror = %d\ncummulative error distance = %d\nerror count = %d\n", a,b,p,check,error,t_e,count);
            end
	//calculating performance metrics
	med = t_e/65536.0;
	mred=mred/65536.0;
	$display("Mean Error Distance (MED) = %f", med);
	$display("Mean Relative Error Distance (MRED) = %f", mred);
        
    end

endmodule