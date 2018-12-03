#!env python
#coding=utf8
#===============================================================================
#
#          FILE: cpu_utilization_control.py
#
#         USAGE: python cpu_utilization_control.py
#
#   DESCRIPTION:
#
#       OPTIONS: 
#  REQUIREMENTS: 
#          BUGS: 
#         NOTES: 
#        AUTHOR: walkerdu 
#  ORGANIZATION: 
#       CREATED: 2018-12-02 19:19:40
#      REVISION:
#===============================================================================


import os
import sys
import signal
import time

def cpu_utilization_control(pid, cpu_util):
    total_time = 1000
    run_time = total_time * cpu_util / 100.0
    sleep_time = total_time - run_time
    print run_time, sleep_time

    t1 = time.time() * 1000

    while True:
        t2 = time.time() * 1000
        delta_time = t2 - t1

        if delta_time >= run_time:
            os.kill(pid, signal.SIGSTOP)
            sleep_ms = sleep_time / 1000.0
            time.sleep(sleep_ms)
            os.kill(pid, signal.SIGCONT)
            t1 = time.time() * 1000
        else:
            sleep_ms = (run_time - delta_time) / 1000.0
            time.sleep(sleep_ms)

if __name__  == '__main__':
    if len(sys.argv) != 3:
        print "usage: bin pid cpu_limit"
        exit(-1)
    cpu_utilization_control(int(sys.argv[1]), int(sys.argv[2]))
