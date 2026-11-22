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
-- AUTHOR:    Kyung-Nam Han  Mar. 22, 2006
--
-- VERSION:   VHDL Simulation model for DW_fp_div
--
-- DesignWare_version: b969fd6c
-- DesignWare_release: L-2016.03-DWBB_201603.1
--
--------------------------------------------------------------------------------

---------------------------------------------------------------------------------
--
-- ABSTRACT: Floating-Point Divider
--
--              DW_fp_div calculates the floating-point division
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
--              faithful_round  select the faithful_rounding that admits 1 ulp error
--                              0 - default value. it keeps all rounding modes
--                              1 - z has 1 ulp error. RND input does not affect
--                                  the output
--
--              Input ports     Size & Description
--              ===========     ==================
--              a               (sig_width + exp_width + 1)-bits
--                              Floating-point Number Input
--              b               (sig_width + exp_width + 1)-bits
--                              Floating-point Number Input
--              rnd             3 bits
--                              Rounding Mode Input
--
--              Output ports    Size & Description
--              ============    ==================
--              z               (sig_width + exp_width + 1)-bits
--                              Floating-point Number Output
--              status          8 bits
--                              Status Flags Output
--
-- MODIFIED: May 7. 2007 Kyung-Nam Han (from 0703-SP2)
--             Fixed the rounding error of denormal numbers 
--             when ieee_compliance = 1
--           Oct. 18. 2007 Kyung-Nam Han from 0712
--             Fixed the 'divide by zero' flag when 0/0
--           Jan.  2. 2008 Kyung-Nam Han from 0712-SP1
--             New parameter, faithful_round, is introduced
--           Jun.  4. 2010 Kyung-Nam Han (from D-2010.03-SP3)
--             Removed VCS error [SIMERR_SIZEMISMATCH] 
--             when sig_width = 2 and 3.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_misc.all;
use ieee.numeric_std.all;

architecture sim of DW_fp_div is
	

  -- pragma translate_off


  constant rnd_width          : integer  := 4;
  constant rnd_inc            : integer  := 0;
  constant rnd_inexact        : integer  := 1;
  constant rnd_hugeinfinity   : integer  := 2;
  constant rnd_tinyminnorm    : integer  := 3;

  constant qwidth             : integer := (2 * sig_width + 2);
  constant qmsb               : integer := (sig_width + 2);
  constant ext                : integer := (sig_width + 2);
  ----------------------------------------------------------------------
  function OIO0O0O1 (a : in std_logic_vector; b : in std_logic_vector) return std_logic_vector is

    variable result : std_logic_vector(a'range);
    variable ref : std_logic_vector(b'length downto 0) := (others => '0');
    variable count : integer := a'length - 1;

    begin

      if (b = 0) then
        result := (others => '1');

      elsif (a < b) then
        result := (others => '0');

      else 
        while (count >= 0) loop
          ref := ref(ref'length - 2 downto 0) & a(count);

          if (ref >= b) then
            ref := ref - b;
            result(count) := '1';
          else
            result(count) := '0';
          end if;

          count := count - 1;

        end loop;
      end if;

    return result;

  end function;
  ----------------------------------------------------------------------
  function O10O1OO0 (a : in std_logic_vector; b : in std_logic_vector) return std_logic_vector is

    variable result : std_logic_vector(a'range);
    variable ref : std_logic_vector(b'length downto 0) := (others => '0');
    variable count : integer := a'length - 1;
    variable return_vec : std_logic_vector(a'length - 1 downto 0);
    variable zero_vec : std_logic_vector(a'length - b'length - 1 downto 0) := (others => '0');

    begin

      if (b = 0) then
        ref := (others => '1');

      elsif (a < b) then
        ref := (others => '0');

      else 
        while (count >= 0) loop
          ref := ref(ref'length - 2 downto 0) & a(count);

          if (ref >= b) then
            ref := ref - b;
            result(count) := '1';
          else
            result(count) := '0';
          end if;

          count := count - 1;

        end loop;
      end if;

      return_vec := zero_vec & ref(b'length - 1 downto 0);

    return return_vec;

  end function;
  ----------------------------------------------------------------------
  function lO1I110I (a : in std_logic_vector; sh : in integer) return std_logic_vector is

    variable b : std_logic_vector(a'range) := a;
    variable count : integer := sh;

    begin

      while (count > 0) loop
        b := '0' & b(b'length-1 downto 1);
        count := count - 1;
      end loop;

    return b;

  end function;

  ----------------------------------------------------------------------
  function OO00O010 (a : in std_logic_vector; sh : in integer) return std_logic_vector is

    variable b : std_logic_vector(a'range) := a;
    variable count : integer := sh;

    begin

      while (count > 0) loop
        b := b(b'length-2 downto 0) & '0';
        count := count - 1;
      end loop;

    return b;

  end function;

  ----------------------------------------------------------------------
  function OIIlOlO1 (
    rnd    : in std_logic_vector(2 downto 0);
    Sign   : in std_logic;
    L      : in std_logic;
    R      : in std_logic;
    O011IOO0    : in std_logic )
    return std_logic_vector is

    variable OIIlOlO1 : std_logic_vector(rnd_width - 1 downto 0);
  
    begin
  
    OIIlOlO1(rnd_inc) := '0';
    OIIlOlO1(rnd_inexact) := R OR O011IOO0;
    OIIlOlO1(rnd_hugeinfinity) := '0';
    OIIlOlO1(rnd_tinyminnorm) := '0';
  
    case rnd is
  
    when "000" =>
      OIIlOlO1(rnd_inc) := R AND (L OR O011IOO0);
      OIIlOlO1(rnd_hugeinfinity) := '1';
      OIIlOlO1(rnd_tinyminnorm) := '0';
  
    when "001" =>
      OIIlOlO1(rnd_inc) := '0';
      OIIlOlO1(rnd_hugeinfinity) := '0';
      OIIlOlO1(rnd_tinyminnorm) := '0';
  
    when "010" =>
      OIIlOlO1(rnd_inc) := not (Sign) AND (R OR O011IOO0);
      OIIlOlO1(rnd_hugeinfinity) := not (Sign);
      OIIlOlO1(rnd_tinyminnorm) := not (Sign);
  
    when "011" =>
      OIIlOlO1(rnd_inc) := Sign AND (R OR O011IOO0);
      OIIlOlO1(rnd_hugeinfinity) := Sign;
      OIIlOlO1(rnd_tinyminnorm) := Sign;
  
    when "100" =>
      OIIlOlO1(rnd_inc) := R;
      OIIlOlO1(rnd_hugeinfinity) := '1';
      OIIlOlO1(rnd_tinyminnorm) := '0';
  
    when "101" =>
      OIIlOlO1(rnd_inc) := R OR O011IOO0;
      OIIlOlO1(rnd_hugeinfinity) := '1';
      OIIlOlO1(rnd_tinyminnorm) := '1';
  
    when others =>
      OIIlOlO1(rnd_inc) := 'X';
      OIIlOlO1(rnd_hugeinfinity) := 'X';
      OIIlOlO1(rnd_tinyminnorm) := 'X';
  
    end case;
  
    return(OIIlOlO1);

  end function;

  -- pragma translate_on

  ----------------------------------------------------------------------

begin

  -- pragma translate_off

  
  parameter_check : process
    variable param_err_flg : integer := 0;
  begin
    
     
    if ( (sig_width < 2) OR (sig_width > 253) ) then
      param_err_flg := 1;
      assert false
        report "ERROR: Invalid value for parameter sig_width (legal range: 2 to 253)"
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
     
    if ( (faithful_round < 0) OR (faithful_round > 1) ) then
      param_err_flg := 1;
      assert false
        report "ERROR: Invalid value for parameter faithful_round (legal range: 0 to 1)"
        severity warning;
    end if;
  
    assert param_err_flg = 0
      report "Simulation aborted due to invalid parameter value(s)" 
      severity failure;

    wait;

  end process parameter_check;


  I1l100OI: process (a, b, rnd)

  variable IOOIlI0I : std_logic_vector((exp_width + sig_width) downto 0);
  variable l1l1O100 : std_logic_vector(exp_width - 1 downto 0);
  variable lO101111 : std_logic_vector(exp_width - 1 downto 0);
  variable OOO111OO : std_logic_vector(sig_width - 1 downto 0);
  variable l000I1O0 : std_logic_vector(sig_width - 1 downto 0);
  variable lI00O00I : std_logic_vector(exp_width + 1 downto 0);
  variable IOO1O01O : std_logic_vector(exp_width + 1 downto 0);
  variable O10101O1 : std_logic_vector(exp_width + 1 downto 0);
  variable I1O1O11O : std_logic_vector(exp_width + 1 downto 0);
  variable lO1O0OI1 : std_logic_vector(exp_width + 1 downto 0);
  variable IO10IOO1 : std_logic_vector(exp_width + 1 downto 0);
  variable l10OO10O : std_logic_vector(exp_width + 1 downto 0);
  variable OlOO00lO : std_logic_vector(sig_width downto 0);
  variable OOIl0010 : std_logic_vector(sig_width downto 0);
  variable Ol011lO0 : std_logic_vector(sig_width downto 0);
  variable IOOl0lII : std_logic_vector(sig_width downto 0);
  variable l11Illl0 : std_logic_vector(sig_width downto 0);
  variable lO001Ol0 : std_logic_vector(sig_width downto 0);
  variable IOIlII10 : std_logic_vector(qwidth downto 0);
  variable O10110O1 : std_logic_vector(sig_width downto 0);
  variable lO011100 : std_logic_vector(1 downto 0);
  variable I11IO1I1 : std_logic_vector(rnd_width - 1 downto 0);
  variable OO000O0O : std_logic_vector(8     - 1 downto 0);
  variable I11OOI1O : std_logic_vector(exp_width - 1 downto 0);
  variable I110OIOO : std_logic_vector(sig_width - 1 downto 0);
  variable O0OOIl0l : std_logic_vector(sig_width - 1 downto 0);
  variable l11I1010 : std_logic_vector(sig_width - 2 downto 0);
  variable O00OO1I0 : std_logic_vector((exp_width + sig_width) downto 0);
  variable IIl1O10O : std_logic_vector((exp_width + sig_width) downto 0);
  variable O10I0O00 : std_logic_vector(ext - 1 downto 0);
  variable O100101I : std_logic_vector(sig_width + ext downto 0);
  variable O0OI1IO1 : std_logic_vector(sig_width + ext downto 0);
  variable lI1I01Ol : std_logic_vector(sig_width + ext downto 0);
  variable I0l1O011 : std_logic_vector(sig_width + ext downto 0);
  variable O00O1Ol1 : std_logic_vector(exp_width - 1 downto 0);
  variable II01O1O0 : std_logic_vector(exp_width - 1 downto 0);
  variable OIIO0OOl : std_logic_vector(exp_width + 1 downto 0);
  variable l0OOOIll : std_logic_vector(sig_width downto 0);
  variable lO0110ll : std_logic_vector(2 * sig_width + 1 downto 0);
  variable I0OI1lO0 : std_logic_vector(sig_width downto 0);
  variable O011IOO0 : std_logic;
  variable I101O11O : std_logic;
  variable I00lIO1l : BOOLEAN;
  variable lOI111I1 : BOOLEAN;
  variable O100O11l : BOOLEAN;
  variable l10OO1I0 : BOOLEAN;
  variable l1O1Ol0O : BOOLEAN;
  variable I000lO00 : BOOLEAN;
  variable l1OllI0I : BOOLEAN;
  variable lO00I10I : BOOLEAN;
  variable IO0I1O10 : INTEGER;
  variable O101OOOO : INTEGER;
  variable O010OOO1 : INTEGER;
  variable O0OI0OO0 : INTEGER;
  variable l101O0Ol : INTEGER;
  variable I010IlI0 : std_logic;
  variable OI1IOllI : std_logic;
  variable l0III011 : std_logic_vector(sig_width downto 0);
  variable II0IIO1O : std_logic_vector(sig_width downto 0);
  variable OOl0111O : std_logic_vector(8 - sig_width downto 0);
  variable O1lO00O0 : std_logic_vector(8 downto 0);
  variable l110l11I : std_logic_vector(9 downto 0);
  variable I1O0I10O : std_logic_vector(10 downto 0);
  variable OlOI1111 : std_logic_vector(19 downto 0);
  variable I0I0Il0O : std_logic_vector(8 downto 0);
  variable O00Ol011 : std_logic_vector(19 downto 0);
  variable IO00O1O1 : std_logic_vector(sig_width + 9 downto 0);
  variable IOOlIOOO : std_logic;
  variable OOI10OIO : std_logic_vector(8 downto 0);
  variable l0IO1lOO : std_logic_vector(sig_width + 9 downto 0);
  variable OO0OO1I0 : std_logic_vector(sig_width + 1 downto 0);
  variable O00OI010 : std_logic_vector(2 * sig_width - 7 downto 0);
  variable IOIlOO00 : std_logic_vector(sig_width + 3 downto 0);
  variable O0O0IIII : std_logic_vector(sig_width + 3 downto 0);
  variable II11llO0 : std_logic_vector(sig_width + 3 downto 0);
  variable l0101100 : std_logic;
  variable l0I1OOll : std_logic_vector(sig_width + 3 downto 0);
  variable OIlI10I1 : std_logic_vector(2 * sig_width - 21 downto 0);
  variable Ol1O10O0 : std_logic_vector(sig_width - 11 downto 0);
  variable O1l11OIO : std_logic_vector(2 * sig_width - 21 downto 0);
  variable Il101Il1 : std_logic_vector(sig_width + 3 downto 0);
  variable IOll10OO : std_logic;
  variable O0l0O011 : std_logic_vector(sig_width + 3 downto 0);
  variable OOO01OO1 : std_logic_vector(sig_width - 24 downto 0);
  variable O0O1011O : std_logic_vector(2 * sig_width - 47 downto 0);
  variable llOO0II1 : std_logic_vector(2 * sig_width - 47 downto 0);
  variable O010I0IO : std_logic_vector(sig_width - 25 downto 0);
  variable OOOl110I : std_logic_vector(sig_width + 3 downto 0);
  variable O00O00O1 : std_logic;
  variable lI100I0I : std_logic_vector(sig_width + 3 downto 0);
  variable I10l01Il : std_logic_vector(8 downto 0);
  variable l1011lII : std_logic_vector(sig_width - 1 downto 0);
  variable I0Il1OII : std_logic_vector(7 - sig_width downto 0);
  variable O11O0O01 : std_logic_vector(8 downto 0);
  variable O1O0011O : std_logic_vector(sig_width + 3 downto 0);
  variable O1O1O01l : std_logic_vector(sig_width + 3 downto 0);
  variable l0I1OI0l : std_logic_vector(sig_width + 3 downto 0);
  variable ll1110OO : std_logic_vector(sig_width - 1 downto 0);
  variable OIOO1O0O : std_logic_vector(sig_width + 3 downto 0);
  variable IIOI0lOO : std_logic_vector(sig_width downto 0);
  variable O11OOOOl : std_logic_vector(sig_width downto 0);
  variable OO1110O0 : std_logic_vector(sig_width downto 0);
  variable I01II0I0 : std_logic_vector(sig_width downto 0);
  variable IOIOI010 : std_logic_vector(sig_width downto 0);
  variable I11OIl0O : std_logic;
  variable IOO101lO : std_logic;
  variable l0lO100O : std_logic;
  variable IIIl11O1 : std_logic;
  variable l00IlOl1 : std_logic_vector(13 downto 0);

  begin

  I101O11O := a((exp_width + sig_width)) xor b((exp_width + sig_width));
  l1l1O100 := a(((exp_width + sig_width) - 1) downto sig_width);
  lO101111 := b(((exp_width + sig_width) - 1) downto sig_width);
  OOO111OO := a((sig_width - 1) downto 0);
  l000I1O0 := b((sig_width - 1) downto 0);
  OO000O0O := (others => '0');
  O00O1Ol1 := (others => '0');
  II01O1O0 := (others => '0');
  I11OOI1O := (others => '1');
  I110OIOO := (others => '0');
  l11I1010 := (others => '0');
  O0OOIl0l := (others => '1');
  O10I0O00 := (others => '0');
  l0OOOIll := (others => '0');
  Ol011lO0 := (others => '0');
  OOl0111O := (others => '0');
  l1011lII := (others => '0');
  I0Il1OII := (others => '0');
  ll1110OO := (others => '0');
  OIOO1O0O := ll1110OO & "1000";
  l00IlOl1 := (others => '0');
  O0OI0OO0 := 0;
  l101O0Ol := 0;

  if (sig_width <= 8) then
    O11O0O01 := l1011lII & '1' & I0Il1OII;
  else 
    O11O0O01 := (others => '0');
  end if;



  if (ieee_compliance = 1) then
    I00lIO1l := (l1l1O100 = ((((2 ** (exp_width-1)) - 1) * 2) + 1)) and (OOO111OO = 0);
    lOI111I1 := (lO101111 = ((((2 ** (exp_width-1)) - 1) * 2) + 1)) and (l000I1O0 = 0);
    O100O11l := (l1l1O100 = ((((2 ** (exp_width-1)) - 1) * 2) + 1)) and (OOO111OO /= 0);
    l10OO1I0 := (lO101111 = ((((2 ** (exp_width-1)) - 1) * 2) + 1)) and (l000I1O0 /= 0);
    l1O1Ol0O := (l1l1O100 = 0) and (OOO111OO = 0);
    I000lO00 := (lO101111 = 0) and (l000I1O0 = 0);
    l1OllI0I := (l1l1O100 = 0) and (OOO111OO /= 0);
    lO00I10I := (lO101111 = 0) and (l000I1O0 /= 0);

    O00OO1I0 := I101O11O & I11OOI1O & I110OIOO;
    IIl1O10O := '0' & I11OOI1O & l11I1010 & '1';
  else
    I00lIO1l := (l1l1O100 = ((((2 ** (exp_width-1)) - 1) * 2) + 1));
    lOI111I1 := (lO101111 = ((((2 ** (exp_width-1)) - 1) * 2) + 1));
    O100O11l := false;
    l10OO1I0 := false;
    l1O1Ol0O := (l1l1O100 = 0);
    I000lO00 := (lO101111 = 0);
    l1OllI0I := false;
    lO00I10I := false;

    O00OO1I0 := I101O11O & I11OOI1O & I110OIOO;
    IIl1O10O := '0' & I11OOI1O & I110OIOO;
  end if;

  if (ieee_compliance = 1) then
    if (I000lO00 and not(l1O1Ol0O or O100O11l or I00lIO1l) ) then
      OO000O0O(7) := '1';
    else
      OO000O0O(7) := '0';
    end if;
  else
    if (I000lO00 and not(l1O1Ol0O or O100O11l) ) then
      OO000O0O(7) := '1';
    else
      OO000O0O(7) := '0';
    end if;
  end if;

  if (O100O11l or l10OO1I0 or (I00lIO1l and lOI111I1) or (l1O1Ol0O and I000lO00)) then
    IOOIlI0I := IIl1O10O;
    OO000O0O(2) := '1';

  elsif (I00lIO1l or I000lO00) then
    IOOIlI0I := O00OO1I0;
    OO000O0O(1) := '1';

  elsif (l1O1Ol0O or lOI111I1) then
    OO000O0O(0) := '1';
    IOOIlI0I := (others => '0');
    IOOIlI0I((exp_width + sig_width)) := I101O11O;

  else

    if (ieee_compliance = 1) then

      if (l1OllI0I) then
        O0OI0OO0 := 1;
        OlOO00lO := '0' & a((sig_width - 1) downto 0);

        while (OlOO00lO(sig_width) /= '1') loop
          OlOO00lO := OO00O010(OlOO00lO, 1);
          O00O1Ol1 := O00O1Ol1 + 1;
        end loop;
      else
        O0OI0OO0 := 0;
        OlOO00lO := '1' & a((sig_width - 1) downto 0);
      end if;

      if (lO00I10I) then
        l101O0Ol := 1;
        OOIl0010 := '0' & b((sig_width - 1) downto 0);

        while (OOIl0010(sig_width) /= '1') loop
          OOIl0010 := OO00O010(OOIl0010, 1);
          II01O1O0 := II01O1O0 + 1;
        end loop;
      else
        l101O0Ol := 0;
        OOIl0010 := '1' & b((sig_width - 1) downto 0);
      end if;

    else
      OlOO00lO := '1' & a((sig_width - 1) downto 0);
      OOIl0010 := '1' & b((sig_width - 1) downto 0);
    end if;

    if (OlOO00lO = OOIl0010) then
      I010IlI0 := '1';
    else
      I010IlI0 := '0';
    end if;

    if (OOIl0010(sig_width - 1 downto 0) = 0) then
      OI1IOllI := '1';
    else
      OI1IOllI := '0';
    end if;

    l0III011 := OlOO00lO;

    if (ieee_compliance = 1) then
      II0IIO1O := OOIl0010;
    else
      II0IIO1O := '1' & l000I1O0;
    end if;

    if (sig_width >= 9) then
      O1lO00O0 := II0IIO1O(sig_width - 1 downto sig_width - 9);
    else
      O1lO00O0 := II0IIO1O(sig_width - 1 downto 0) & OOl0111O;
    end if;

    l110l11I := '1' & O1lO00O0(8 downto 0);
    I1O0I10O := ('0' & l110l11I) + 1;
    O00Ol011 := (others => '0');
    O00Ol011(19) := '1';
    OlOI1111 := OIO0O0O1(O00Ol011, I1O0I10O);
    I0I0Il0O := OlOI1111(9 downto 1);
    IO00O1O1 := I0I0Il0O * l0III011;
    IOOlIOOO := IO00O1O1(sig_width + 9);

    if (IOOlIOOO = '1') then
      OOI10OIO := IO00O1O1(sig_width + 9 downto sig_width + 1);
    else
      OOI10OIO := IO00O1O1(sig_width + 8 downto sig_width);
    end if;

    l0IO1lOO := II0IIO1O * I0I0Il0O;
    OO0OO1I0 := not l0IO1lOO(sig_width + 1 downto 0);
    O00OI010 := IO00O1O1(sig_width + 9 downto 13) * OO0OO1I0(sig_width + 1 downto 5);
    IOIlOO00 := IO00O1O1(sig_width + 9 downto 6);

    if (sig_width > 8) then
      O0O0IIII := "0000000" & O00OI010(2 * sig_width - 7 downto sig_width - 3);
    else
      O0O0IIII := (others=>'0');
    end if;

    II11llO0 := IOIlOO00 + O0O0IIII;
    l0101100 := II11llO0(sig_width + 3);

    if (sig_width <= 14) then
      if (l0101100 = '1') then
        l0I1OOll := II11llO0;
      else
        l0I1OOll := II11llO0(sig_width + 2 downto 0) & '0';
      end if;
    else
      l0I1OOll := II11llO0;
    end if;

    if (sig_width >= 11) then
      OIlI10I1 := OO0OO1I0(sig_width + 1 downto 12) * OO0OO1I0(sig_width + 1 downto 12);
      Ol1O10O0 := OIlI10I1(2 * sig_width - 21 downto sig_width - 10);
      O1l11OIO := l0I1OOll(sig_width + 3 downto 14) * Ol1O10O0;
      Il101Il1 := l0I1OOll + (l00IlOl1 & O1l11OIO(2 * sig_width - 21 downto sig_width - 10));
      IOll10OO := Il101Il1(sig_width + 3);
    else
      OIlI10I1 := (others => '0');
      Ol1O10O0 := (others => '0');
      O1l11OIO := (others => '0');
      Il101Il1 := (others => '0');
      IOll10OO := '0';
    end if;

    if (sig_width <= 30) then
      if (IOll10OO = '1') then
        O0l0O011 := Il101Il1;
      else
        O0l0O011 := Il101Il1(sig_width + 2 downto 0) & '0';
      end if;
    else
      O0l0O011 := Il101Il1;
    end if;

    if (sig_width >= 25) then
      OOO01OO1 := Ol1O10O0(sig_width - 11 downto 13);
      O0O1011O := OOO01OO1 * OOO01OO1;
      llOO0II1 := O0l0O011(sig_width + 3 downto 27) * O0O1011O(2 * sig_width - 47 downto sig_width - 23);
      O010I0IO := llOO0II1(2 * sig_width - 47 downto sig_width - 22);
      OOOl110I := O0l0O011 + (B"0000000000000000000000000000" & O010I0IO);
    else
      OOO01OO1 := (others => '0');
      O0O1011O := (others => '0');
      llOO0II1 := (others => '0');
      O010I0IO := (others => '0');
      OOOl110I := (others => '0');
    end if;
    
    O00O00O1 := OOOl110I(sig_width + 3);

    if (O00O00O1 = '1') then
      lI100I0I := OOOl110I;
    else
      lI100I0I := OOOl110I(sig_width + 2 downto 0) & '0';
    end if;

    if (sig_width = 8) then
      I10l01Il := OOI10OIO + 1;
    elsif (sig_width < 8) then
      I10l01Il := OOI10OIO + O11O0O01;
    else
      I10l01Il := (others => '0');
    end if;

    O1O0011O := l0I1OOll + OIOO1O0O;
    O1O1O01l := O0l0O011 + OIOO1O0O;
    l0I1OI0l := lI100I0I + OIOO1O0O;

    if (sig_width > 8) then
      IIOI0lOO := (others => '0');
    elsif (sig_width = 8) then
      IIOI0lOO := OOI10OIO;
    elsif (OOI10OIO(7 - sig_width) = '1') then
      IIOI0lOO := I10l01Il(8 downto 8 - sig_width);
    else
      IIOI0lOO := OOI10OIO(8 downto 8 - sig_width);
    end if;

    if (l0I1OOll(2) = '1') then
      O11OOOOl := O1O0011O(sig_width + 3 downto 3);
    else
      O11OOOOl := l0I1OOll(sig_width + 3 downto 3);
    end if;

    if (O0l0O011(2) = '1') then
      OO1110O0 := O1O1O01l(sig_width + 3 downto 3);
    else
      OO1110O0 := O0l0O011(sig_width + 3 downto 3);
    end if;

    if (lI100I0I(2) = '1') then
      I01II0I0 := l0I1OI0l(sig_width + 3 downto 3);
    else
      I01II0I0 := lI100I0I(sig_width + 3 downto 3);
    end if;

    if (sig_width <= 8) then
      IOIOI010 := IIOI0lOO;
      IOO101lO := IOOlIOOO;
    elsif (sig_width <= 14) then
      IOIOI010 := O11OOOOl;
      IOO101lO := l0101100;
    elsif (sig_width <= 30) then
      IOIOI010 := OO1110O0;
      IOO101lO := IOll10OO;
    else
      IOIOI010 := I01II0I0;
      IOO101lO := O00O00O1;
    end if;

    if (faithful_round = 1) then
      if (IOIOI010 = 0) then
        I11OIl0O := '1';
      else
        I11OIl0O := '0';
      end if;
    else
      I11OIl0O := '0';
    end if;

    if (l000I1O0 /= 0) then
      l0lO100O := not I010IlI0;
    else
      l0lO100O := '0';
    end if;


    O100101I := OlOO00lO & O10I0O00;
    O0OI1IO1 := O10I0O00 & OOIl0010;

    if (OOIl0010 /= Ol011lO0) then
      lI1I01Ol := OIO0O0O1(O100101I, O0OI1IO1);
      I0l1O011 := O10O1OO0(O100101I, O0OI1IO1);

      IOIlII10 := lI1I01Ol;

      if (faithful_round = 1) then
        O10110O1 := (others => l0lO100O);
      else
        O10110O1 := I0l1O011(sig_width downto 0);
      end if;
    end if;

    lI00O00I := ((B"00" & l1l1O100) - (B"00" & O00O1Ol1) + O0OI0OO0) - ((B"00" & lO101111) - (B"00" & II01O1O0) + l101O0Ol) + ((2 ** (exp_width-1)) - 1);
    IOO1O01O := ((B"00" & lO101111) + (B"00" & O00O1Ol1) + l101O0Ol) - ((B"00" & l1l1O100) + (B"00" & II01O1O0) + ((2 ** (exp_width-1)) - 1) + O0OI0OO0);
    O10101O1 := lI00O00I - 1;
    I1O1O11O := IOO1O01O + 1;

    if (faithful_round = 1) then
      l11Illl0 := IOIOI010;
    elsif (IOIlII10(qmsb) = '1') then
      l11Illl0 := IOIlII10(qmsb downto 2);
    else
      l11Illl0 := IOIlII10(qmsb - 1 downto 1);
    end if;

    if (IOIlII10(qmsb) = '1') then
      lO011100 := IOIlII10(2 downto 1);
      IO10IOO1 := lI00O00I;
      l10OO10O := IOO1O01O;
    else
      lO011100 := IOIlII10(1 downto 0);
      IO10IOO1 := O10101O1;
      l10OO10O := I1O1O11O;
    end if;

    if (IO10IOO1 <= 0 or IO10IOO1(exp_width + 1) = '1') then
      IIIl11O1 := '1';
    else
      IIIl11O1 := '0';
    end if;

    if (faithful_round = 1) then
      if ((OI1IOllI = '1' or I010IlI0 = '1') and IIIl11O1 = '0') then
        O011IOO0 := '0';
      else 
        O011IOO0 := '1';
      end if;
    else
      if (O10110O1 = 0) then
        O011IOO0 := '0';
      else
        O011IOO0 := '1';
      end if;
    end if;
  
    if (ieee_compliance = 1) then
      if ((IO10IOO1 <= 0) or (IO10IOO1(exp_width + 1) = '1')) then
        OIIO0OOl := l10OO10O + 1;

        lO0110ll := lO1I110I(l11Illl0 & l0OOOIll, conv_integer(OIIO0OOl));
        l11Illl0 := lO0110ll(2 * sig_width + 1 downto sig_width + 1);
        I0OI1lO0 := lO0110ll(sig_width downto 0);

        if (OIIO0OOl > sig_width + 1) then
          O011IOO0 := '1';
        end if;

        lO011100(1) := l11Illl0(0);
        lO011100(0) := I0OI1lO0(sig_width);
  
        if (I0OI1lO0(sig_width - 1 downto 0) /= 0) then
          O011IOO0 := '1';
        end if;
      end if;
    end if;

    I11IO1I1 := OIIlOlO1(rnd, I101O11O, lO011100(1), lO011100(0), O011IOO0);

    if (faithful_round = 1) then
      lO001Ol0 := l11Illl0;
    elsif (I11IO1I1(rnd_inc) = '1') then
      lO001Ol0 := l11Illl0 + 1;
    else
      lO001Ol0 := l11Illl0;
    end if;

    if ((IO10IOO1 >= ((((2 ** (exp_width-1)) - 1) * 2) + 1)) and (IO10IOO1(exp_width + 1) = '0')) then
      OO000O0O(4) := '1';
      OO000O0O(5) := '1';
  
      if (I11IO1I1(rnd_hugeinfinity) = '1') then
        IOOl0lII := O00OO1I0(sig_width downto 0);
        lO1O0OI1 := conv_std_logic_vector(((((2 ** (exp_width-1)) - 1) * 2) + 1), lO1O0OI1'length);
        OO000O0O(1) := '1';
      else
        IOOl0lII := (others => '1');
        lO1O0OI1 := conv_std_logic_vector(((((2 ** (exp_width-1)) - 1) * 2) + 1) - 1, lO1O0OI1'length);
      end if;

    elsif ((IO10IOO1 <= 0) or (IO10IOO1(exp_width + 1) = '1')) then
      OO000O0O(3) := '1';

      if (ieee_compliance = 0) then
        OO000O0O(5) := '1';
      
        if (I11IO1I1(rnd_tinyminnorm) = '1') then
          IOOl0lII := (others => '0');
          lO1O0OI1 := conv_std_logic_vector(0 + 1, lO1O0OI1'length);
        else
          IOOl0lII := (others => '0');
          lO1O0OI1 := conv_std_logic_vector(0, lO1O0OI1'length);
          OO000O0O(0) := '1';
        end if;
      else
        IOOl0lII := lO001Ol0;

        lO1O0OI1 := conv_std_logic_vector(conv_integer(lO001Ol0(sig_width)), lO1O0OI1'length);

      end if;
    else 
     if ((faithful_round = 1) and (I010IlI0 = '1')) then
       IOOl0lII := (others => '0');
     else
       IOOl0lII := lO001Ol0;
     end if;

      lO1O0OI1 := IO10IOO1;
    end if;

    if ((IOOl0lII(sig_width - 1 downto 0) = 0) and (lO1O0OI1(exp_width - 1 downto 0) = 0)) then
      OO000O0O(0) := '1';
    end if;

    OO000O0O(5) := OO000O0O(5) or I11IO1I1(rnd_inexact);

    IOOIlI0I := I101O11O & lO1O0OI1(exp_width - 1 downto 0) & IOOl0lII(sig_width - 1 downto 0);

  end if;


  if (Is_X(a) or Is_X(b) or Is_X(rnd)) then
  
    status <= (others => 'X');
    z <= (others => 'X');
  
  else

    status <= OO000O0O;
    z <= IOOIlI0I;

  end if;


  end process I1l100OI;

  -- pragma translate_on

end sim;

--------------------------------------------------------------------------------
-- auto generated configuration
-- pragma translate_off

configuration DW_fp_div_cfg_sim of DW_fp_div is
 for sim
 end for; -- sim
end DW_fp_div_cfg_sim;
-- pragma translate_on
