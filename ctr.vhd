--A MOD-64 counter module used to restrict any one processor's 
--access to SRAM for a maximum of 64 clock cycles

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity ctr_mod is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (6 downto 0);
           max_pulse : out STD_LOGIC);
end ctr_mod;

architecture Behavioral of ctr_mod is
signal count : integer:=0;
signal times_up : STD_LOGIC;
begin

--ff generation
    counter : process (clk, rst)
    begin
    if (rst = '1') then 
        count <= 0; 
        times_up <= '0';
    elsif (clk' event and clk = '1') then
        if (en = '1') then
            count <= count + 1;
            times_up <= '0';
                if (count = 63) then
                count <= 0;
                times_up <= '1';
                end if;
        end if;
    end if;
    end process counter;
output <= std_logic_vector(to_unsigned(count, 7));
max_pulse <= times_up;
end Behavioral;
