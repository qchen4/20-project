##--- dump waveform and debug mode ---##
vlog -O4 -vlog01compat -f flist.f

vsim -c +nowarnTSCALE -voptargs=+acc +nospecify  -L ./work -l load.log tb

radix hex
add log -r /tb/*
do ./wave.do
run -all


