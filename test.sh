#!/bin/bash

APP_PID=""

LOG_FILE=$(pwd)/syscalls_log.txt
ERROR_FILE=$(pwd)/syscalls_error.txt

generate_trace () {
	local syscall_name="$1"
	local session_name="$2"
	local session_path="$3/${session_name}"

	local trigger_start="$4"
	local trigger_end="$5"


	./${syscall_name} $trigger_start $trigger_end &
	APP_PID=$!

	lttng create ${session_name} -o $session_path 1>> $LOG_FILE 2>> $ERROR_FILE
	lttng enable-event -k --syscall $syscall_name 1>> $LOG_FILE 2>> $ERROR_FILE
	lttng track -k -p $APP_PID 1>> $LOG_FILE 2>> $ERROR_FILE

	lttng start 1>> $LOG_FILE 2>> $ERROR_FILE

	touch $trigger_start

	until [ -f $trigger_end ]
	do
		sleep 1
	done

	lttng stop 1>> $LOG_FILE 2>> $ERROR_FILE
	lttng destroy -a 1>> $LOG_FILE 2>> $ERROR_FILE
}

cleanup () {
	rm -rf $traces_path
	rm -rf triggers_path
}

syscall_to_test=("clone" "arm_fadvise64_64" "mmap2" "sync_file_range2")

traces_path=$(pwd)/traces
triggers_path=$(pwd)/triggers
mkdir -p ${triggers_path}

session_path=${traces_path}/${session_name}
triggers_template="lttng-triggers-syscall.XXXXXX"

for syscall_name in "${syscall_to_test[@]}"; do
	echo "----------- Testing ${syscall_name} --------------"
	session_name="syscall-test-${syscall_name}"
	trigger_start=$(mktemp -u -p ${triggers_path} ${triggers_template})
	trigger_end=$(mktemp -u -p ${triggers_path} ${triggers_template})
	generate_trace $syscall_name $session_name $session_path $trigger_start $trigger_end
	rm $trigger_start $trigger_end
	babeltrace $session_path/$session_name
	echo "--------------------------------------------------"
done


rm -rf $session_path
rm -rf $triggers_path

