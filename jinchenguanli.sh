#!/bin/bash
#进程超过100给root报警
i=`ps aux | wc -l `
[ $i -gt 100 ] && echo "进程数量超过 100 个" | mail -s "报警" root
