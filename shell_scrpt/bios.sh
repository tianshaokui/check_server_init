#!/bin/sh
dmidecode -t bios | grep Vendor | grep -q -i hp && servertype=hp
dmidecode -t bios | grep Vendor | grep -q -i Dell && servertype=dell
dmidecode -t bios | grep Vendor | grep -q -i ibm && servertype=ibm
dmidecode -t bios | grep Vendor | grep -q -i LENOVO && servertype=LENOVO
dmidecode -t bios | grep Vendor | grep -q -i 'Insyde Corp'  && servertype=huawei
echo $servertype
if [  "$servertype" = "dell" -a -n "$servertype" ]; then
	if [ -z "`rpm -qa |grep srvadmin-all`" ];then
         yum -y install srvadmin-all -q
	fi
	/opt/dell/srvadmin/sbin/omreport chassis biossetup|grep -e 'System Profile  ' -e 'Node Interleaving'|awk -F ":" '{print $NF}'|awk '{print $1}'
elif [  "$servertype" = "hp" -a -n "$servertype" ]; then
	 if [ -z "`rpm -qa |grep hp-scripting-tools`" ];then
         	yum install hp-scripting-tools -y -q
		yum install hp-health -y -q
         	yum install hpssacli -y -q
	fi
	conrep -s -f /tmp/hpbios.txt
	if [ -z "`cat /tmp/hpbios.txt|grep "HP_Power_Profile"|grep "Maximum_Performance"`"];then
		echo "HP_Power_Profile is fail"
	else
		echo "HP_Power_Profile is OK"
	fi
elif [  "$servertype" = "ibm" -a -n "$servertype" ]; then
	if [ -z "`rpm -qa |grep lnvgy_utl_asu`" ];then
        	yum install lnvgy_utl_asu -y
      	fi
	/opt/lenovo/toolscenter/asu/asu64 save /tmp/ibm_m5_bios
	if [ -z "`cat /tmp/ibm_m5_bios|grep Power.PlatformControlledType|awk -F "=" '{print $NF}'`" ]; then
		echo "Power.PlatformControlledType is fail"
	else
		echo "Power.PlatformControlledType is ok"
	fi
elif [  "$servertype" = "LENOVO" -a -n "$servertype" ]; then
	if [ -z "`rpm -qa |grep lnvgy_utl_asu`" ];then
		yum install lnvgy_utl_asu -y -q
	fi
	if [ "`cat /tmp/len_m5_bios|grep Power.PlatformControlledType|awk -F "=" '{print $NF}'`" != "Maximum Performance" ];then
		echo "Power.PlatformControlledType is fail"
	else
		echo "Power.PlatformControlledType is ok"
	fi
fi
