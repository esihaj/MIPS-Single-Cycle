library verilog;
use verilog.vl_types.all;
entity DataMem is
    port(
        clk             : in     vl_logic;
        mem_write       : in     vl_logic;
        addr            : in     vl_logic_vector(7 downto 0);
        write_data      : in     vl_logic_vector(7 downto 0);
        out_data        : out    vl_logic_vector(7 downto 0)
    );
end DataMem;
