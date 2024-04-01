speaker-synth.json: speaker.vhd rpll.v
	yosys -m ghdl -s synth.ys

%-tec0117.fs: %-tec0117.json
	gowin_pack -d GW1N-9 -o $@ $<

%-tec0117.json: %-synth.json tec0117.cst
	nextpnr-himbaechel --json $< --write $@ --device GW1NR-LV9QN88C6/I5 --vopt family=GW1N-9 --vopt cst=tec0117.cst

%-tec0117-prog: %-tec0117.fs
	openFPGALoader -b tec0117 $^