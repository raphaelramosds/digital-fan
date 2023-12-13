library verilog;
use verilog.vl_types.all;
entity DigitalFan_vlg_sample_tst is
    port(
        bi              : in     vl_logic;
        bm              : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        x               : in     vl_logic_vector(8 downto 0);
        sampler_tx      : out    vl_logic
    );
end DigitalFan_vlg_sample_tst;
