library verilog;
use verilog.vl_types.all;
entity InstMem is
    port(
        addr            : in     vl_logic_vector(11 downto 0);
        out_data        : out    vl_logic_vector(18 downto 0)
    );
end InstMem;
