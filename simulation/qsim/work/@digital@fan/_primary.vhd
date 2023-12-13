library verilog;
use verilog.vl_types.all;
entity DigitalFan is
    port(
        clk             : in     vl_logic;
        bm              : in     vl_logic;
        bi              : in     vl_logic;
        rst             : in     vl_logic;
        x               : in     vl_logic_vector(8 downto 0);
        q               : out    vl_logic;
        mode            : out    vl_logic;
        v               : out    vl_logic_vector(1 downto 0)
    );
end DigitalFan;
