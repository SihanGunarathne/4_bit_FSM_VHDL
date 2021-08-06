library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Four_bit_FSM is
port (
 clock: in std_logic; --- clock signal
 reset: in std_logic; -- reset input
 sequence_in: in std_logic; 
 Ready : out std_logic;
 Waiting : out std_logic
);
end Four_bit_FSM;

architecture Behavioral of Four_bit_FSM is
type MOORE_FSM is (INIT, WAIT1, WAIT2, WAIT3, READYSTATE);
signal current_state, next_state: MOORE_FSM;

begin
-- Sequential memory of the VHDL MOORE FSM Sequence Detector
process(clock,reset)
begin
 if(reset='1') then
  current_state <= INIT;
 elsif(rising_edge(clock)) then
  current_state <= next_state;
 end if;
end process;
-- Next state logic of the VHDL MOORE FSM Sequence Detector
-- Combinational logic
process(current_state,sequence_in)
begin
 case(current_state) is
 when INIT =>
  if(sequence_in='1') then
   next_state <= WAIT1;
  else
   next_state <= INIT;
  end if;
 when WAIT1 =>
  if(sequence_in='1') then
   next_state <= WAIT2;
  else
   next_state <= INIT;
  end if;  
 when WAIT2 => 
  if(sequence_in='1') then
   next_state <= WAIT3;
  else
   next_state <= INIT;
  end if;  
 when WAIT3 =>
  if(sequence_in='1') then
   next_state <= READYSTATE;
  else
   next_state <= INIT;
  end if; 
when READYSTATE =>
  if(sequence_in='1') then
   next_state <= READYSTATE;
  else
   next_state <= INIT;
  end if;
 end case;
end process;

-- Output logic of the VHDL Four_bit_FSM
process(current_state)
begin 
 case current_state is
 when INIT =>
  Ready <= '0';
  Waiting <= '1';
 when WAIT1 =>
  Ready <= '0'; 
  Waiting <= '1';
 when WAIT2 => 
  Ready <= '0'; 
  Waiting <= '1';
 when WAIT3 =>
  Ready <= '0'; 
  Waiting <= '1';
 when READYSTATE =>
  Ready <= '1';
  Waiting <= '0';
 end case;
end process;

end Behavioral;
