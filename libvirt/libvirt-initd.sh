#!/bin/sh
# Starts and stops libvirtd

case "$1" in
    start)
        start-stop-daemon --start --exec /usr/local/etc/init.d/dbus
        start-stop-daemon --start --exec /usr/local/etc/init.d/avahi
        start-stop-daemon --start --exec dbus-launch libvirtd
        ;;

    stop)
        start-stop-daemon --stop --exec libvirtd
        ;;

    restart)
        $0 stop
        $0 start
        ;;

    status)
        if pidof -o %PPID libvirtd > /dev/null; then
            echo "Running"
            exit 0
        else
            echo "Not running"
            exit 1
        fi
        ;;

    *)
        echo "Usage: $0 {start|stop|restart|status}"
        exit 1
esac
