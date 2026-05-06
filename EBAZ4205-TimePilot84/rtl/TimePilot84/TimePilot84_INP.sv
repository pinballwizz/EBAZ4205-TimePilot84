//============================================================================
// 
//  					TimePilot84 Input Module
//
//============================================================================

module TimePilot84_INP
(
	input         [15:0] dip_sw,
	input          [1:0] coin,                     //0 = coin 1, 1 = coin 2
	input          [1:0] start_buttons,            //0 = Player 1, 1 = Player 2
	input          [3:0] p1_joystick, p2_joystick, //0 = up, 1 = down, 2 = left, 3 = right
	input          [2:0] p1_buttons,
	input          [1:0] p2_buttons,
	input                btn_service,
	input                cpubrd_A5, cpubrd_A6,
	input                cs_controls_dip1, cs_dip2,
	input                irq_trigger, cs_sounddata,
	output         [7:0] controls_dip	
);

//------------------------------------------------------- Signal outputs -------------------------------------------------------//

//Multiplex controls and DIP switches to be output to CPU board

wire [7:0] controls_dip1;

assign controls_dip = cs_controls_dip1 ? controls_dip1:
                      cs_dip2          ? dip_sw[15:8]:
                      8'hFF;

//--------------------------------------------------- Controls & DIP switches --------------------------------------------------//

//Multiplex player inputs and DIP switch bank 1

assign controls_dip1 = ({cpubrd_A6, cpubrd_A5} == 2'b00) ? {3'b111, start_buttons, btn_service, coin}:
                           ({cpubrd_A6, cpubrd_A5} == 2'b01) ? {1'b1, p1_buttons, p1_joystick[1:0], p1_joystick[3:2]}:
                           ({cpubrd_A6, cpubrd_A5} == 2'b10) ? {2'b11, p2_buttons, p2_joystick[1:0], p2_joystick[3:2]}:
                           ({cpubrd_A6, cpubrd_A5} == 2'b11) ? dip_sw[7:0]:
                           8'hFF;
						   
//------------------------------------------------------------------------------------------------------------------------------//

endmodule
