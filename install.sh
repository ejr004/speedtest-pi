#!/sh/bin

# Creating base dir
mkdir -p /root/scripts \
/etc/speedtest/ \
/var/www/html/speedtest/

# Moving scripts to the root script directory
mkdir -p /root/scripts/
mv speedtest-rrd.sh /root/scripts/

# Moving index page to root html dir
mv index.html /var/www/html/


# Check if rrd is installed lighttpd
rpm -qa rrdtool > /dev/null
if [ $? -eq 0 ]; then
  echo "rrdtool is installed"
else
  echo "rrdtool is not installed, please install (apt-get install rrdtool) "
  exit 1
fi


# Check if cron is installed
ps cax | grep cron > /dev/null
if [ $? -eq 0 ]; then
  echo "Crontab added "
    # Add crontab entry
    echo "*/5 * * * * /root/scripts/speedtest-rrd.sh > /dev/null 2>&1" > speedtest
else
  echo "Crond is not installed, please install (apt-get install cron) "
  exit 1
fi

# Check if cron is installed lighttpd
ps cax | grep cron > /dev/null
if [ $? -eq 0 ]; then
  echo "lighttpd is installed please access http://$HOSTNAME/index.html"
else
  echo "lighttpd is not installed, please install (apt-get install lighttpd) "
  exit 1
fi

# First run of spped test
/root/scripts/speedtest-rrd.sh

echo "please check if the graphs and the rrd files was generated:"
ls -la /etc/speedtest/ /var/www/html/speedtest/