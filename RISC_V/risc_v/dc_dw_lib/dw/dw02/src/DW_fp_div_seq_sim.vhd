
--------------------------------------------------------------------------------
--
--       This confidential and proprietary software may be used only
--     as authorized by a licensing agreement from Synopsys Inc.
--     In the event of publication, the following notice is applicable:
--
--                    (C) COPYRIGHT 2006 - 2016 SYNOPSYS INC.
--                           ALL RIGHTS RESERVED
--
--       The entire notice above must be reproduced on all authorized
--     copies.
--
-- AUTHOR:    Kyung-Nam Han, Sep. 25, 2006
--
-- VERSION:   VHDL Simulation Model for DW_fp_div_seq
--
-- DesignWare_version: 6f485fad
-- DesignWare_release: L-2016.03-DWBB_201603.1
--
--------------------------------------------------------------------------------

-------------------------------------------------------------------------------
--
-- ABSTRACT: Floating-Point Sequencial Divider
--
--              DW_fp_div_seq calculates the floating-point division
--              while supporting six rounding modes, including four IEEE
--              standard rounding modes.
--
--              parameters      valid values (defined in the DW manual)
--              ==========      ============
--              sig_width       significand size,  2 to 253 bits
--              exp_width       exponent size,     3 to 31 bits
--              ieee_compliance support the IEEE Compliance 
--                              0 - IEEE 754 compatible without denormal support
--                                  (NaN becomes Infinity, Denormal becomes Zero)
--                              1 - IEEE 754 compatible with denormal support
--                                  (NaN and denormal numbers are supported)
--              num_cyc         Number of cycles required for the FP sequential
--                              division operation including input and output 
--                              register. Actual number of clock cycle is 
--                              num_cyc - (1 - input_mode) - (1 - output_mode)
--                               - early_start + internal_reg
--              rst_mode        Synchronous / Asynchronous reset 
--                              0 - Asynchronous reset
--                              1 - Synchronous reset
--              input_mode      Input register setup
--                              0 - No input register
--                              1 - Input registers are implemented
--              output_mode     Output register setup
--                              0 - No output register
--                              1 - Output registers are implemented
--              early_start     Computation start (only when input_mode = 1)
--                              0 - start computation in the 2nd cycle
--                              1 - start computation in the 1st cycle (forwarding)
--                              early_start should be 0 when input_mode = 0
--              internal_reg    Insert a register between an integer sequential divider
--                              and a normalization unit
--                              0 - No internal register
--                              1 - Internal register is implemented
--
--              Input ports     Size & Description
--              ===========     ==================
--              a               (sig_width + exp_width + 1)-bits
--                              Floating-point Number Input
--              b               (sig_width + exp_width + 1)-bits
--                              Floating-point Number Input
--              rnd             3 bits
--                              Rounding Mode Input
--              clk             Clock
--              rst_n           Reset. (active low)
--              start           Start operation
--                              A new operation is started by setting start=1
--                              for 1 clock cycle
--              z               (sig_width + exp_width + 1)-bits
--                              Floating-point Number Output
--              status          8 bits
--                              Status Flags Output
--              complete        Operation completed
--
-- Modified : 6/05/07 (0703-SP3)
--            The legal range of num_cyc parameter widened
--
--            1/29/10 (D-2010.03)
--            1. Removed synchronous DFF when rst_mode = 0 (STAR 9000367314)
--            2. Fixed complete signal error at the reset (STAR 9000371212)
--            3. Fixed divide_by_zero flag error          (STAR 9000371212)
--
--	      2/27/12 RJK
--	      Added missing message when input changes during calculation
--	       while using input_mode=0 (STAR 9000523798)
--
--           2/06/15 RJK
--           Updated input change monitor for input_mode=0 configurations to better
--           inform designers of severity of protocol violations (STAR 9000851903)
--           5/20/14 RJK
--           Extended corruption of output until next start for configurations
--           with input_mode = 0 (STAR 9000741261)
--           9/25/12 RJK
--           Corrected data corruption detection to catch input changes
--            during the first cycle of calculation (related to STAR 9000523798)
-------------------------------------------------------------------------------

library IEEE, DWARE;
use IEEE.std_logic_1164.all;
use DWARE.DW_Foundation.all;
use DWARE.DW_Foundation_comp_arith.all;

architecture sim of DW_fp_div_seq is
	
-- pragma translate_off


-- Function
-- find the actual number of cycles required based on
-- input_mode, output_mode and early_start
function cycle_cont(l, m , n : natural) return natural is
 begin
   if  ((l=1) and (m=1) and (n=0))then
     return (3);
   elsif  ((l=0) and (m=0) and (n=0))then
     return (1);
   elsif  ((l=1) and (m=0) and (n=1))then
     return (1);
   else
     return (2);
   end if;
end cycle_cont;



-------------------CONSTANTS-----------------------
  constant CYC_CONT0 : integer := cycle_cont(input_mode, output_mode, early_start);
  constant CYC_CONT1 : integer := cycle_cont(input_mode, output_mode, early_start) + 1;

  constant zero : integer := 0;

  signal count       : integer;
  signal CYC_CONT    : integer;
  signal output_cont    : integer;
  
  signal temp_z  : std_logic_vector((exp_width + sig_width) downto 0) ;

  signal ext_status  : std_logic_vector(7 downto 0) ;
  signal temp_status : std_logic_vector(7 downto 0) ;

  signal ina         : std_logic_vector((exp_width + sig_width) downto 0);
  signal inb         : std_logic_vector((exp_width + sig_width) downto 0);
  signal ina_div     : std_logic_vector((exp_width + sig_width) downto 0);
  signal inb_div     : std_logic_vector((exp_width + sig_width) downto 0);

  signal a_rst_n      : std_logic;
  signal start_n      : std_logic;
  signal ext_complete : std_logic;
  signal new_input : std_logic;
  signal next_start: std_logic;
  signal new_input_pre : std_logic;
  signal new_input_reg_d1 : std_logic;
  signal new_input_reg_d2 : std_logic;

  signal a_reg         : std_logic_vector((exp_width + sig_width) downto 0);
  signal a_new         : std_logic_vector((exp_width + sig_width) downto 0);
  signal b_reg         : std_logic_vector((exp_width + sig_width) downto 0);
  signal b_new         : std_logic_vector((exp_width + sig_width) downto 0);
  signal rnd_reg       : std_logic_vector(2 downto 0);
  signal rnd_new       : std_logic_vector(2 downto 0);

  signal next_complete : std_logic;
  signal int_complete  : std_logic;
  signal int_complete_d1  : std_logic;
  signal int_complete_d2  : std_logic;
  signal int_z  : std_logic_vector((exp_width + sig_width) downto 0) ;
  signal int_z_d1  : std_logic_vector((exp_width + sig_width) downto 0) ;
  signal int_z_d2  : std_logic_vector((exp_width + sig_width) downto 0) ;
  signal int_status : std_logic_vector(7 downto 0) ;
  signal int_status_d1 : std_logic_vector(7 downto 0) ;
  signal int_status_d2 : std_logic_vector(7 downto 0) ;
  signal count_reseted  : std_logic;
  signal start_in: std_logic;

  type state is (state_0, state_1);
  signal start_clk    : std_logic;
  signal rst_n_rst    : std_logic;
  signal rst_n_clk    : std_logic;
  signal reset_st     : std_logic;
  signal reset_st_n_z : std_logic_vector(sig_width + exp_width downto 0);
  signal reset_st_n_status : std_logic_vector(7 downto 0);

  signal cnt_glitch  : integer;

  signal corrupt_data        : std_logic;

-- pragma translate_on

begin


-- pragma translate_off
  
  parameter_check : process
    variable param_err_flg : integer := 0;
  begin
    
    
    if ( (sig_width < 3) OR (sig_width > 253) ) then
      param_err_flg := 1;
      assert false
        report "ERROR: Invalid value for parameter sig_width (legal range: 3 to 253)"
        severity warning;
    end if;
    
    if ( (exp_width < 3) OR (exp_width > 31) ) then
      param_err_flg := 1;
      assert false
        report "ERROR: Invalid value for parameter exp_width (legal range: 3 to 31)"
        severity warning;
    end if;
    
    if ( (ieee_compliance < 0) OR (ieee_compliance > 1) ) then
      param_err_flg := 1;
      assert false
        report "ERROR: Invalid value for parameter ieee_compliance (legal range: 0 to 1)"
        severity warning;
    end if;
    
    if ( (num_cyc < 4) OR (num_cyc > 2*sig_width+3) ) then
      param_err_flg := 1;
      assert false
        report "ERROR: Invalid value for parameter num_cyc (legal range: 4 to 2*sig_width+3)"
        severity warning;
    end if;
    
    if ( (rst_mode < 0) OR (rst_mode > 1) ) then
      param_err_flg := 1;
      assert false
        report "ERROR: Invalid value for parameter rst_mode (legal range: 0 to 1)"
        severity warning;
    end if;
    
    if ( (input_mode < 0) OR (input_mode > 1) ) then
      param_err_flg := 1;
      assert false
        report "ERROR: Invalid value for parameter input_mode (legal range: 0 to 1)"
        severity warning;
    end if;
    
    if ( (output_mode < 0) OR (output_mode > 1) ) then
      param_err_flg := 1;
      assert false
        report "ERROR: Invalid value for parameter output_mode (legal range: 0 to 1)"
        severity warning;
    end if;
    
    if ( (early_start < 0) OR (early_start > 1) ) then
      param_err_flg := 1;
      assert false
        report "ERROR: Invalid value for parameter early_start (legal range: 0 to 1)"
        severity warning;
    end if;
    
    if ( (input_mode=0 and early_start=1) ) then
      param_err_flg := 1;
      assert false
        report "ERROR: Invalid parameter combination: when input_mode=0, early_start=1 is not possible"
        severity warning;
    end if;
  
    assert param_err_flg = 0
      report "Simulation aborted due to invalid parameter value(s)" 
      severity failure;

    wait;

  end process parameter_check;

------------------------------------------------------------------------------

  start_n  <= not start; 
  a_rst_n  <= rst_n WHEN (rst_mode = 0) else '1';
  start_in <= '0' when (input_mode = 1 and early_start = 0) else start;
  output_cont <= output_mode + internal_reg;

  reset_st_n_z <= (others => not reset_st);
  reset_st_n_status <= (others => not reset_st);
  z <=        (others => '0') when (reset_st = '1') else
              (others => 'X') when (input_mode = 0 and new_input = '1') else
              int_z_d2 when (output_cont = 2) else
              int_z_d1 when (output_cont = 1) else
              int_z when (corrupt_data = '0') else (others => 'X');
  status <=   (others => '0') when (reset_st = '1') else
              (others => 'X') when (input_mode = 0 and new_input = '1') else
              int_status_d2 when (output_cont = 2) else
              int_status_d1 when (output_cont = 1) else
              int_status when (corrupt_data = '0') else (others => 'X');

  complete <= '0' when (a_rst_n = '0') else
              int_complete_d2 when (output_cont = 2) else
              int_complete_d1 when (output_cont = 1) else
              int_complete;

  ina_div <= ina when (input_mode = 1) else a;
  inb_div <= inb when (input_mode = 1) else b;
  CYC_CONT <= CYC_CONT1 when (internal_reg = 1) else CYC_CONT0;

  -- Instance of DW_fp_div
  U1 : DW_fp_div
      generic map (
              sig_width => sig_width,
              exp_width => exp_width,
              ieee_compliance => ieee_compliance
              )
      port map (
              a => ina_div,
              b => inb_div,
              rnd => rnd_new,
              z => temp_z,
              status => temp_status
              );
   
  process (ina_div, inb_div, a_rst_n, count) begin
    if (a_rst_n = '0') then
      new_input_pre <= '0';
    elsif (count < (num_cyc + CYC_CONT - 4)) then
      new_input_pre <= '0';
    elsif (ina_div'event or inb_div'event) then
      new_input_pre <= '1';
    end if;
  end process;

  process (new_input_reg_d1, new_input_reg_d2, new_input_pre) begin
    if (input_mode = 1 and early_start = 0) then
      if (internal_reg = 1) then
        new_input <= new_input_reg_d1;
      else
        new_input <= new_input_pre;
      end if;
    else
      if (output_cont = 2) then
        new_input <= new_input_reg_d2;
      elsif (output_cont = 1) then
        new_input <= new_input_reg_d1;
      else
        new_input <= new_input_pre;
      end if;
    end if;
  end process;

  process (a_reg, b_reg, rnd_reg, a, b, rnd) begin
    if (internal_reg = 1) then
      a_new <= a_reg;
      b_new <= b_reg;
      rnd_new <= rnd_reg;
    else
      a_new <= a;
      b_new <= b;
      rnd_new <= rnd;
    end if;
  end process;

  process begin
    wait until (rising_edge(clk));
      new_input_reg_d1 <= new_input_pre;
      new_input_reg_d2 <= new_input_reg_d1;
      a_reg <= a;
      b_reg <= b;
      rnd_reg <= rnd;
      next_start <= start;
  end process;

  process begin
    wait until(rising_edge(clk) or falling_edge(a_rst_n));

    if (rst_n = '0') then
      int_complete_d2 <= '0';
      cnt_glitch <= 0;
    else
      int_complete_d2 <= int_complete_d1;

      if (cnt_glitch < (num_cyc + CYC_CONT - 4)) then
        cnt_glitch <= cnt_glitch + 1;
      end if;
    end if;
  end process;
     


  div_seq_PROC: process

  variable next_count  : integer;
  variable next_z  : std_logic_vector((exp_width + sig_width) downto 0) ;
  variable next_status : std_logic_vector(7 downto 0) ;
  variable next_ina    : std_logic_vector((exp_width + sig_width) downto 0);
  variable next_inb    : std_logic_vector((exp_width + sig_width) downto 0);

  begin

    wait until (rising_edge(clk) or rising_edge(start_in) or falling_edge(a_rst_n)); 

      int_z_d1 <= int_z and reset_st_n_z;
      int_status_d1 <= int_status and reset_st_n_status;

      if (rst_n = '0') then
        int_complete_d1 <= '0';
      else
        if (reset_st = '1') then
          if (start_in = '1' and (cnt_glitch < num_cyc + CYC_CONT - 4)) then
            int_complete_d1 <= '0';
          else
            int_complete_d1 <= int_complete;
          end if;
        else
          int_complete_d1 <= int_complete;
        end if;
      end if;

      int_z_d2 <= int_z_d1;
      int_status_d2 <= int_status_d1;

    if(start = '1' and count_reseted = '0') then
      count_reseted <= '1';
      count <= 0;
      next_count     := 0;
      next_ina       := a;
      next_inb       := b;
      next_z  := (others => 'X'); 
      next_status := (others => 'X'); 

      int_complete <= '0';
      int_z  <= (others => 'X'); 
      int_status <= (others => 'X'); 

-- Rest of the computation
    elsif(start = '0' or (start = '1' and count_reseted = '1')) then
      count_reseted <= '0';

      if (count >= (num_cyc + CYC_CONT - 4)) then

        int_complete <= rst_n;

        int_z <= temp_z;
        int_status <= temp_status;

        next_ina       := ina;
        next_inb       := inb;
        next_count     := count;
        next_complete  <= '1';

        if (input_mode = 0 or early_start = 1) then
          if (new_input = '1') then
            next_z := (others => 'X');
            next_status := (others => 'X');
          else
            next_z := temp_z;
            next_status := temp_status;
          end if;

        else
          next_z := temp_z;
          next_status := temp_status;
        end if;

      elsif (count = -1) then
        next_ina       := (others => 'X');
        next_inb       := (others => 'X');
        next_count     := -1;
        next_complete  <= 'X';
        next_z  := (others => 'X');
        next_status := (others => 'X');
      else
        next_ina       := ina;
        next_inb       := inb;
        next_count     := count+1;

        if (count >= (num_cyc + CYC_CONT - 4 - output_cont - (input_mode - early_start))) then

          int_complete <= rst_n;

          int_z <= temp_z;
          int_status <= temp_status;
        else 
          int_complete <= '0';
          int_z <= (others => 'X');
          int_status <= (others => 'X');
        end if;

        if (next_count = (num_cyc + CYC_CONT - 4)) then
          next_complete <= '1';
          if (input_mode = 0 or early_start = 1) then
            if (new_input = '1') then
              next_z := (others => 'X');
              next_status := (others => 'X');
            else
              next_z := temp_z;
              next_status := temp_status;
            end if;
          else
            next_z := temp_z;
            next_status := temp_status;
          end if;
        else
          next_complete  <= '0';
          next_z  := (others => 'X');
          next_status := (others => 'X'); 
        end if;
      end if;
    end if;

    if (a_rst_n = '0') then

      count <= 1;

      count_reseted <= '0';

	  if(input_mode = 1) then
            ina          <= (others => '0');
            inb          <= (others => '0');
	  elsif (input_mode = 0) then
            ina          <= a;
            inb          <= b;
	  end if;

    elsif (a_rst_n = '1') then
        if (rst_n = '0') then    

          count        <= 1;

          count_reseted <= '0';

          if (input_mode = 1) then
            ina <= (others => '0');
            inb <= (others => '0');
          else
            ina <= a;
            inb <= b;
          end if;

        elsif (rst_n = '1') then
          count        <= next_count;
          ina          <= next_ina;
          inb          <= next_inb;
        else
          count        <= -1;
          ina          <= (others => 'X');
          inb          <= (others => 'X');
        end if;
    else
      count        <= -1;
      ina          <= (others => 'X');
      inb          <= (others => 'X');
    end if;
  end process div_seq_PROC;

  START_CLK_PROC: process (clk) begin
    if clk'event and clk = '1' then
      if (start = '1') then
        start_clk <= '1';
      else
        start_clk <= '0';
      end if;

      if (rst_n = '1') then
        rst_n_clk <= '1';
      else
        rst_n_clk <= '0';
      end if;
    end if;
  end process START_CLK_PROC;

  rst_n_rst <= rst_n_clk when (rst_mode = 1) 
               else rst_n;

  RST_SM_PROC: process (rst_n_rst, start_clk) begin
    case reset_st is
      when '0' =>
        if (rst_n_rst = '0') then
          reset_st <= '1';
        else
          reset_st <= '0';
        end if;
 
      when '1' =>
        if (rst_n_rst = '1' and start_clk = '1') then
          reset_st <= '0';
        else
          reset_st <= '1';
        end if;

      when others =>
        reset_st <= '0';
    end case;
  end process RST_SM_PROC;


GEN_IM0 : if (input_mode = 0) generate
IM0_BLK: block
 signal ina_hist    : std_logic_vector(1+exp_width+sig_width-1 downto 0);
 signal inb_hist    : std_logic_vector(1+exp_width+sig_width-1 downto 0);
 signal corrupt_data_int : std_logic;
 signal next_corrupt_data : std_logic;
 signal data_input_activity : std_logic;
 signal init_complete : std_logic;
 signal next_alert1 : std_logic;
 signal change_count : INTEGER;

begin

  next_alert1 <= next_corrupt_data AND rst_n AND init_complete AND (NOT start) AND (NOT ext_complete);

 GEN_IM0_RM_EQ_0: if (rst_mode = 0) generate
   PROCC_hist_regs_rm0 : process ( clk, rst_n ) begin
     if (rst_n = '0') then
       ina_hist        <= a;
       inb_hist        <= b;
       change_count     <=  0 ;
       init_complete    <= '0';
       corrupt_data_int <= '0';
     elsif ( rst_n = '1') then
       if (rising_edge(clk)) then
	    ina_hist        <= a;
	    inb_hist        <= b;
	    if (start = '1') then
	      change_count  <= 0;
	    elsif (next_alert1 = '1') then
	      change_count  <= change_count + 1;
	    end if;
	   init_complete    <= init_complete OR start;
	   corrupt_data_int <= next_corrupt_data OR (corrupt_data_int AND (NOT start));

       end if;
     else
       ina_hist        <= (others => 'X');
       inb_hist        <= (others => 'X');
       change_count     <= -1 ;
       init_complete    <= 'X';
       corrupt_data_int <= 'X';
     end if;
   end process;
  end generate GEN_IM0_RM_EQ_0;

 GEN_IM0_RM_NE_0 : if (rst_mode /= 0) generate
   PROCC_hist_regs_rm1 : process ( clk ) begin
     if (rising_edge(clk)) then
       if (rst_n = '0') then
	 ina_hist        <= a;
	 inb_hist        <= b;
	 change_count     <=  0 ;
	 init_complete    <= '0';
	 corrupt_data_int <= '0';
       elsif ( rst_n = '1') then
	    ina_hist        <= a;
	    inb_hist        <= b;
	    if (start = '1') then
	      change_count  <= 0;
	    elsif (next_alert1 = '1') then
	      change_count  <= change_count + 1;
	    end if;
	   init_complete    <= init_complete OR start;
	   corrupt_data_int <= next_corrupt_data OR (corrupt_data AND (NOT start));

       end if;
     else
       ina_hist        <= (others => 'X');
       inb_hist        <= (others => 'X');
       change_count     <= -1 ;
       init_complete    <= 'X';
       corrupt_data_int <= 'X';
     end if;
   end process;
  end generate GEN_IM0_RM_NE_0;


  data_input_activity <= rst_n WHEN ((a /= ina_hist) OR
				 (b /= inb_hist)) ELSE '0';

  next_corrupt_data <= '0' WHEN ((input_mode /= 0) OR
                                 ((output_mode /= 0) AND (ext_complete = '1'))) ELSE
			    (data_input_activity AND (NOT start) AND
			    init_complete);

 PROC_corrupt_alert : process ( clk )
   variable updated_count : integer;
   begin
      if (rising_edge(clk)) then

	updated_count := change_count;

	if (next_alert1 = '1') then
	  assert (rst_n /= '1') report
	   "## Warning: operand input change at this point will cause corrupted results if operation is allowed to complete." & lf severity warning;
	  updated_count := updated_count + 1;
	end if;

	if ((rst_n AND init_complete AND (NOT start) AND (NOT ext_complete) AND next_complete)
	            = '1') then
	  assert (updated_count < 1) report ""
	    & lf & " "
	    & lf & "############################################################"
	    & lf & "############################################################"
	    & lf & "##"
	    & lf & "## Error!! :"
	    & lf & "##"
	    & lf & "##      This instance of DW_fp_div_seq has encountered a change"
	    & lf & "##      on operand input(s) after starting the calculation."
	    & lf & "##      The instance is configured with no input register."
	    & lf & "##      So, the result of the operation is corrupted.  This"
	    & lf & "##      message is generated at the point of completion of"
	    & lf & "##      the operation, separate warning(s) were generated"
	    & lf & "##      earlier during calculation (other than corruption"
	    & lf & "##      detected now that occured in the previous cycle)."
	    & lf & "##"
	    & lf & "############################################################"
	    & lf & "############################################################"
	    & lf severity warning;
        end if;
      end if;
  end process;

  corrupt_data <= corrupt_data_int;

  GEN_OM_EQ_0: if (output_mode = 0) generate
   OM0_BLK: block
    signal alert2_issued : std_logic;
    signal next_alert2   : std_logic;
   begin

    next_alert2 <= next_corrupt_data AND rst_n AND init_complete AND
				     (NOT start) AND ext_complete AND (NOT alert2_issued);

    PROC_corrupt_alert2: process(clk) begin

      if (rising_edge(clk)) then

	assert (next_alert2 = '0') report
	 "## Warning: operand input change causes output to no longer retain result of previous operation." & lf severity warning;
	 
      end if;
    end process PROC_corrupt_alert2;

    GEN_AI_REG_AR: if (rst_mode = 0) generate
      PROC_AI_REG_AR: process(clk, rst_n) begin
        if (rst_n = '0') then
	  alert2_issued <= '0';
	else
	  if rising_edge(clk) then
	    alert2_issued <= (NOT start) AND (alert2_issued OR next_alert2);
	  end if;
	end if;
      end process PROC_AI_REG_AR;
    end generate GEN_AI_REG_AR;

    GEN_AI_REG_SR: if (rst_mode /= 0) generate
      PROC_AI_REG_SR: process(clk) begin
	if rising_edge(clk) then
	  if (rst_n = '0') then
	    alert2_issued <= '0';
	  else
	    alert2_issued <= (NOT start) AND (alert2_issued OR next_alert2);
	  end if;
	end if;
      end process PROC_AI_REG_SR;
    end generate GEN_AI_REG_SR;

   end block OM0_BLK;
  end generate GEN_OM_EQ_0;

end block IM0_BLK;
end generate GEN_IM0;


GEN_IM1 : if (input_mode /= 0) generate
  corrupt_data <= '0';
end generate GEN_IM1;

 
  P_monitor_clk  : process (clk) begin

    assert NOT (Is_X( clk ) AND (now > 0 ns)) 
      report "WARNING: Detected unknown value on the clock input port clk."
      severity warning;

  end process P_monitor_clk ;

-- pragma translate_on

end sim;
--------------------------------------------------------------------------------
-- auto generated configuration
-- pragma translate_off

library dw02;

configuration DW_fp_div_seq_cfg_sim of DW_fp_div_seq is
 for sim
  for U1 : DW_fp_div use configuration dw02.DW_fp_div_cfg_sim; end for;
 end for; -- sim
end DW_fp_div_seq_cfg_sim;
-- pragma translate_on
