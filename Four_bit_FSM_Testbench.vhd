LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Four_bit_FSM_Testbench IS
END Four_bit_FSM_Testbench;
 
ARCHITECTURE behavior OF Four_bit_FSM_Testbench IS 
 
    COMPONENT Four_bit_FSM
    PORT(
         clock : IN  std_logic;
         reset : IN  std_logic;
         sequence_in : IN  std_logic;
         Ready : OUT  std_logic;
         Waiting : OUT  std_logic
        );
    END COMPONENT;
    
   --Inputs
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal sequence_in : std_logic := '0';

  --Outputs
   signal Ready : std_logic;
   signal Waiting : std_logic;

   -- Clock period definitions
   constant clock_period : time := 10 ps;
 
BEGIN
 
   uut: Four_bit_FSM PORT MAP (
          clock => clock,
          reset => reset,
          sequence_in => sequence_in,
          Ready => Ready,
 	  Waiting => Waiting
        );

   -- Clock process definitions
   clock_process :process
   begin
  clock <= '0';
  wait for clock_period/2;
  clock <= '1';
  wait for clock_period/2;
   end process;

   stim_proc: process
   begin  
  sequence_in <= '0';
  reset <= '1';
  wait for 30 ps;
      reset <= '0';
  wait for 40 ps;
  sequence_in <= '1';
  wait for 20 ps;
  sequence_in <= '0';
  wait for 10 ps;
  sequence_in <= '1'; 
  wait for 10 ps;
  sequence_in <= '0'; 
  wait for 20 ps;
  sequence_in <= '1'; 
  wait for 50 ps;
  sequence_in <= '0';      
      wait;
   end process;

END;
