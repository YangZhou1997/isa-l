# !/bin/bash

all_ps=(512 1024 2048 4096 8192 16384 32768 65536 131072 262144 524288 1048576 2097152 4194304 8388608 16777216 33554432 67108864)
# all_ps=(4194304 8388608 16777216 33554432 67108864)

make clean
make
echo 0 | sudo tee /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
for k in 3 8; do
    all_res=""
    for pagesize in ${all_ps[@]}; do
        output=`taskset -c 0 ./ec_simple_example -k $k -p 2 -l $pagesize`
        echo $output
        number=`echo $output | grep speed | awk '{ print $11; }'`
        all_res="$all_res $number"
    done
    echo "without hugepage RS($k, 2): " $all_res
done

make clean
make CFLAGS="-DUSING_HG"
echo 20000 | sudo tee /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
for k in 3 8; do
    all_res=""
    for pagesize in ${all_ps[@]}; do
        output=`taskset -c 0 ./ec_simple_example -k $k -p 2 -l $pagesize`
        echo $output
        number=`echo $output | grep speed | awk '{ print $11; }'`
        all_res="$all_res $number"
    done
    echo "with hugepage RS($k, 2): " $all_res
done
echo 0 | sudo tee /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
