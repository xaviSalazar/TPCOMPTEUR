Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.all;

ENTITY Compteur IS
  PORT(
      clk                              : IN STD_LOGIC;
      rst                              : in  std_logic;
      busLed 					       : out  STD_LOGIC_VECTOR(3 downto 0);
      SeptSegments 					   : out  STD_LOGIC_VECTOR(0 to 6));
END Compteur;

ARCHITECTURE ARCH_ET2 OF Compteur IS
SIGNAL  count_1Hz      :unsigned (26 downto 0);
signal  clk_1Hz        :std_logic;
signal  number         :std_logic_vector (3 downto 0);

BEGIN

div_clk : PROCESS(clk)
begin
--    if rst = '0' then
--      clk_1Hz   <= '0';
--      count_1Hz   <= (others => '0');
if rising_edge(clk) then
if count_1Hz = X"2FAF080" then
clk_1Hz<= not clk_1Hz;
count_1Hz <= (others => '0');
else
count_1Hz <= count_1Hz + "1";
end IF;
end IF;
end PROCESS div_clk;

compteur : PROCESS(clk_1Hz)
begin
if rising_edge(clk_1Hz) then
if number = X"9" then
number <= (others => '0');
else
number <= number + "1";
end if;
end if;
end PROCESS compteur;

--Affichage
 busLed <= number;
SeptSegments <= "0000001" when number = "0000"  else
                "1001111" when number = "0001"  else
                "0010010" when number = "0010"  else
                "0000110" when number = "0011"  else
                "1001100" when number = "0100"  else
                "0100100" when number = "0101"  else
                "0100000" when number = "0110"  else
                "0001111" when number = "0111"  else
                "0000000" when number = "1000"  else
                "0000100" when number = "1001"  else
                "1111111";
                

END ARCH_ET2;

