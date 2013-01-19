#!/bin/bash

current_dir=`(cd $(dirname $0); pwd)`
rails_root=`(cd "$current_dir/../"; pwd)`
config="$rails_root/config/unicorn.conf.rb"
pid_file="$rails_root/tmp/pids/unicorn.pid"
old_pid_file="$rails_root/tmp/pids/unicorn.pid.oldbin"

start() {
  echo "starting unicorn"
  cd $rails_root
  unicorn_rails -D -c $config
  RETVAL=$?
  return $RETVAL
}

stop() {
  echo "stopping unicorn"

  if [ -f $pid_file ]; then
    kill -QUIT `cat $pid_file`
    sleep 1
    rm -fr $pid_file
  fi

  # kill worker
  pids=`ps ux |grep 'unicorn_rails worker'  | grep -v grep | awk '{print $2}'`
  for pid in $pids
  do
    kill -9 $pid
    echo "kill unicorn_rails worker pid=$pid"
  done

  # kill master
  pids=`ps ux |grep 'unicorn_rails master'  | grep -v grep | awk '{print $2}'`
  for pid in $pids
  do
    kill -9 $pid
    echo "kill unicorn_rails master pid=$pid"
  done

  RETVAL=$?
  return $RETVAL
}

reload() {
  pid=""
  if [ -f $pid_file ]; then
    pid=`cat $pid_file`
  else
    pid=`ps ux |grep 'unicorn_rails master'  | grep -v grep | awk '{print $2}'`
  fi

  if [ $pid != "" ]; then
    kill -USR2 $pid
  fi

  if [ -f $old_pid_file ]; then
    kill -QUIT `cat $old_pid_file`
  fi

  RETVAL=$?
  return $RETVAL
}

# See how we were called.
case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  restart)
    stop
    start
    ;;
  reload)
    reload
    ;;
  *)
    echo $"Usage: $prog {start|stop|restart|reload}"
    exit 1
esac

exit $RETVAL
