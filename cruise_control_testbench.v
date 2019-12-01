`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2019 02:16:50 AM
// Design Name: 
// Module Name: cruise_control_testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module cruise_control_testbench;
	
	reg clk;
	reg reset, throttle, set,  accel, coast, cancel,  resume, brake;
	wire [7:0]current_speed;
	wire [7:0]cruise_set_speed;
	wire cruise_control_state;
	wire [2:0]current_state;wire [2:0]last_state; wire [7:0]last_set_speed;
	cruise_control uut (.clk(clk), .reset(reset), .throttle(throttle), .set(set), .accel(accel), .coast(coast),
						.cancel(cancel), .resume(resume), .brake(brake), .current_speed(current_speed),
						.cruise_set_speed(cruise_set_speed), .current_state(current_state), .last_state(last_state), .last_set_speed(last_set_speed) );
						
	initial begin
	clk = 0; reset = 0; throttle = 0; set = 0; accel = 0; coast = 0; cancel = 0; resume = 0; brake = 0;
	 
	 //reset test case
	 #10 reset = 1;
	 #9 reset = 0;
	 
	 //increase the speed of the cruise to 30 mph
	 #10 throttle = 1;
	 
	 //try to set the cruise to set = 30 mph which should fail
	 #(14*10) set = 1;
	 #9 set = 0;
	 
	 //turn off the throttle to decrease the speed upto 10 mph
	 #2 throttle = 0;
	 #200;
	 
	 //increase the speed upto 60 mph and not releasing the throttle 
	 throttle =1;
	 
	 #250 set = 1;
	 #10 set = 0;
	
	 //increase the speed upto 70 mph and turning off the throttle
	 #40 throttle = 0;
	 
	 //reaching the set point of 60 mph and then staying there for 5 clock cycles
	 #150;
	 
	 //applying brake to the system
	 brake = 1;
	 #10 brake = 0;
	 
	 //reaching to 40 mph and then resuming the cruise control
	 #85 resume = 1;
	 #10 resume = 0;
	
	 //reaching to speed 60mph and then staying there for 5 more cycles
	 #240; 
	 
	 //applying 5 consicutive accel signals to reach 65 mph and staying there for 5 cycles
	 accel = 1;
	 #10 accel = 0;
	 
	 #10 accel = 1;
	 #10 accel = 0;
	 
	 #10 accel = 1;
	 #10 accel = 0;
	 
	 #10 accel = 1;
	 #10 accel = 0;
	 
	 #10 accel = 1;
	 #10 accel = 0;
	 #50;
	 
	//applying 5 consicutive coast signals to reach 60 mph and staying there for 5 cycles
	 coast = 1;
	 #10 coast = 0;
	 
	 #10 coast = 1;
	 #10 coast = 0;
	 
	 #10 coast = 1;
	 #10 coast = 0;
	 
	 #10 coast = 1;
	 #10 coast = 0;
	 
	 #10 coast = 1;
	 #10 coast = 0;
	 #50;
	 
	 //applying cancel 
	 cancel = 1;
	 #600;
	 
	 #100;
	 
	 $finish;
	end
	
	always #5 clk = ~clk;
endmodule