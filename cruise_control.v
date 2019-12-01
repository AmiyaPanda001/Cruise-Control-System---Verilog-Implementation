`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2019 02:05:35 AM
// Design Name: 
// Module Name: cruise_control
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

`define INIT 3'b000
`define NO_CRUISE_ACCELARATE 3'b001
`define NO_CRUISE_DECCELARATE 3'b010
`define CRUISE_ACCELARATE 3'b011
`define BRAKE 3'b100
`define CANCEL 3'b101


module cruise_control(input clk, input reset, throttle, set,  accel, coast, cancel,  resume, brake,
					  output reg [7:0]current_speed,
					  output reg [7:0]cruise_set_speed,
					  output reg cruise_control_state,
					  output [2:0]current_state,
					  output [2:0] last_state,
					  output [7:0]last_set_speed);
	
	reg [2:0]current_state;
	reg [2:0]next_state;
	reg [2:0]last_state;
	
	reg [7:0] last_set_speed;
	reg [7:0] interim_set_speed;
	
	always @(posedge clk) current_state <= next_state;
	always @(posedge reset) current_state <= `INIT;
	
	always @(posedge clk) last_state <= current_state;
	
	always @(cruise_set_speed) last_set_speed <= cruise_set_speed;
	
	always @(posedge set) if (current_speed >= 40) interim_set_speed <= current_speed;
	
	always @(*) begin
		case (current_state)
			`INIT : begin
						if (throttle == 1) next_state <= `NO_CRUISE_ACCELARATE;
						else next_state <= `INIT;
					end
			`NO_CRUISE_ACCELARATE : begin
										if (throttle == 0) next_state <= `NO_CRUISE_DECCELARATE;
										else if (set == 1 && current_speed > 40) next_state <= `CRUISE_ACCELARATE;
										else next_state <= `NO_CRUISE_ACCELARATE;
									end
			`NO_CRUISE_DECCELARATE : begin
										if (throttle == 1) next_state <= `NO_CRUISE_ACCELARATE;
										else if (throttle == 0  && current_speed == 0) next_state <= `INIT;
										else if (set == 1 && current_speed > 40) next_state <= `CRUISE_ACCELARATE;
										else next_state <= `NO_CRUISE_DECCELARATE;
									end
			`CRUISE_ACCELARATE: begin
									if (brake == 1) next_state <= `BRAKE;
									else if (cancel == 1) next_state <= `CANCEL;
									else next_state <= `CRUISE_ACCELARATE;
								end
			`BRAKE : begin
						if (current_speed == 0) next_state <= `INIT;
						else if (current_speed >= 40 && resume == 1) next_state <= `CRUISE_ACCELARATE;
						else next_state <= `BRAKE;
					end
			`CANCEL : begin
						if (current_speed == 0) next_state <= `INIT;
						else if (current_speed > 40 && resume == 1) next_state <= `CRUISE_ACCELARATE;
						else next_state <= `CANCEL;
					end
		endcase
	end
	
	always @(posedge clk, current_state) begin
		case (current_state) 
			`INIT : begin
						current_speed <= 0;
						cruise_control_state <= 0;
						cruise_set_speed <= 0;
					end
			`NO_CRUISE_ACCELARATE : begin
										if(next_state == `NO_CRUISE_ACCELARATE) current_speed <= current_speed + 2;
										cruise_control_state <= 0;
										cruise_set_speed <= 0;
									end
			`NO_CRUISE_DECCELARATE : begin
										if(next_state == `NO_CRUISE_DECCELARATE) current_speed <= current_speed - 1;
										cruise_control_state <= 0;
										cruise_set_speed <= 0;
									end
			`CRUISE_ACCELARATE : begin
									if (last_state == `NO_CRUISE_ACCELARATE || last_state == `NO_CRUISE_DECCELARATE) cruise_set_speed <= interim_set_speed;
									else if (last_state == `BRAKE || last_state == `CANCEL) cruise_set_speed <= interim_set_speed;
									else if (accel == 1 && cruise_set_speed > 40) cruise_set_speed <= cruise_set_speed + 1;
									else if (coast == 1 && cruise_set_speed > 40) cruise_set_speed <= cruise_set_speed - 1;
									else cruise_set_speed <= cruise_set_speed;
									
									if (throttle == 1) current_speed <= current_speed + 2;
									else if (throttle == 0 && current_speed > cruise_set_speed) current_speed <= current_speed - 1;
									else if (throttle == 0 && current_speed < cruise_set_speed) current_speed <= current_speed + 1;
									else if (throttle == 0 && current_speed == cruise_set_speed) current_speed <= last_set_speed;
									
									cruise_control_state <= 1;
								 end
			`BRAKE : begin
						current_speed <= current_speed - 2;
						cruise_control_state <= 0;
						cruise_set_speed <= 0;
					end
			`CANCEL : begin
						current_speed <= current_speed - 1;
						cruise_control_state <= 0;
						cruise_set_speed <= 0;
					end		
		endcase
	end

endmodule