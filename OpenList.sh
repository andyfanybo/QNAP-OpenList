#!/bin/sh
CONF=/etc/config/qpkg.conf
QPKG_NAME="OpenList"
QPKG_ROOT=`/sbin/getcfg $QPKG_NAME Install_Path -f ${CONF}`
APACHE_ROOT=`/sbin/getcfg SHARE_DEF defWeb -d Qweb -f /etc/config/def_share.info`
export QNAP_QPKG=$QPKG_NAME


export QPKG_ROOT
export QPKG_NAME

#export PATH=$QPKG_ROOT/bin:$PATH

export DESC=$QPKG_NAME

export SHELL=/bin/sh
export LC_ALL=en_US.UTF-8
export USER=admin
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export HOME=$QPKG_ROOT
export HOSTNAME=$HOSTNAME

export TMPDIR=$QPKG_ROOT/TMPDIR
mkdir -p $TMPDIR

export TZ=$(/sbin/getcfg System 'Time Zone' -f /etc/config/uLinux.conf)


export PIDF=/var/run/$QPKG_NAME.pid



case "$1" in
  start)
    ENABLED=$(/sbin/getcfg $QPKG_NAME Enable -u -d FALSE -f $CONF)
    if [ "$ENABLED" != "TRUE" ]; then
        echo "$QPKG_NAME is disabled."
        exit 1
    fi

/bin/ln -sf $QPKG_ROOT /opt/$QPKG_NAME ;
/bin/ln -sf $QPKG_ROOT/openlist.bin /usr/bin/openlist ;

cd $QPKG_ROOT

if test -f data/config.json; then
    echo "OpenList data/config.json File exists"
else
    echo "File does not exist"
    ./openlist admin 2>&1 > /dev/null | tee ${QPKG_ROOT}/first_startup.log ;

####


export TEMP_PASS=$(awk '{for(i=0;i<=NF;i++) if (tolower($i)=="is:") print $(i+1)}' ${QPKG_ROOT}/first_startup.log);

#send temp pass to log

/sbin/log_tool  -t1 -uSystem -p127.0.0.1 -mlocalhost -a "[OpenList] the temporary password from is $TEMP_PASS"

fi

./openlist server &
echo $! > $PIDF


    ;;

  stop)

ID=$(more /var/run/$QPKG_NAME.pid)

        if [ -e $PIDF ]; then
            kill -9 $ID
            rm -f $PIDF
        fi

killall -9 openlist

rm -rf $TMPDIR
rm -rf /opt/$QPKG_NAME

    ;;

  restart)
    $0 stop
    $0 start
    ;;
  remove)
    ;;

  *)
    echo "Usage: $0 {start|stop|restart|remove}"
    exit 1
esac

exit 0
