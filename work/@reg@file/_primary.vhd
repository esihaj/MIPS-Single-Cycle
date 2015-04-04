library verilog;
use verilog.vl_types.all;
entity RegFile is
    port(
        clk             : in     vl_logic;
        reg_write       : in     vl_logic;
        addr_A          : in     vl_logic_vector(2 downto 0);
        addr_B          : in     vl_logic_vector(2 downto 0);
        addr_write      : in     vl_logic_vector(2 downto 0);
        write_data      : in     vl_logic_vector(7 downto 0);
        data_A          : out    vl_logic_vector(7 downto 0);
        data_B          : out    vl_logic_vector(7 downto 0)
    );
end RegFile;
