# !/bin/bash

echo 20480 | sudo tee /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages

for pagesize in 4096 8192 16384 32768 65536 131072 262144 524288 1048576 2097152; do
    ./ec_simple_example -k 3 -p 2 -l $pagesize
done

echo 0 | sudo tee /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
