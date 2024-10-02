all: clean vcs run

vcs:
	vcs -full64 -sverilog -timescale=1ns/1ns \
	+v2k \
	-debug_access+all -kdb -lca \
	-f filelist.f

run:
	./simv

verdi:
	verdi -ssf rtl.fsdb -sswr signal.rc &

clean:
	rm -rf csrc simv* *.lib *.lib++ nLint*
	rm -rf *.log *.vpd *.fsdb* *.key *log rtl.fsdb*
