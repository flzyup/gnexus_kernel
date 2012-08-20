#!/system/bin/sh
for BLOCK in `ls /sys/block`
do
	echo "Setting BFQ for $BLOCK"
	echo bfq > /sys/block/$BLOCK/queue/scheduler
done
