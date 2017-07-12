IP_ADDR=$(ip addr show | grep "inet " | grep 10.19.110.* |  grep -v "127.0.0.1" | awk '{print $2}' | cut -d '/' -f 1)
for i in {1..100};do
./proton-sender -t unicast/traffic -l -c -1 -S 1000 -m 100 -M 100 -a $IP_ADDR:5672 & 
done
