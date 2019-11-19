#!/bin/bash - 
#===============================================================================
#
#          FILE: proc_stat.sh
# 
#         USAGE: ./proc_stat.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: walkerdu (walker), walkerdu@tencent.com
#  ORGANIZATION: Tencent
#       CREATED: 2018-11-17 11:06:52 AM
#      REVISION:  ---
#===============================================================================


if [ $# != 1 ];then
    echo "usage: ./bin process_id"
    exit -1
fi

stat_note_file='/tmp/proc_stat.txt'
cat>$stat_note_file<<EOF
  pid           process id
  tcomm         filename of the executable
  state         state (R is running, S is sleeping, D is sleeping in an uninterruptible wait, Z is zombie, T is traced or stopped)
  ppid          process id of the parent process
  pgrp          pgrp of the process
  sid           session id
  tty_nr        tty the process uses
  tty_pgrp      pgrp of the tty
  flags         task flags
  min_flt       number of minor faults
  cmin_flt      number of minor faults with child's
  maj_flt       number of major faults
  cmaj_flt      number of major faults with child's
  utime         user mode jiffies
  stime         kernel mode jiffies
  cutime        user mode jiffies with child's
  cstime        kernel mode jiffies with child's
  priority      priority level
  nice          nice level
  num_threads   number of threads
  it_real_value (obsolete, always 0)
  start_time    time the process started after system boot
  vsize         virtual memory size
  rss           resident set memory size
  rsslim        current limit in bytes on the rss
  start_code    address above which program text can run
  end_code      address below which program text can run
  start_stack   address of the start of the main process stack
  esp           current value of ESP
  eip           current value of EIP
  pending       bitmap of pending signals
  blocked       bitmap of blocked signals
  sigign        bitmap of ignored signals
  sigcatch      bitmap of caught signals
  0             (place holder, used to be the wchan address, use /proc/PID/wchan instead)
  0             (place holder)
  0             (place holder)
  exit_signal   signal to send to parent thread on exit
  task_cpu      which CPU the task is scheduled on
  rt_priority   realtime priority
  policy        scheduling policy (man sched_setscheduler)
  blkio_ticks   time spent waiting for block IO
  gtime         guest time of the task in jiffies
  cgtime        guest time of the task children in jiffies
  start_data    address above which program data+bss is placed
  end_data      address below which program data+bss is placed
  start_brk     address above which program heap can be expanded with brk()
  arg_start     address above which program command line is placed
  arg_end       address below which program command line is placed
  env_start     address above which program environment is placed
  env_end       address below which program environment is placed
  exit_code     the thread's exit_code in the form reported by the waitpid system call
EOF

declare -A note_array
loop_i=0
while read line
do
    note_array[$loop_i]=$line
    loop_i=$((loop_i + 1))
done < $stat_note_file 

loop_i=0
for field in $(cat /proc/$1/stat)
do
    printf "%-20s %s\n" $field "${note_array[$loop_i]}"
    loop_i=$((loop_i + 1))
done
