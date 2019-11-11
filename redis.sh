#! /bin/bash
startHost=51
stopHost=56
for i in $(seq ${startHost} ${stopHost})
do
	scp -o StrictHostKeyChecking=no /linux-soft/03/redis/redis-4.0.8.tar.gz root@192.168.4.${i}:/root
	ssh root@192.168.4.${i} '
		export myIp=$(ifconfig eth0 | grep inet | cut -d " " -f 10 | cut -d "." -f 4)
		export myPort=63${myIp}
		export Config_file=/etc/redis/${myPort}.conf
		export Log_file=/var/log/redis_${myPort}.log
		export Data_dir=/var/lib/redis/${myPort}
		export Executable=/usr/local/bin/redis-server
		export Cli_Executable=/usr/local/bin/redis-cli
		rm -rf /root/redis-4.0.8
		tar -xf /root/redis-4.0.8.tar.gz
		cd /root/redis-4.0.8
		yum -y install gcc
		make && make install
		cd ./utils
		installSH=install_server.sh
		sed -i "/^(\$REDIS_PORT|\$REDIS_CONFIG_FILE|\$REDIS_LOG_FILE|\$REDIS_DATA_DIR|\$REDIS_EXECUTABLE|\$CLI_EXEC)/d" ${installSH}
		sed -i "s/6379/"${myPort}"/" ${installSH}
		sed -i "68,129d;146,148d" ${installSH}
		sed -i "47a REDIS_PORT=\$1\nREDIS_CONFIG_FILE=\$2\nREDIS_LOG_FILE=\$3\nREDIS_DATA_DIR=\$4\nREDIS_EXECUTABLE=\$5\nCLI_EXEC=\$6" ${installSH}
		bash ./${installSH} ${myPort} ${Config_file} ${Log_file} ${Data_dir} ${Executable} ${Cli_Executable}
		sed -i "s/bind\ 127.0.0.1/bind\ 192.168.4."${myIp}"/" /etc/redis/${myPort}.conf
		sed -i "s/port\ 6379/port\ ${myPort}/" /etc/redis/${myPort}.conf
		sed -i "s/6379/"${myPort}"/" /etc/rc.d/init.d/redis_${myPort}
		sed -i "s/\$CLIEXEC\ -p\ \$REDISPORT\ shutdown/\$CLIEXEC\ -p\ \$REDISPORT\ -h\ 192.168.4."${myIp}" shutdown/" /etc/rc.d/init.d/redis_${myPort}
		redis-cli -h 127.0.0.1 -p ${myPort} shutdown
		/etc/init.d/redis_${myPort} restart
	'
done

for i in $(seq ${startHost} ${stopHost})
do
	ssh root@192.168.4.${i} 'hostname;netstat -antulp | grep redis'
done
