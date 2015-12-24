#!/bin/bash
# LGSM fn_debug function
# Author: Daniel Gibbs
# Website: http://gameservermanagers.com
lgsm_version="061115"

# Description: Runs the server without tmux. Runs direct from the terminal.

local modulename="Debug"
check_root.sh
fn_check_systemdir
fn_check_ip
fn_check_logs
fn_details_distro
fn_parms
echo ""
echo "${gamename} Debug"
echo "============================"
echo ""
echo -e "Distro: ${os}"
echo -e "Arch: ${arch}"
echo -e "Kernel: ${kernel}"
echo -e "Hostname: $HOSTNAME"
echo ""
echo "Start parameters:"
if [ "${engine}" == "source" ]||[ "${engine}" == "goldsource" ]; then
	echo "${executable} ${parms} -debug"
else
	echo "${executable} ${parms}"
fi
echo ""
echo -e "Use for identifying server issues only!"
echo -e "Press CTRL+c to drop out of debug mode."
fn_printwarningnl "If ${servicename} is already running it will be stopped."
echo ""
while true; do
	read -e -i "y" -p "Continue? [Y/n]" yn
	case $yn in
	[Yy]* ) break;;
	[Nn]* ) echo Exiting; return;;
	* ) echo "Please answer yes or no.";;
esac
done
fn_scriptlog "Starting debug"
fn_printinfonl "Stopping any running servers"
fn_scriptlog "Stopping any running servers"
sleep 1
fn_stop
fn_printdots "Starting debug"
sleep 1
fn_printok "Starting debug"
fn_scriptlog "Started debug"
sleep 1
echo -en "\n"
cd "${executabledir}"
if [ "${engine}" == "source" ]||[ "${engine}" == "goldsource" ]; then
	if [ "${gamename}" == "Counter Strike: Global Offensive" ]; then
		startfix=1
		fn_csgofix
	elif [ "${gamename}" == "Insurgency" ]; then
		fn_insfix
	elif [ "${gamename}" == "ARMA 3" ]; then
		fn_arma3fix	
	fi
	${executable} ${parms} -debug
else
	${executable} ${parms}
fi