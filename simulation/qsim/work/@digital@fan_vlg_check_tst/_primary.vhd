library verilog;
use verilog.vl_types.all;
entity DigitalFan_vlg_check_tst is
    port(
        mode            : in     vl_logic;
        q               : in     vl_logic;
        v               : in     vl_logic_vector(1 downto 0);
        sampler_rx      : in     vl_logic
    );
end DigitalFan_vlg_check_tst;
