export GEM5_DIR=~/GEM5/gem5
export BENCHMARK="./src/blackscholes"
export ARGUMENT="./inputs/in.txt ./inputs/out.txt"
time $GEM5_DIR/build/RISCV/gem5.opt -d ~/results/m5out_riscv24 $GEM5_DIR/configs/deprecated/example/se_2.py -c $BENCHMARK -o $ARGUMENT -I 100000000 --cpu-type=O3CPU --caches --l2cache --l1d_size=256kB --l1i_size=128kB --l2_size=1MB --l1d_assoc=2 --l1i_assoc=2 --l2_assoc=1 --cacheline_size=64 --bp-type=TournamentBP  --replacement_policy=fifo

