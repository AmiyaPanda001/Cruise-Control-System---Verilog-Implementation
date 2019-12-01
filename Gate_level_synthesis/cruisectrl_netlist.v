/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP3
// Date      : Thu Nov  7 20:02:28 2019
/////////////////////////////////////////////////////////////


module cruise_control_DW01_inc_0 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;

  wire   [7:2] carry;

  HAX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  XOR2X1 U2 ( .A(carry[7]), .B(A[7]), .Y(SUM[7]) );
  INVX1 U1 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module cruise_control_DW01_inc_1 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;

  wire   [7:2] carry;

  HAX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  XOR2X1 U2 ( .A(carry[7]), .B(A[7]), .Y(SUM[7]) );
  INVX1 U1 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module cruise_control ( clk, reset, throttle, set_6179, accel, coast, cancel, 
        resume, brake, current_speed, cruise_set_speed, cruise_control_state
 );
  output [7:0] current_speed;
  output [7:0] cruise_set_speed;
  input clk, reset, throttle, set_6179, accel, coast, cancel, resume, brake;
  output cruise_control_state;
  wire   n475, n476, n477, n478, n479, n480, n481, n482, n483, n484, n485,
         n486, n487, n488, n489, n490, \next_state[2] , N116, N217, N218, N219,
         N220, N221, N222, N223, N224, N270, N271, N272, N273, N274, N275,
         N276, N277, N362, N363, N364, N365, N366, N367, N368, N369, N370,
         n203, n210, n211, n213, n214, n215, n216, n217, n218, n221, n565,
         n566, n567, n568, n569, n570, n571, n572, n573, n574, n575, n576,
         n577, n578, n579, n580, n581, n582, n583, n584, n585, n586, n587,
         n588, n589, n590, n591, n592, n593, n594, n595, n596, n597, n598,
         n599, n600, n601, n602, n603, n604, n605, n606, n607, n608, n609,
         n610, n611, n612, n613, n614, n615, n616, n617, n618, n619, n620,
         n621, n622, n623, n624, n625, n626, n627, n628, n629, n630, n631,
         n632, n633, n634, n635, n636, n637, n638, n639, n640, n641, n642,
         n643, n644, n646, n647, n648, n649, n650, n651, n652, n653, n654,
         n655, n656, n657, n658, n659, n660, n661, n662, n663, n664, n665,
         n666, n667, n668, n669, n670, n671, n672, n673, n674, n675, n676,
         n677, n678, n679, n680, n681, n682, n683, n684, n685, n686, n687,
         n688, n689, n690, n691, n692, n693, n694, n695, n696, n697, n698,
         n699, n700, n701, n702, n703, n704, n705, n706, n707, n708, n709,
         n710, n711, n712, n713, n714, n715, n716, n717, n718, n719, n720,
         n721, n722, n723, n724, n725, n726, n727, n728, n729, n730, n731,
         n732, n733, n734, n735, n736, n737, n738, n739, n740, n741, n742,
         n743, n744, n745, n746, n747, n748, n749, n750, n751, n752, n753,
         n754, n755, n756, n757, n758, n764, n770, n771, n772, n774, n776,
         n778, n780, n782, n784, n786, n787, n788, n789, n790, n791, n792,
         n793, n794, n795, n796, n797, n798, n799, n800, n801, n802, n803,
         n804, n805, n806, n807, n808, n809, n810, n811, n812, n813, n814,
         n815, n816, n817, n818, n819, n820, n821, n822, n823, n824, n825,
         n826, n827, n828, n829, n830, n831, n832, n833, n834, n835, n836,
         n837, n838, n839, n840, n841, n842, n843, n844, n845, n846, n847,
         n848, n849, n850;
  wire   [2:0] current_state;
  wire   [2:0] last_state;
  wire   [7:0] interim_set_speed;

  DFFPOSX1 \cruise_set_speed_reg[0]  ( .D(N363), .CLK(clk), .Q(n489) );
  DFFPOSX1 \current_speed_reg[0]  ( .D(n221), .CLK(clk), .Q(N116) );
  DFFSR \current_state_reg[1]  ( .D(n813), .CLK(clk), .R(n846), .S(1'b1), .Q(
        current_state[1]) );
  DFFPOSX1 \last_state_reg[1]  ( .D(current_state[1]), .CLK(clk), .Q(
        last_state[1]) );
  DFFPOSX1 \current_speed_reg[1]  ( .D(n218), .CLK(clk), .Q(n481) );
  DFFPOSX1 \current_speed_reg[7]  ( .D(n217), .CLK(clk), .Q(n475) );
  DFFPOSX1 \current_speed_reg[6]  ( .D(n216), .CLK(clk), .Q(n476) );
  DFFPOSX1 \current_speed_reg[5]  ( .D(n215), .CLK(clk), .Q(n477) );
  DFFPOSX1 \current_speed_reg[2]  ( .D(n214), .CLK(clk), .Q(n480) );
  DFFPOSX1 \current_speed_reg[4]  ( .D(n213), .CLK(clk), .Q(n478) );
  DFFPOSX1 \interim_set_speed_reg[0]  ( .D(n801), .CLK(set_6179), .Q(
        interim_set_speed[0]) );
  DFFPOSX1 \interim_set_speed_reg[7]  ( .D(n211), .CLK(set_6179), .Q(
        interim_set_speed[7]) );
  DFFPOSX1 \interim_set_speed_reg[6]  ( .D(n210), .CLK(set_6179), .Q(
        interim_set_speed[6]) );
  DFFPOSX1 \interim_set_speed_reg[5]  ( .D(n833), .CLK(set_6179), .Q(
        interim_set_speed[5]) );
  DFFPOSX1 \interim_set_speed_reg[4]  ( .D(n832), .CLK(set_6179), .Q(
        interim_set_speed[4]) );
  DFFPOSX1 \interim_set_speed_reg[2]  ( .D(n831), .CLK(set_6179), .Q(
        interim_set_speed[2]) );
  DFFPOSX1 \interim_set_speed_reg[1]  ( .D(n828), .CLK(set_6179), .Q(
        interim_set_speed[1]) );
  DFFSR \current_state_reg[0]  ( .D(n756), .CLK(clk), .R(n846), .S(1'b1), .Q(
        current_state[0]) );
  DFFPOSX1 \last_state_reg[0]  ( .D(current_state[0]), .CLK(clk), .Q(
        last_state[0]) );
  DFFSR \current_state_reg[2]  ( .D(\next_state[2] ), .CLK(clk), .R(n846), .S(
        1'b1), .Q(current_state[2]) );
  DFFPOSX1 \last_state_reg[2]  ( .D(current_state[2]), .CLK(clk), .Q(
        last_state[2]) );
  DFFPOSX1 cruise_control_state_reg ( .D(N362), .CLK(clk), .Q(n490) );
  DFFPOSX1 \current_speed_reg[3]  ( .D(n203), .CLK(clk), .Q(n479) );
  DFFPOSX1 \interim_set_speed_reg[3]  ( .D(n830), .CLK(set_6179), .Q(
        interim_set_speed[3]) );
  DFFPOSX1 \cruise_set_speed_reg[3]  ( .D(N366), .CLK(clk), .Q(n486) );
  DFFPOSX1 \cruise_set_speed_reg[7]  ( .D(N370), .CLK(clk), .Q(n482) );
  DFFPOSX1 \cruise_set_speed_reg[6]  ( .D(N369), .CLK(clk), .Q(n483) );
  DFFPOSX1 \cruise_set_speed_reg[1]  ( .D(N364), .CLK(clk), .Q(n488) );
  DFFPOSX1 \cruise_set_speed_reg[2]  ( .D(N365), .CLK(clk), .Q(n487) );
  DFFPOSX1 \cruise_set_speed_reg[4]  ( .D(N367), .CLK(clk), .Q(n485) );
  DFFPOSX1 \cruise_set_speed_reg[5]  ( .D(N368), .CLK(clk), .Q(n484) );
  OR2X2 U217 ( .A(n651), .B(throttle), .Y(n648) );
  OR2X2 U218 ( .A(n659), .B(n660), .Y(n657) );
  NAND3X1 U293 ( .A(n565), .B(n566), .C(n567), .Y(n221) );
  AOI22X1 U294 ( .A(n568), .B(n800), .C(n797), .D(n489), .Y(n567) );
  OAI21X1 U295 ( .A(n811), .B(n569), .C(N116), .Y(n566) );
  NAND2X1 U296 ( .A(N270), .B(n570), .Y(n565) );
  NAND3X1 U297 ( .A(n571), .B(n572), .C(n573), .Y(n218) );
  AOI22X1 U298 ( .A(N271), .B(n570), .C(n797), .D(n488), .Y(n573) );
  NAND2X1 U299 ( .A(n569), .B(n784), .Y(n572) );
  NAND2X1 U300 ( .A(n808), .B(n809), .Y(n569) );
  AOI22X1 U301 ( .A(n481), .B(n574), .C(n575), .D(n568), .Y(n571) );
  OAI21X1 U302 ( .A(n804), .B(n800), .C(n576), .Y(n574) );
  NAND2X1 U303 ( .A(n577), .B(n578), .Y(n217) );
  AOI21X1 U304 ( .A(N277), .B(n570), .C(n579), .Y(n578) );
  OAI21X1 U305 ( .A(n475), .B(n580), .C(n581), .Y(n579) );
  OAI21X1 U306 ( .A(n582), .B(n583), .C(n475), .Y(n581) );
  OAI21X1 U307 ( .A(n476), .B(n808), .C(n584), .Y(n583) );
  OAI21X1 U308 ( .A(n585), .B(n568), .C(n476), .Y(n584) );
  AOI22X1 U309 ( .A(n586), .B(n824), .C(n587), .D(n826), .Y(n580) );
  NOR2X1 U310 ( .A(n808), .B(n782), .Y(n587) );
  NOR2X1 U311 ( .A(n476), .B(n809), .Y(n586) );
  AOI22X1 U312 ( .A(n815), .B(n568), .C(n797), .D(cruise_set_speed[7]), .Y(
        n577) );
  NAND2X1 U313 ( .A(n590), .B(n591), .Y(n216) );
  AOI22X1 U314 ( .A(n592), .B(n782), .C(n476), .D(n582), .Y(n591) );
  NAND3X1 U315 ( .A(n593), .B(n576), .C(n594), .Y(n582) );
  AOI22X1 U316 ( .A(n589), .B(n585), .C(n595), .D(n588), .Y(n594) );
  OAI21X1 U317 ( .A(current_speed[5]), .B(n596), .C(n568), .Y(n593) );
  OAI21X1 U318 ( .A(n808), .B(n588), .C(n805), .Y(n592) );
  NAND3X1 U319 ( .A(current_speed[4]), .B(current_speed[5]), .C(n827), .Y(n588) );
  AOI22X1 U320 ( .A(N276), .B(n570), .C(n797), .D(n483), .Y(n590) );
  NAND2X1 U321 ( .A(n598), .B(n599), .Y(n215) );
  AOI21X1 U322 ( .A(N275), .B(n570), .C(n600), .Y(n599) );
  OAI21X1 U323 ( .A(n601), .B(n602), .C(n603), .Y(n600) );
  OAI21X1 U324 ( .A(n604), .B(n605), .C(n477), .Y(n603) );
  OAI21X1 U325 ( .A(current_speed[4]), .B(n808), .C(n807), .Y(n605) );
  OAI22X1 U326 ( .A(n809), .B(n776), .C(n814), .D(n804), .Y(n604) );
  NAND2X1 U327 ( .A(n827), .B(n478), .Y(n602) );
  NAND2X1 U328 ( .A(n595), .B(n780), .Y(n601) );
  AOI21X1 U329 ( .A(n797), .B(n484), .C(n597), .Y(n598) );
  OAI21X1 U330 ( .A(n809), .B(n589), .C(n606), .Y(n597) );
  NAND3X1 U331 ( .A(n568), .B(n780), .C(n814), .Y(n606) );
  NAND3X1 U332 ( .A(n780), .B(n776), .C(n825), .Y(n589) );
  NAND3X1 U333 ( .A(n607), .B(n608), .C(n609), .Y(n214) );
  AOI22X1 U334 ( .A(n802), .B(n568), .C(n797), .D(n487), .Y(n609) );
  NAND2X1 U335 ( .A(N272), .B(n570), .Y(n608) );
  AOI22X1 U336 ( .A(n610), .B(n778), .C(n480), .D(n611), .Y(n607) );
  OAI21X1 U337 ( .A(n575), .B(n804), .C(n806), .Y(n611) );
  OAI22X1 U338 ( .A(n808), .B(n784), .C(n481), .D(n809), .Y(n610) );
  NAND3X1 U339 ( .A(n612), .B(n613), .C(n614), .Y(n213) );
  AOI22X1 U340 ( .A(N274), .B(n570), .C(n797), .D(n485), .Y(n614) );
  NAND2X1 U341 ( .A(n814), .B(n568), .Y(n613) );
  AOI22X1 U342 ( .A(n615), .B(n776), .C(n478), .D(n616), .Y(n612) );
  OAI21X1 U343 ( .A(n617), .B(n804), .C(n807), .Y(n616) );
  OAI21X1 U344 ( .A(n827), .B(n808), .C(n619), .Y(n618) );
  AOI21X1 U345 ( .A(n620), .B(n585), .C(n811), .Y(n619) );
  OAI22X1 U346 ( .A(n808), .B(n621), .C(n809), .D(n620), .Y(n615) );
  NAND3X1 U347 ( .A(current_speed[1]), .B(current_speed[3]), .C(
        current_speed[2]), .Y(n621) );
  AOI22X1 U348 ( .A(n623), .B(N116), .C(n770), .D(interim_set_speed[0]), .Y(
        n622) );
  OAI21X1 U349 ( .A(n623), .B(n837), .C(n829), .Y(n211) );
  OAI21X1 U350 ( .A(n623), .B(n838), .C(n782), .Y(n210) );
  AOI22X1 U351 ( .A(n623), .B(n477), .C(n770), .D(interim_set_speed[5]), .Y(
        n624) );
  AOI22X1 U352 ( .A(n623), .B(n478), .C(n770), .D(interim_set_speed[4]), .Y(
        n625) );
  AOI22X1 U353 ( .A(n623), .B(n480), .C(n770), .D(interim_set_speed[2]), .Y(
        n626) );
  AOI22X1 U354 ( .A(n623), .B(n481), .C(n770), .D(interim_set_speed[1]), .Y(
        n627) );
  NAND3X1 U355 ( .A(n628), .B(n629), .C(n630), .Y(n203) );
  AOI21X1 U356 ( .A(n617), .B(n568), .C(n631), .Y(n630) );
  OAI21X1 U357 ( .A(n632), .B(n633), .C(n634), .Y(n631) );
  OAI21X1 U358 ( .A(n635), .B(n636), .C(n479), .Y(n634) );
  OAI21X1 U359 ( .A(current_speed[2]), .B(n808), .C(n806), .Y(n636) );
  OAI21X1 U360 ( .A(current_speed[1]), .B(n808), .C(n638), .Y(n637) );
  AOI21X1 U361 ( .A(current_speed[1]), .B(n585), .C(n811), .Y(n638) );
  NAND3X1 U362 ( .A(n639), .B(n640), .C(n641), .Y(n576) );
  AND2X1 U363 ( .A(n642), .B(n643), .Y(n641) );
  OAI22X1 U364 ( .A(n809), .B(n778), .C(n802), .D(n804), .Y(n635) );
  NAND2X1 U365 ( .A(n480), .B(n481), .Y(n633) );
  NAND2X1 U366 ( .A(n595), .B(n774), .Y(n632) );
  OAI21X1 U367 ( .A(n847), .B(n771), .C(n642), .Y(n595) );
  OAI21X1 U368 ( .A(n822), .B(n646), .C(n647), .Y(n642) );
  NOR2X1 U369 ( .A(\next_state[2] ), .B(n812), .Y(n647) );
  OAI21X1 U370 ( .A(n771), .B(n648), .C(n649), .Y(n568) );
  AND2X1 U371 ( .A(n640), .B(n650), .Y(n649) );
  NAND3X1 U372 ( .A(n812), .B(n816), .C(n813), .Y(n640) );
  NAND2X1 U373 ( .A(n797), .B(n486), .Y(n629) );
  NAND3X1 U374 ( .A(n798), .B(n651), .C(n653), .Y(n652) );
  NOR2X1 U375 ( .A(throttle), .B(n771), .Y(n653) );
  AOI21X1 U376 ( .A(n654), .B(n655), .C(n656), .Y(n651) );
  OAI22X1 U377 ( .A(n657), .B(n658), .C(n782), .D(cruise_set_speed[6]), .Y(
        n655) );
  AOI21X1 U378 ( .A(current_speed[4]), .B(n844), .C(n661), .Y(n660) );
  OAI22X1 U379 ( .A(n484), .B(n780), .C(n662), .D(n663), .Y(n661) );
  OAI21X1 U380 ( .A(current_speed[3]), .B(n841), .C(n664), .Y(n663) );
  OAI21X1 U381 ( .A(n487), .B(n778), .C(n665), .Y(n664) );
  AOI22X1 U382 ( .A(n666), .B(n835), .C(current_speed[3]), .D(n841), .Y(n665)
         );
  AOI22X1 U383 ( .A(n825), .B(n585), .C(N273), .D(n570), .Y(n628) );
  OAI21X1 U384 ( .A(n669), .B(n810), .C(n670), .Y(n570) );
  NAND3X1 U385 ( .A(n668), .B(n847), .C(n757), .Y(n670) );
  OAI21X1 U386 ( .A(n656), .B(n671), .C(n654), .Y(n668) );
  NAND2X1 U387 ( .A(cruise_set_speed[7]), .B(n829), .Y(n654) );
  AOI21X1 U388 ( .A(cruise_set_speed[6]), .B(n782), .C(n672), .Y(n671) );
  NOR2X1 U389 ( .A(n658), .B(n673), .Y(n672) );
  OAI21X1 U390 ( .A(n484), .B(n780), .C(n674), .Y(n673) );
  OAI21X1 U391 ( .A(current_speed[4]), .B(n844), .C(n675), .Y(n674) );
  AOI21X1 U392 ( .A(n836), .B(n676), .C(n659), .Y(n675) );
  NOR2X1 U393 ( .A(n845), .B(current_speed[5]), .Y(n659) );
  OAI21X1 U394 ( .A(current_speed[3]), .B(n799), .C(n677), .Y(n676) );
  OAI21X1 U395 ( .A(n774), .B(n678), .C(n486), .Y(n677) );
  OAI22X1 U396 ( .A(current_speed[2]), .B(n843), .C(n679), .D(n667), .Y(n678)
         );
  XNOR2X1 U397 ( .A(n487), .B(n778), .Y(n667) );
  AOI22X1 U398 ( .A(n680), .B(n489), .C(n488), .D(n784), .Y(n679) );
  NOR2X1 U399 ( .A(N116), .B(n666), .Y(n680) );
  NOR2X1 U400 ( .A(n784), .B(n488), .Y(n666) );
  XNOR2X1 U401 ( .A(n485), .B(n776), .Y(n662) );
  XOR2X1 U402 ( .A(cruise_set_speed[6]), .B(current_speed[6]), .Y(n658) );
  NOR2X1 U403 ( .A(n829), .B(cruise_set_speed[7]), .Y(n656) );
  OAI21X1 U404 ( .A(n681), .B(n669), .C(n682), .Y(n585) );
  NAND3X1 U405 ( .A(n778), .B(n784), .C(n774), .Y(n620) );
  AOI22X1 U406 ( .A(n623), .B(n479), .C(n770), .D(interim_set_speed[3]), .Y(
        n683) );
  OAI21X1 U407 ( .A(n803), .B(n837), .C(n684), .Y(N370) );
  AOI22X1 U408 ( .A(cruise_set_speed[7]), .B(n685), .C(N224), .D(n795), .Y(
        n684) );
  OAI22X1 U409 ( .A(n789), .B(n771), .C(n772), .D(n794), .Y(n685) );
  NAND2X1 U410 ( .A(n687), .B(n688), .Y(N369) );
  AOI22X1 U411 ( .A(n689), .B(n483), .C(n787), .D(n772), .Y(n688) );
  NOR2X1 U412 ( .A(n789), .B(n771), .Y(n689) );
  OAI21X1 U413 ( .A(n691), .B(n692), .C(n693), .Y(n690) );
  NOR2X1 U414 ( .A(n484), .B(n694), .Y(n691) );
  AOI22X1 U415 ( .A(N223), .B(n795), .C(interim_set_speed[6]), .D(n686), .Y(
        n687) );
  NAND2X1 U416 ( .A(n695), .B(n696), .Y(N368) );
  AOI21X1 U417 ( .A(n484), .B(n697), .C(n787), .Y(n696) );
  NAND3X1 U418 ( .A(n699), .B(n845), .C(n788), .Y(n698) );
  OAI21X1 U419 ( .A(n788), .B(n794), .C(n792), .Y(n697) );
  AOI22X1 U420 ( .A(N222), .B(n795), .C(interim_set_speed[5]), .D(n686), .Y(
        n695) );
  NAND2X1 U421 ( .A(n700), .B(n701), .Y(N367) );
  AOI22X1 U422 ( .A(n485), .B(n702), .C(N221), .D(n795), .Y(n701) );
  OAI21X1 U423 ( .A(n841), .B(n794), .C(n786), .Y(n702) );
  AOI22X1 U424 ( .A(n788), .B(n699), .C(interim_set_speed[4]), .D(n686), .Y(
        n700) );
  NAND3X1 U425 ( .A(n844), .B(n841), .C(n790), .Y(n694) );
  NAND2X1 U426 ( .A(n704), .B(n705), .Y(N366) );
  AOI22X1 U427 ( .A(n706), .B(n790), .C(N220), .D(n795), .Y(n705) );
  NOR2X1 U428 ( .A(n486), .B(n794), .Y(n706) );
  AOI22X1 U429 ( .A(n486), .B(n703), .C(interim_set_speed[3]), .D(n686), .Y(
        n704) );
  OAI21X1 U430 ( .A(n790), .B(n794), .C(n792), .Y(n703) );
  NAND2X1 U431 ( .A(n707), .B(n708), .Y(N365) );
  AOI22X1 U432 ( .A(n487), .B(n709), .C(N219), .D(n795), .Y(n708) );
  OAI21X1 U433 ( .A(n842), .B(n794), .C(n791), .Y(n709) );
  AOI22X1 U434 ( .A(n790), .B(n699), .C(interim_set_speed[2]), .D(n686), .Y(
        n707) );
  NAND2X1 U435 ( .A(n712), .B(n713), .Y(N364) );
  AOI22X1 U436 ( .A(n714), .B(n699), .C(N218), .D(n795), .Y(n713) );
  NOR2X1 U437 ( .A(n489), .B(n488), .Y(n714) );
  AOI22X1 U438 ( .A(n488), .B(n710), .C(interim_set_speed[1]), .D(n686), .Y(
        n712) );
  OAI21X1 U439 ( .A(n796), .B(n794), .C(n792), .Y(n710) );
  NAND2X1 U440 ( .A(n716), .B(n717), .Y(N363) );
  AOI22X1 U441 ( .A(N217), .B(n795), .C(n715), .D(n489), .Y(n717) );
  NOR2X1 U442 ( .A(n693), .B(n771), .Y(n715) );
  OAI21X1 U443 ( .A(n793), .B(n718), .C(n719), .Y(n693) );
  NOR2X1 U444 ( .A(accel), .B(coast), .Y(n718) );
  NAND3X1 U445 ( .A(n719), .B(n720), .C(n722), .Y(n721) );
  NOR2X1 U446 ( .A(n771), .B(n849), .Y(n722) );
  AOI22X1 U447 ( .A(n699), .B(n796), .C(interim_set_speed[0]), .D(n686), .Y(
        n716) );
  OAI21X1 U448 ( .A(n771), .B(n719), .C(n723), .Y(n686) );
  NOR2X1 U449 ( .A(n692), .B(n771), .Y(n699) );
  NAND3X1 U450 ( .A(n720), .B(n849), .C(n724), .Y(n692) );
  AND2X1 U451 ( .A(n719), .B(coast), .Y(n724) );
  XOR2X1 U452 ( .A(last_state[1]), .B(n725), .Y(n719) );
  NOR2X1 U453 ( .A(last_state[0]), .B(last_state[2]), .Y(n725) );
  OAI21X1 U454 ( .A(n726), .B(n845), .C(n727), .Y(n720) );
  NOR2X1 U455 ( .A(cruise_set_speed[6]), .B(cruise_set_speed[7]), .Y(n727) );
  AOI21X1 U456 ( .A(n486), .B(n711), .C(n485), .Y(n726) );
  NAND3X1 U457 ( .A(n842), .B(n796), .C(n843), .Y(n711) );
  NAND2X1 U458 ( .A(n771), .B(n723), .Y(N362) );
  OAI21X1 U459 ( .A(n818), .B(n728), .C(n681), .Y(n723) );
  NOR2X1 U460 ( .A(n646), .B(n812), .Y(n681) );
  NAND2X1 U461 ( .A(n729), .B(n669), .Y(n728) );
  NAND3X1 U463 ( .A(n812), .B(n646), .C(\next_state[2] ), .Y(n682) );
  NAND3X1 U464 ( .A(n731), .B(n819), .C(n732), .Y(\next_state[2] ) );
  OAI21X1 U465 ( .A(brake), .B(cancel), .C(n817), .Y(n732) );
  OAI21X1 U466 ( .A(n820), .B(n821), .C(n734), .Y(n731) );
  AND2X1 U467 ( .A(n735), .B(n736), .Y(n734) );
  NOR2X1 U468 ( .A(n737), .B(n738), .Y(n646) );
  OAI21X1 U469 ( .A(n736), .B(n650), .C(n739), .Y(n738) );
  AOI22X1 U470 ( .A(n740), .B(n817), .C(n741), .D(n847), .Y(n739) );
  OAI21X1 U471 ( .A(n815), .B(n730), .C(n729), .Y(n741) );
  NOR2X1 U472 ( .A(cancel), .B(brake), .Y(n740) );
  OAI21X1 U473 ( .A(n848), .B(n742), .C(n743), .Y(n737) );
  NOR2X1 U474 ( .A(n744), .B(n733), .Y(n743) );
  NAND2X1 U475 ( .A(n822), .B(n745), .Y(n742) );
  NAND3X1 U476 ( .A(n823), .B(n840), .C(current_state[0]), .Y(n729) );
  NAND2X1 U477 ( .A(n746), .B(n747), .Y(n756) );
  AOI22X1 U478 ( .A(n733), .B(current_state[0]), .C(n748), .D(n735), .Y(n747)
         );
  NAND3X1 U479 ( .A(n782), .B(n780), .C(n749), .Y(n735) );
  NOR2X1 U480 ( .A(n475), .B(n596), .Y(n749) );
  NAND2X1 U481 ( .A(n617), .B(n776), .Y(n596) );
  NOR2X1 U482 ( .A(n644), .B(current_speed[3]), .Y(n617) );
  OAI21X1 U483 ( .A(n730), .B(n750), .C(n751), .Y(n748) );
  NOR2X1 U484 ( .A(n744), .B(n821), .Y(n751) );
  NAND3X1 U485 ( .A(current_state[2]), .B(n823), .C(current_state[0]), .Y(n650) );
  NOR2X1 U486 ( .A(n736), .B(n669), .Y(n744) );
  NAND3X1 U487 ( .A(n839), .B(n823), .C(current_state[2]), .Y(n669) );
  NAND2X1 U488 ( .A(resume), .B(n623), .Y(n736) );
  OAI21X1 U489 ( .A(n780), .B(n774), .C(n834), .Y(n623) );
  NAND2X1 U490 ( .A(set_6179), .B(n745), .Y(n750) );
  OAI21X1 U491 ( .A(n774), .B(n752), .C(n834), .Y(n745) );
  OAI21X1 U492 ( .A(n780), .B(n776), .C(n754), .Y(n753) );
  NOR2X1 U493 ( .A(current_speed[6]), .B(n475), .Y(n754) );
  NAND2X1 U494 ( .A(current_speed[5]), .B(n644), .Y(n752) );
  NAND2X1 U495 ( .A(n575), .B(n778), .Y(n644) );
  NOR2X1 U496 ( .A(current_speed[1]), .B(N116), .Y(n575) );
  NOR2X1 U497 ( .A(n840), .B(n823), .Y(n733) );
  AOI22X1 U498 ( .A(throttle), .B(n755), .C(n817), .D(n850), .Y(n746) );
  OAI21X1 U499 ( .A(current_state[2]), .B(current_state[1]), .C(n730), .Y(n755) );
  NAND2X1 U500 ( .A(n643), .B(n839), .Y(n730) );
  NAND2X1 U501 ( .A(n643), .B(current_state[0]), .Y(n639) );
  NOR2X1 U502 ( .A(n823), .B(current_state[2]), .Y(n643) );
  cruise_control_DW01_inc_0 add_129_S2 ( .A({cruise_set_speed[7:6], n484, n485, 
        n486, n487, n488, n489}), .SUM({N224, N223, N222, N221, N220, N219, 
        N218, N217}) );
  cruise_control_DW01_inc_1 r129 ( .A({n475, current_speed[6:1], N116}), .SUM(
        {N277, N276, N275, N274, N273, N272, N271, N270}) );
  AND2X2 U503 ( .A(n817), .B(n682), .Y(n757) );
  INVX2 U504 ( .A(n482), .Y(n758) );
  INVX8 U505 ( .A(n758), .Y(cruise_set_speed[7]) );
  INVX8 U506 ( .A(n800), .Y(current_speed[0]) );
  INVX1 U507 ( .A(N116), .Y(n800) );
  INVX8 U508 ( .A(n844), .Y(cruise_set_speed[4]) );
  INVX1 U509 ( .A(n485), .Y(n844) );
  INVX8 U510 ( .A(n843), .Y(cruise_set_speed[2]) );
  INVX1 U511 ( .A(n487), .Y(n843) );
  INVX8 U512 ( .A(n842), .Y(cruise_set_speed[1]) );
  INVX1 U513 ( .A(n488), .Y(n842) );
  INVX2 U514 ( .A(n490), .Y(n764) );
  INVX8 U515 ( .A(n764), .Y(cruise_control_state) );
  INVX8 U516 ( .A(n829), .Y(current_speed[7]) );
  INVX1 U517 ( .A(n475), .Y(n829) );
  INVX8 U518 ( .A(n841), .Y(cruise_set_speed[3]) );
  INVX1 U519 ( .A(n486), .Y(n841) );
  INVX8 U520 ( .A(n845), .Y(cruise_set_speed[5]) );
  INVX1 U521 ( .A(n484), .Y(n845) );
  INVX8 U522 ( .A(n796), .Y(cruise_set_speed[0]) );
  INVX1 U523 ( .A(n489), .Y(n796) );
  INVX2 U524 ( .A(n595), .Y(n808) );
  INVX2 U525 ( .A(n757), .Y(n771) );
  INVX2 U526 ( .A(n623), .Y(n770) );
  INVX2 U527 ( .A(n477), .Y(n780) );
  INVX2 U528 ( .A(n476), .Y(n782) );
  INVX2 U529 ( .A(n483), .Y(n772) );
  INVX2 U530 ( .A(n479), .Y(n774) );
  INVX2 U531 ( .A(n478), .Y(n776) );
  INVX2 U532 ( .A(n480), .Y(n778) );
  INVX2 U533 ( .A(n481), .Y(n784) );
  INVX8 U534 ( .A(n772), .Y(cruise_set_speed[6]) );
  INVX8 U535 ( .A(n774), .Y(current_speed[3]) );
  INVX8 U536 ( .A(n776), .Y(current_speed[4]) );
  INVX8 U537 ( .A(n778), .Y(current_speed[2]) );
  INVX8 U538 ( .A(n780), .Y(current_speed[5]) );
  INVX8 U539 ( .A(n782), .Y(current_speed[6]) );
  INVX8 U540 ( .A(n784), .Y(current_speed[1]) );
  INVX2 U541 ( .A(n703), .Y(n786) );
  INVX2 U542 ( .A(n698), .Y(n787) );
  INVX2 U543 ( .A(n694), .Y(n788) );
  INVX2 U544 ( .A(n690), .Y(n789) );
  INVX2 U545 ( .A(n711), .Y(n790) );
  INVX2 U546 ( .A(n710), .Y(n791) );
  INVX2 U547 ( .A(n715), .Y(n792) );
  INVX2 U548 ( .A(n720), .Y(n793) );
  INVX2 U549 ( .A(n699), .Y(n794) );
  INVX2 U550 ( .A(n721), .Y(n795) );
  INVX2 U551 ( .A(n652), .Y(n797) );
  INVX2 U552 ( .A(n668), .Y(n798) );
  INVX2 U553 ( .A(n678), .Y(n799) );
  INVX2 U554 ( .A(n622), .Y(n801) );
  INVX2 U555 ( .A(n644), .Y(n802) );
  INVX2 U556 ( .A(n686), .Y(n803) );
  INVX2 U557 ( .A(n568), .Y(n804) );
  INVX2 U558 ( .A(n597), .Y(n805) );
  INVX2 U559 ( .A(n637), .Y(n806) );
  INVX2 U560 ( .A(n618), .Y(n807) );
  INVX2 U561 ( .A(n585), .Y(n809) );
  INVX2 U562 ( .A(n681), .Y(n810) );
  INVX2 U563 ( .A(n576), .Y(n811) );
  INVX2 U564 ( .A(n756), .Y(n812) );
  INVX2 U565 ( .A(n646), .Y(n813) );
  INVX2 U566 ( .A(n596), .Y(n814) );
  INVX2 U567 ( .A(n735), .Y(n815) );
  INVX2 U568 ( .A(\next_state[2] ), .Y(n816) );
  INVX2 U569 ( .A(n639), .Y(n817) );
  INVX2 U570 ( .A(n730), .Y(n818) );
  INVX2 U571 ( .A(n733), .Y(n819) );
  INVX2 U572 ( .A(n669), .Y(n820) );
  INVX2 U573 ( .A(n650), .Y(n821) );
  INVX2 U574 ( .A(n729), .Y(n822) );
  INVX2 U575 ( .A(current_state[1]), .Y(n823) );
  INVX2 U576 ( .A(n589), .Y(n824) );
  INVX2 U577 ( .A(n620), .Y(n825) );
  INVX2 U578 ( .A(n588), .Y(n826) );
  INVX2 U579 ( .A(n621), .Y(n827) );
  INVX2 U580 ( .A(n627), .Y(n828) );
  INVX2 U581 ( .A(n683), .Y(n830) );
  INVX2 U582 ( .A(n626), .Y(n831) );
  INVX2 U583 ( .A(n625), .Y(n832) );
  INVX2 U584 ( .A(n624), .Y(n833) );
  INVX2 U585 ( .A(n753), .Y(n834) );
  INVX2 U586 ( .A(n667), .Y(n835) );
  INVX2 U587 ( .A(n662), .Y(n836) );
  INVX2 U588 ( .A(interim_set_speed[7]), .Y(n837) );
  INVX2 U589 ( .A(interim_set_speed[6]), .Y(n838) );
  INVX2 U590 ( .A(current_state[0]), .Y(n839) );
  INVX2 U591 ( .A(current_state[2]), .Y(n840) );
  INVX2 U592 ( .A(reset), .Y(n846) );
  INVX2 U593 ( .A(throttle), .Y(n847) );
  INVX2 U594 ( .A(set_6179), .Y(n848) );
  INVX2 U595 ( .A(accel), .Y(n849) );
  INVX2 U596 ( .A(brake), .Y(n850) );
endmodule

