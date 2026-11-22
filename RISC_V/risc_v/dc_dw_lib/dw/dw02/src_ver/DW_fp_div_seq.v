////////////////////////////////////////////////////////////////////////////////
//
//       This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Synopsys Inc.
//     In the event of publication, the following notice is applicable:
//
//                    (C) COPYRIGHT 2006 - 2016 SYNOPSYS INC.
//                           ALL RIGHTS RESERVED
//
//       The entire notice above must be reproduced on all authorized
//     copies.
//
// AUTHOR:    Kyung-Nam Han, Sep. 25, 2006
//
// VERSION:   Verilog Simulation Model for DW_fp_div_seq
//
// DesignWare_version: 67525c4c
// DesignWare_release: L-2016.03-DWBB_201603.1
//
////////////////////////////////////////////////////////////////////////////////

//-----------------------------------------------------------------------------
//
// ABSTRACT: Floating-Point Sequencial Divider
//
//              DW_fp_div_seq calculates the floating-point division
//              while supporting six rounding modes, including four IEEE
//              standard rounding modes.
//
//              parameters      valid values (defined in the DW manual)
//              ==========      ============
//              sig_width       significand size,  2 to 253 bits
//              exp_width       exponent size,     3 to 31 bits
//              ieee_compliance support the IEEE Compliance
//                              0 - IEEE 754 compatible without denormal support
//                                  (NaN becomes Infinity, Denormal becomes Zero)
//                              1 - IEEE 754 standard compatible
//                                  (NaN and denormal numbers are supported)
//              num_cyc         Number of cycles required for the FP sequential
//                              division operation including input and output
//                              register. Actual number of clock cycle is
//                              num_cyc - (1 - input_mode) - (1 - output_mode)
//                               - early_start + internal_reg
//              rst_mode        Synchronous / Asynchronous reset
//                              0 - Asynchronous reset
//                              1 - Synchronous reset
//              input_mode      Input register setup
//                              0 - No input register
//                              1 - Input registers are implemented
//              output_mode     Output register setup
//                              0 - No output register
//                              1 - Output registers are implemented
//              early_start     Computation start (only when input_mode = 1)
//                              0 - start computation in the 2nd cycle
//                              1 - start computation in the 1st cycle (forwarding)
//                              early_start should be 0 when input_mode = 0
//              internal_reg    Insert a register between an integer sequential divider
//                              and a normalization unit
//                              0 - No internal register
//                              1 - Internal register is implemented
//
//              Input ports     Size & Description
//              ===========     ==================
//              a               (sig_width + exp_width + 1)-bits
//                              Floating-point Number Input
//              b               (sig_width + exp_width + 1)-bits
//                              Floating-point Number Input
//              rnd             3 bits
//                              Rounding Mode Input
//              clk             Clock
//              rst_n           Reset. (active low)
//              start           Start operation
//                              A new operation is started by setting start=1
//                              for 1 clock cycle
//              z               (sig_width + exp_width + 1)-bits
//                              Floating-point Number Output
//              status          8 bits
//                              Status Flags Output
//              complete        Operation completed
//
// Modified:
//   6/05/07 KYUNG (0703-SP3)
//           The legal range of num_cyc parameter widened.
//   3/25/08 KYUNG (0712-SP3)
//           Fixed the reset error (STAR 9000234177)
//   1/29/10 KYUNG (D-2010.03)
//           1. Removed synchronous DFF when rst_mode = 0 (STAR 9000367314)
//           2. Fixed complete signal error at the reset  (STAR 9000371212)
//           3. Fixed divide_by_zero flag error           (STAR 9000371212)
//   2/27/12 RJK (F-2011.09-SP4)
//           Added missing message when input changes during calculation
//           while input_mode=0 (STAR 9000523798)
//   9/22/14 KYUNG (J-2014.09-SP1)
//           Modified for the support of VCS NLP feature
//   9/22/15 RJK (K-2015.06-SP3) Further update for NLP compatibility
//   2/26/16 LMSU
//           Updated to use blocking and non-blocking assigments in
//           the correct way
//-----------------------------------------------------------------------------
//
//    9/25/12  RJK (G-2012.06-SP3)
//            Corrected data corruption detection to catch input changes
//            during the first cycle of calculation (related to STAR 9000523798)

module DW_fp_div_seq (a, b, rnd, clk, rst_n, start, z, status, complete);

  parameter sig_width = 23;      // RANGE 2 TO 253
  parameter exp_width = 8;       // RANGE 3 TO 31
  parameter ieee_compliance = 0; // RANGE 0 TO 1
  parameter num_cyc = 4;         // RANGE 4 TO (2 * sig_width + 3)
  parameter rst_mode = 0;        // RANGE 0 TO 1
  parameter input_mode = 1;      // RANGE 0 TO 1
  parameter output_mode = 1;     // RANGE 0 TO 1
  parameter early_start = 0;     // RANGE 0 TO 1
  parameter internal_reg = 1;    // RANGE 0 TO 1


  localparam TOTAL_WIDTH = (sig_width + exp_width + 1);


//-----------------------------------------------------------------------------

  input [(exp_width + sig_width):0] a;
  input [(exp_width + sig_width):0] b;
  input [2:0] rnd;
  input clk;
  input rst_n;
  input start;

  output [(exp_width + sig_width):0] z;
  output [8    -1:0] status;
  output complete;

// synopsys translate_off

//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------

  
 
  initial begin : parameter_check
    integer param_err_flg;

    param_err_flg = 0;
    
    
    if ( (sig_width < 2) || (sig_width > 253) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter sig_width (legal range: 2 to 253)",
	sig_width );
    end
    
    if ( (exp_width < 3) || (exp_width > 31) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter exp_width (legal range: 3 to 31)",
	exp_width );
    end
    
    if ( (ieee_compliance < 0) || (ieee_compliance > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter ieee_compliance (legal range: 0 to 1)",
	ieee_compliance );
    end
    
    if ( (num_cyc < 4) || (num_cyc > 2*sig_width+3) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter num_cyc (legal range: 4 to 2*sig_width+3)",
	num_cyc );
    end
    
    if ( (rst_mode < 0) || (rst_mode > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter rst_mode (legal range: 0 to 1)",
	rst_mode );
    end
    
    if ( (input_mode < 0) || (input_mode > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter input_mode (legal range: 0 to 1)",
	input_mode );
    end
    
    if ( (output_mode < 0) || (output_mode > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter output_mode (legal range: 0 to 1)",
	output_mode );
    end
    
    if ( (early_start < 0) || (early_start > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter early_start (legal range: 0 to 1)",
	early_start );
    end
    
    if ( (internal_reg < 0) || (internal_reg > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter internal_reg (legal range: 0 to 1)",
	internal_reg );
    end
    
    if ( (input_mode===0 && early_start===1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m : Invalid parameter combination: when input_mode=0, early_start=1 is not possible" );
    end
  
    if ( param_err_flg == 1) begin
      $display(
        "%m :\n  Simulation aborted due to invalid parameter value(s)");
      $finish;
    end

  end // parameter_check 


//-----------------------------------------------------------------------------

  function integer cycle_cont;

  input l,m,n;
  integer l,m,n;
  begin
    if  ((l===1) & (m===1) & (n===0))
      cycle_cont = 3;
    else if  ((l===0) & (m===0) & (n===0))
      cycle_cont = 1;
    else if  ((l===1) & (m===0) & (n===1))
      cycle_cont = 1;
    else
      cycle_cont = 2;
  end
  endfunction

  `ifdef UPF_POWER_AWARE
  `protected
L+W3@05FPNRe[J-9[#I]RfaA(9eBU_HJ\XC9S+EAbXac+,&)bff_))HHZA@)\6>b
PMBTCGXdG+T/HT08SAD<,4NYPJZZQXQ;I02E555H.S)?\IcA_Nd1@DgfSZgI1]++
5ea+ADdA_N9J2)KYQJ;aWKdX:bC/_a@8-\f0ZQE;;Eb7(2XdO1@[<E95[,?N@T6T
CG,.gg?a_@gJ*$
`endprotected

  `else
  integer CYC_CONT;
  `endif
  integer count;
  integer next_count;
  integer cnt_glitch;

  reg  [(exp_width + sig_width):0] ina;
  reg  [(exp_width + sig_width):0] inb;
  reg  [(exp_width + sig_width):0] next_ina;
  reg  [(exp_width + sig_width):0] next_inb;
  reg  [(exp_width + sig_width):0] next_z;
  reg  [(exp_width + sig_width):0] a_reg;
  reg  [(exp_width + sig_width):0] b_reg;
  reg  [(exp_width + sig_width):0] next_int_z;
  reg  [(exp_width + sig_width):0] int_z;
  reg  [(exp_width + sig_width):0] int_z_d1;
  reg  [(exp_width + sig_width):0] int_z_d2;
  reg  [7:0] next_int_status;
  reg  [7:0] int_status;
  reg  [7:0] int_status_d1;
  reg  [7:0] int_status_d2;
  reg  [7:0] next_status;
  reg  [2:0] rnd_reg;
  reg  next_complete;
  reg  new_input;
  reg  new_input_pre;
  reg  new_input_reg_d1;
  reg  new_input_reg_d2;
  reg  next_int_complete;
  reg  int_complete;
  reg  int_complete_d1;
  reg  int_complete_d1_syn;
  reg  int_complete_d1_asyn;
  reg  int_complete_d2;
  reg  int_complete_d2_syn;
  reg  int_complete_d2_asyn;
  reg  count_reseted;
  reg  next_count_reseted;

  wire [(exp_width + sig_width):0] ina_div;
  wire [(exp_width + sig_width):0] inb_div;
  wire [(exp_width + sig_width):0] z;
  wire [(exp_width + sig_width):0] temp_z;
  wire [(exp_width + sig_width):0] a_new;
  wire [(exp_width + sig_width):0] b_new;
  wire [7:0] status;
  wire [7:0] temp_status;
  wire [2:0] rnd_new;
  wire [1:0] output_cont;
  wire clk, rst_n;
  wire complete;
  wire start_n;
  wire start_in;

  reg  start_clk;
  reg  rst_n_clk;
  reg  reset_st;
  wire rst_n_rst;

  initial
  begin
    `ifndef UPF_POWER_AWARE
    CYC_CONT = (internal_reg) ?
                 cycle_cont(input_mode, output_mode, early_start) + 1:
                 cycle_cont(input_mode, output_mode, early_start);
    `endif
    new_input_pre = 0;
    next_count_reseted = 0;
  end

  wire corrupt_data;

generate
  if (input_mode == 0) begin : GEN_IM_EQ_0

    localparam [0:0] NO_OUT_REG = (output_mode == 0)? 1'b1 : 1'b0;
    reg [TOTAL_WIDTH-1:0] ina_hist;
    reg [TOTAL_WIDTH-1:0] inb_hist;
    wire next_corrupt_data;
    reg  corrupt_data_int;
    wire data_input_activity;
    reg  init_complete;
    wire next_alert1;
    integer change_count;

    assign next_alert1 = next_corrupt_data & rst_n & init_complete &
                                    ~start & ~complete;

    if (rst_mode == 0) begin : GEN_A_RM_EQ_0
      always @ (posedge clk or negedge rst_n) begin : ar_hist_regs_PROC
	if (rst_n === 1'b0) begin
	    ina_hist        <= a;
	    inb_hist        <= b;
	    change_count    <= 0;

	  init_complete   <= 1'b0;
	  corrupt_data_int <= 1'b0;
	end else begin
	  if ( rst_n === 1'b1) begin
	      ina_hist        <= a;
	      inb_hist        <= b;
	      change_count    <= (start == 1'b1)? 0 :
	                         (next_alert1 == 1'b1)? change_count + 1 : change_count;
	    init_complete   <= init_complete | start;
	    corrupt_data_int<= next_corrupt_data | (corrupt_data_int & ~start);
	  end else begin
	    ina_hist        <= {TOTAL_WIDTH{1'bx}};
	    inb_hist        <= {TOTAL_WIDTH{1'bx}};
	    change_count    <= -1;
	    init_complete   <= 1'bx;
	    corrupt_data_int <= 1'bX;
	  end
	end
      end
    end else begin : GEN_A_RM_NE_0
      always @ (posedge clk) begin : sr_hist_regs_PROC
	if (rst_n === 1'b0) begin
	    ina_hist        <= a;
	    inb_hist        <= b;
	    change_count    <= 0;
	  init_complete   <= 1'b0;
	  corrupt_data_int <= 1'b0;
	end else begin
	  if ( rst_n === 1'b1) begin
	      ina_hist        <= a;
	      inb_hist        <= b;
	      change_count    <= (start == 1'b1)? 0 :
	                         (next_alert1 == 1'b1)? change_count + 1 : change_count;
	    init_complete   <= init_complete | start;
	    corrupt_data_int<= next_corrupt_data | (corrupt_data_int & ~start);
	  end else begin
	    ina_hist        <= {TOTAL_WIDTH{1'bx}};
	    inb_hist        <= {TOTAL_WIDTH{1'bx}};
	    init_complete    <= 1'bx;
	    corrupt_data_int <= 1'bX;
	    change_count     <= -1;
	  end
	end
      end
    end // GEN_A_RM_NE_0

    assign data_input_activity =  (((a !== ina_hist)?1'b1:1'b0) |
				 ((b !== inb_hist)?1'b1:1'b0)) & rst_n;

    assign next_corrupt_data = (NO_OUT_REG | ~complete) &
                              (data_input_activity & ~start &
					init_complete);

`ifdef UPF_POWER_AWARE
  `protected
Y:9c-R[@V@JWY]75G6g57?de4=/c=X7B[8PY?9^.73ae0L<;]IS@))#JY8.I3FCE
5&1eY9I_1UV,+J<T<8)0,;BJJX-+;1#+2f,CNM)b1ROX8#^9#F75#b:JCaD0#HWV
@[8QHZ?FH1?aUVTN6aC@D>12M6^>>7[SIOe+Q&K5)efNg20gD^BUdc-bQPTeB\G3
PO,BA)UB&)V/EN;ZKR+/V5LfVAP9?X6Ff_4./,6H(<B=2AK]9,d\4ZD,He89733f
\01VDM1\Gb:[PE-R2?5^4U3[S8,0VE]]U(#ZACQA_bPg-Q1RMH\(YA-UI@fE8=a4
f5(SD[>c:Ag+Q5//AeDN?/fLcJO<BGXGL802M[F][,/QF;M>41I5ffJc,YLaVJ+g
\KGXHZ,.c880K(L\(PSbaUW20.<gB8[X(c_:R6J<IM88]7H52HL?(T8O:8E85)6^
&=?gX[65La(c1D8.D0R1gNL;.QYQFRgARI-XXbT=?>ecN(S:^0X7ZIQ:MV=083RD
]&0f2[&V&VeFCL2cLeITI,TZ5/NH48&T.:&]_D,LLSK>T-51BW_6@5A&&Eb/)1B/
N5U^@ZcB:VOJ?:+MW^HHH_J]]Ob/U>D]-C9bAZ[W5d4BM2S9cW1\H=\/76B7f5O8
M1:;BZI8V-#SW3Y_<_8;MLe#(WU#7)[@2JbQOcYd):7b/^H-ReKLLDecFS2SBO,Q
GfCTQA1\6ec=b64;NWZJ1c847bgb7(;YTeBcO<P;8YG<VZbMRbC]IW):5HcQN+&H
KIEPB6&S,Z_>F,<_X&^\Y?A-eM;0.O1F=R?=NDY#Y5L)dUd;Pa>f:42ZFVZ/G1,(
29B.WD[Ag<X67L&)G4.E2W?5A99N;<81B:SU7e>/YD5/A]T@P?@fV.0d.g5ACCN9
?G9\MXG;TH7)dU-:?P5#4Gb8I9-8TDEW/5LO_F)fY;^?+bPa]E)-Oa_KCCHL1I/B
?RSDTBTa0LR8M)a-V>1gGE>\/B@&8fEWe1P/4Y-J:P#EaXI@2Qe/GFC07Z7W1I)H
57b=X9+42;5P^>L04P(c?HA1S6I-6,K@VL.;g,8ZW,QAOOO0C>fATJ)8NE-ZT@XF
H1I^_:ET7P[/\dNSTbKJ6,F1(?>F6>;_2-#::<GZ?+N&^X_..<EgRW/@LcAUEB(<
Ce>^VRQAI,EZ+/.)<^\YGY1?QPTR]7_QVQ/a>/W&?]TIQ@8+>(MYSc@\3fN/5<.f
CeS@0AFX0(IfN/N_P^37IAWC</N.aB^?.6<eRf68->dB[:bdW]DJWYA/+JB;,APb
RVN\(3GB;X+K<7C3eZFC8B/<0<07[03FA7U\4C5Mb9Z@NK0A(GJ]Cg;5-FT_Y45)
c_,HBf06[b/fbYL6)NLfAH,3,BQa::LF)YbebWHF0\F<d2Ja9DH1JN@RbD5O-3G/
K8;R0<SOgE2G7=/)WC5F./>G#1]+G0)Q0@ZNHc]gWcX9A/9J/[D(NPefNcG@6BG(
F^8?:SZY#DK43P(<46U2e<F,fUa4)ZF^(ZOeH+Te.;f@+G_-#Md:EU[e3+MOI?4.
M#f8K6(AD_/>\@?I?39S2e_C.eaH69,5f;6O=VAA/Ra0GX;K4<a9W5JQbHfF@9W-
APC9-R;#E370E>&-WM=2@+=WIA@>KR,f-V2_f.W9cPJ/@DU6ZJf+,CQ#c3HI#3Pc
1Z2G)=gFU+?\520,-2U1YI(TU.LL<K7?2VUYYN[(f,Af@@eJU8)fcPERB[Nc,3R6
>T7e6Y7eG03-R5YA;JfQ&WI<+9G).X7c.)ONgCH#P?H<MY5ZQ#eB5JggO=c/=cB-
@e:a6cDKK94fDPR^:WH\IJfFc#CdO_S11\f6L;.P.\\K/,;U^)U_<BD#P[6bT@gR
c#D,);d^9cS4#d9]Jg<VV-+G_;4JA>fCb9_@7;#@:1<]Y9,8BX.9\<fEP51+b7/3
Z^:MT=_ZeN]B1O\#e-(3E;FP&a:\Od/@/_Eb(KR6@+D?]C9VY/NJ2gXX3AgYV=UE
:L@]>YEPISS]\\@fU]^^;YXdR_31e1Je5bfRfY4COMDE4Md7D_[SA\XRU5gE=1gU
5aG+4,3e5@M.7g6eAJ0)\fA3_Q@T1H7H6L=bNZVRW=9:2XKGV?,AQJ1QeIfY1IW/
ZGP6cL]bQ1SD>4_gHeR7XNd7TYSWebND0AF5f)c3VP,NPR91ZC3?KQ8#3(EQ/Z2>
c>@V8Acfc>]^(]ecDb&].L+bS0N1&Z6RS=E7bZ.?K:@0M;^SR/DMR=8W@(ODZKg2
XV,T+EQE=ZQR)_JQMVJ,A8;Y)^]I6B<VOUHL.bSV-S(R#0d-?ee:30fa(aU\b&dE
f3N#V&1;6MC#eURdX3,RGB=)LbB=0D>.B]BV0Zca,XVFN?4E#fM>aI/BaB0A3TaeQ$
`endprotected

`else
    always @ (posedge clk) begin : corrupt_alert_PROC
      integer updated_count;

      updated_count = change_count;

      if (next_alert1 == 1'b1) begin
        $display("## Warning from %m: DW_fp_div_seq operand input change near %0d will cause corrupted results if operation is allowed to complete.", $time);
	updated_count = updated_count + 1;
      end

      if (((rst_n & init_complete & ~start & ~complete & next_complete) == 1'b1) &&
          (updated_count > 0)) begin
	$display(" ");
	$display("############################################################");
	$display("############################################################");
	$display("##");
	$display("## Error!! : from %m");
	$display("##");
	$display("##    This instance of DW_fp_div_seq has encountered %0d change(s)", updated_count);
	$display("##    on operand input(s) after starting the calculation.");
	$display("##    The instance is configured with no input register.");
	$display("##    So, the result of the operation was corrupted.  This");
	$display("##    message is generated at the point of completion of");
	$display("##    the operation (at time %0d), separate warning(s) were", $time );
	$display("##    generated earlier during calculation.");
	$display("##");
	$display("############################################################");
	$display("############################################################");
	$display(" ");
      end
    end
`endif

    assign corrupt_data = corrupt_data_int;

  if (output_mode == 0) begin : GEN_OM_EQ_0
    reg  alert2_issued;
    wire next_alert2;

    assign next_alert2 = next_corrupt_data & rst_n & init_complete &
                                     ~start & complete & ~alert2_issued;

`ifdef UPF_POWER_AWARE
  `protected
>=TggFEU6F1C.I)8eO3W5;26bBG9)UK1U7Z6;X9Q:5Y1J>9ONHaW-)9QP7#\Ee2e
F<\#;3U&XJ7Z58LE^B7M;3O<2IPOa7P-GPY.=,55,@0a3PL0)C.<R;&B1IFD^+)V
<1V53_?()^JQd1#1eX7.YP@(g=8-\SI2e0H0K@G?eUN2d0Wa(I:^^JTZ@EMVG64Y
50+eC=/4&GNS=Q.OFGLbTFQ7)a\@<f4D=gdQeMQ8]eNcL[;c&bd[RF-H65e+#/3-
1BJg;_JJISFf5+f;I?#N@,5CgAL:.=<1/cA@MZIG012:aKO3,J<DfXZ)M/g,e<Zb
O5=PE#>-]6554TEIH>WbOMcAXQOPH]4V^,FV0R3R=a&6/K&8Wb?/3Y8G5V1&^+Y4
1>454K:(I-^e/,P=PYE80(3XV4IEGN9YA3TO];5NI6aKL+L,eb;7&EJc74EW(geP
f>I4FV^ZL\<:dB3.QWbWd5/#FB+\[73fgJgJJd]=>,(-\/2f[U91LWXWB2a80.@7W$
`endprotected

`else
    always @ (posedge clk) begin : corrupt_alert2_PROC
      if (next_alert2 == 1'b1) begin
        $display( "## Warning from %m: DW_fp_div_seq operand input change near %0d causes output to no longer retain result of previous operation.", $time);
      end
    end
`endif

    if (rst_mode == 0) begin : GEN_AI_REG_AR
      always @ (posedge clk or negedge rst_n) begin : ar_alrt2_reg_PROC
        if (rst_n == 1'b0) alert2_issued <= 1'b0;

	  else alert2_issued <= ~start & (alert2_issued | next_alert2);
      end
    end else begin : GEN_AI_REG_SR
      always @ (posedge clk) begin : sr_alrt2_reg_PROC
        if (rst_n == 1'b0) alert2_issued <= 1'b0;

	  else alert2_issued <= ~start & (alert2_issued | next_alert2);
      end
    end

  end  // GEN_OM_EQ_0

  // GEN_IM_EQ_0
  end else begin : GEN_IM_NE_0
    assign corrupt_data = 1'b0;
  end // GEN_IM_NE_0
endgenerate

  assign z = (reset_st) ? 0 :
             (~input_mode & new_input) ? {TOTAL_WIDTH{1'bx}} :
             (output_cont == 2) ? int_z_d2 :
             (output_cont == 1) ? int_z_d1 :
             (corrupt_data !== 1'b0)? {TOTAL_WIDTH{1'bx}} : int_z;

  assign status = (reset_st) ? 0 :
                  (~input_mode & new_input) ? {8{1'bx}} :
                  (output_cont == 2) ? int_status_d2 :
                  (output_cont == 1) ? int_status_d1 :
                  (corrupt_data !== 1'b0)? {8{1'bx}} : int_status;

  generate
  if (rst_mode == 0) begin : GEN_RM_EQ_0_A
    assign complete = (~rst_n) ? 0:
                      (output_cont == 2) ? int_complete_d2 :
                      (output_cont == 1) ? int_complete_d1 :
                      int_complete;

    assign rst_n_rst = rst_n;
  end
  else begin : GEN_RM_NE_0_A
    assign complete = (output_cont == 2) ? int_complete_d2 :
                      (output_cont == 1) ? int_complete_d1 :
                      int_complete;

    assign rst_n_rst = rst_n_clk;
  end
  endgenerate

  assign start_n = ~start;
  assign output_cont = output_mode + internal_reg;

  assign ina_div = (input_mode == 1) ? ina : a;
  assign inb_div = (input_mode == 1) ? inb : b;


  always @(posedge clk) begin : a1000_PROC
    new_input_reg_d1 <= new_input_pre;
    new_input_reg_d2 <= new_input_reg_d1;

    a_reg <= a;
    b_reg <= b;
    rnd_reg <= rnd;

    if (start == 1) begin
      start_clk <= 1;
    end else begin
      start_clk <= 0;
    end

    if (rst_n == 1) begin
      rst_n_clk <= 1;
    end else begin
      rst_n_clk <= 0;
    end

  end

    always @(ina_div or inb_div) begin : a1001_PROC
      if ( (rst_n==1'b1) && (count >= (num_cyc + CYC_CONT - 4)) )
        new_input_pre = 1;
      else
        new_input_pre = 0;
    end

    always @(rst_n or count) begin : a1002_PROC
      if ( (rst_n==1'b0) || (count < (num_cyc + CYC_CONT - 4)) )
        new_input_pre = 0;
    end

  always @(new_input_reg_d1 or new_input_reg_d2 or new_input_pre) begin : a1003_PROC
    if (input_mode & ~early_start) begin
      new_input = (internal_reg) ? new_input_reg_d1 : new_input_pre;
    end
    else begin
      if (output_cont == 2) begin
        new_input = new_input_reg_d2;
      end
      else if (output_cont == 1) begin
        new_input = new_input_reg_d1;
      end
      else begin
        new_input = new_input_pre;
      end
    end
  end

  assign a_new = (internal_reg) ? a_reg : a;
  assign b_new = (internal_reg) ? b_reg : b;
  assign rnd_new = (internal_reg) ? rnd_reg : rnd;
  assign start_in = (input_mode & ~early_start) ? 0 : start;

  DW_fp_div #(sig_width, exp_width, ieee_compliance) U1 (
                      .a(ina_div),
                      .b(inb_div),
                      .rnd(rnd_new),
                      .z(temp_z),
                      .status(temp_status)
  );

  generate
  if (rst_mode == 0) begin : GEN_RM_EQ_0_C
    always @(posedge clk or negedge rst_n) begin : a1004_PROC
      if (rst_n == 0) begin
        cnt_glitch <= 0;
        int_complete_d2 <= 0;
      end
      else if (rst_n == 1) begin
        if (~rst_n) begin
          cnt_glitch <= 0;
          int_complete_d2 <= 0;
        end
        else begin
          if (cnt_glitch < (num_cyc + CYC_CONT - 4)) begin
            cnt_glitch <= cnt_glitch + 1;
          end

          int_complete_d2 <= int_complete_d1;
        end
      end
    end
  end
  else begin : GEN_RM_NE_0_C
    always @(posedge clk) begin : a1005_PROC
      if (~rst_n) begin
        cnt_glitch <= 0;
        int_complete_d2 <= 0;
      end
      else begin
        if (cnt_glitch < (num_cyc + CYC_CONT - 4)) begin
          cnt_glitch <= cnt_glitch + 1;
        end

        int_complete_d2 <= int_complete_d1;
      end
    end
  end
  endgenerate

  always @(rst_n or start or a or b or ina or inb or count_reseted or next_count or
           temp_z or temp_status or output_cont or new_input) begin : next_comb_PROC
    if (start===1'b1 & count_reseted == 0) begin
      next_count_reseted = 1'b1;

      next_ina           = a;
      next_inb           = b;
      next_complete      = 1'b0;
      next_z             = {TOTAL_WIDTH{1'bx}};
      next_status        = {TOTAL_WIDTH{1'bx}};
      next_int_complete  = 0;
      next_int_z         = {TOTAL_WIDTH{1'bx}};
      next_int_status    = {TOTAL_WIDTH{1'bx}};
    end

    else if (start===1'b0 | (start == 1'b1 & count_reseted == 1)) begin
      next_count_reseted = 1'b0;

      if (next_count >= (num_cyc+CYC_CONT-4)) begin

        next_int_complete  = rst_n;
        next_int_z         = temp_z;
        next_int_status    = temp_status;

        next_ina           = ina;
        next_inb           = inb;
        next_complete      = 1'b1;

        if (input_mode == 0 | early_start) begin
          next_z             = (new_input) ? {TOTAL_WIDTH{1'bX}} : temp_z;
          next_status        = (new_input) ? {TOTAL_WIDTH{1'bX}} : temp_status;
        end else begin
          next_z             = temp_z;
          next_status        = temp_status;
        end

      end else if (next_count === -1) begin
        next_ina           = {TOTAL_WIDTH{1'bX}};
        next_inb           = {TOTAL_WIDTH{1'bX}};
        next_complete      = 1'bX;
        next_z             = {TOTAL_WIDTH{1'bX}};
        next_status        = {TOTAL_WIDTH{1'bX}};
      end else begin
        next_ina           = ina;
        next_inb           = inb;

        if (next_count >= (num_cyc + CYC_CONT - 4 - output_cont - (input_mode - early_start))) begin

          next_int_complete  = rst_n;
          next_int_z         = temp_z;
          next_int_status    = temp_status;
        end else begin
          next_int_complete  = 0;
          next_int_z         = {TOTAL_WIDTH{1'bX}};
          next_int_status    = {TOTAL_WIDTH{1'bX}};
        end

        if (next_count == (num_cyc + CYC_CONT - 4)) begin
          next_complete = 1'b1;

          if (input_mode == 0 | early_start) begin
            next_z        = (new_input) ? {TOTAL_WIDTH{1'bX}} : temp_z;
            next_status   = (new_input) ? {TOTAL_WIDTH{1'bX}} : temp_status;
          end else begin
            next_z        = temp_z;
            next_status   = temp_status;
          end
        end else begin
          next_complete = 1'b0;
          next_z        = {TOTAL_WIDTH{1'bX}};
          next_status   = {TOTAL_WIDTH{1'bX}};
        end
      end
    end

  end

  always @(start or count_reseted or count) begin : a1006_PROC
    if (start===1'b1 & count_reseted == 0)
      next_count = 0;
    else if(start===1'b0 | (start == 1'b1 & count_reseted == 1)) begin
      if (count >= (num_cyc+CYC_CONT-4))
        next_count = count;
      else if (count === -1)
        next_count = -1;
      else
        next_count = count + 1;
    end
  end

  generate
  if (rst_mode == 0) begin : GEN_RM_EQ_0_D
    always @ (posedge clk or negedge rst_n) begin: register_PROC
      if (rst_n === 1'b0) begin
        int_z           <= 0;
        int_status      <= 0;
        int_complete    <= 0;
        count_reseted   <= 0;
        count           <= 1;
        if (input_mode) begin
          ina             <= 0;
          inb             <= 0;
        end else begin
          ina             <= a;
          inb             <= b;
        end
        int_z_d1        <= 0;
        int_z_d2        <= 0;
        int_status_d1   <= 0;
        int_status_d2   <= 0;
        int_complete_d1 <= 0;
      end else if (rst_n === 1'b1) begin
        int_z           <= next_int_z;
        int_status      <= next_int_status;
        int_complete    <= next_int_complete;
        count_reseted   <= next_count_reseted;
        count           <= next_count;
        ina             <= next_ina;
        inb             <= next_inb;
        int_z_d1        <= int_z & {((exp_width + sig_width) + 1){~reset_st}};
        int_z_d2        <= int_z_d1;
        int_status_d1   <= int_status & {8{~reset_st}};
        int_status_d2   <= int_status_d1;
        if (reset_st & start_in & (cnt_glitch < num_cyc + CYC_CONT - 4)) begin
          int_complete_d1 <= 0;
        end else begin
          int_complete_d1 <= int_complete;
        end
      end else begin
        int_z           <= {(exp_width + sig_width){1'bx}};
        int_status      <= {7{1'bx}};
        int_complete    <= 1'bx;
        count_reseted   <= 1'bx;
        count           <= -1;
        ina             <= {TOTAL_WIDTH{1'bx}};
        inb             <= {TOTAL_WIDTH{1'bx}};
        int_z_d1        <= {(exp_width + sig_width){1'bx}};
        int_z_d2        <= {(exp_width + sig_width){1'bx}};
        int_status_d1   <= {7{1'bx}};
        int_status_d2   <= {7{1'bx}};
        int_complete_d1 <= 1'bx;
      end
    end
  end
  else begin : GEN_RM_NE_0_D
    always @ ( posedge clk) begin: register_PROC
      if (rst_n === 1'b0) begin
        int_z           <= 0;
        int_status      <= 0;
        int_complete    <= 0;
        count_reseted   <= 0;
        count           <= 1;
        if (input_mode) begin
          ina             <= 0;
          inb             <= 0;
        end else begin
          ina             <= a;
          inb             <= b;
        end
        int_z_d1        <= 0;
        int_z_d2        <= 0;
        int_status_d1   <= 0;
        int_status_d2   <= 0;
        int_complete_d1 <= 0;
      end else if (rst_n === 1'b1) begin
        int_z           <= next_int_z;
        int_status      <= next_int_status;
        int_complete    <= next_int_complete;
        count_reseted   <= next_count_reseted;
        count           <= next_count;
        ina             <= next_ina;
        inb             <= next_inb;
        int_z_d1        <= int_z & {((exp_width + sig_width) + 1){~reset_st}};
        int_z_d2        <= int_z_d1;
        int_status_d1   <= int_status & {8{~reset_st}};
        int_status_d2   <= int_status_d1;
        if (reset_st & start_in & (cnt_glitch < num_cyc + CYC_CONT - 4)) begin
          int_complete_d1 <= 0;
        end else begin
          int_complete_d1 <= int_complete;
        end
      end else begin
        int_z           <= {(exp_width + sig_width){1'bx}};
        int_status      <= {7{1'bx}};
        int_complete    <= 1'bx;
        count_reseted   <= 1'bx;
        count           <= -1;
        ina             <= {TOTAL_WIDTH{1'bx}};
        inb             <= {TOTAL_WIDTH{1'bx}};
        int_z_d1        <= {(exp_width + sig_width){1'bx}};
        int_z_d2        <= {(exp_width + sig_width){1'bx}};
        int_status_d1   <= {7{1'bx}};
        int_status_d2   <= {7{1'bx}};
        int_complete_d1 <= 1'bx;
      end
    end
  end
  endgenerate

  generate
  if (rst_mode == 0) begin : GEN_RM_EQ_0_E
    always @(rst_n or start_clk) begin : a1007_PROC
      if (reset_st == 0) begin
        if (rst_n == 0) begin
          reset_st = 1;
        end else begin
          reset_st = 0;
        end
      end else begin
        if ((rst_n == 1) & (start_clk == 1)) begin
          reset_st = 0;
        end else begin
          reset_st = 1;
        end
      end
    end
  end else begin : GEN_RM_NE_0_E
    always @(rst_n_clk or start_clk) begin : a1008_PROC
      if (reset_st == 0) begin
        if (rst_n_clk == 0) begin
          reset_st = 1;
        end else begin
          reset_st = 0;
        end
      end else begin
        if ((rst_n_clk == 1) & (start_clk == 1)) begin
          reset_st = 0;
        end else begin
          reset_st = 1;
        end
      end
    end
  end
  endgenerate

  
  always @ (clk) begin : P_monitor_clk 
    if ( (clk !== 1'b0) && (clk !== 1'b1) && ($time > 0) )
      $display( "WARNING: %m :\n  at time = %t, detected unknown value, %b, on clk input.",
                $time, clk );
    end // P_monitor_clk 

// synopsys translate_on

endmodule
