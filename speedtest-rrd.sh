#!/bin/sh

#get into /tmp
cd /tmp

# get the EPOCH date
DATE=$(/bin/date +%s)

#Get the raw data
/usr/local/bin/speedtest-cli --simple > /tmp/speedtest-rrd.txt

#Clean it up and get raw Ping time in ms
RAW_MS=$(cat /tmp/speedtest-rrd.txt | grep P | sed -r 's/\s+//g'| cut -d":" -f2 | cut -d"m" -f1)

#Clean it up and get raw Download time in MiB
RAW_DL=$(cat /tmp/speedtest-rrd.txt | grep D | sed -r 's/\s+//g'| cut -d":" -f2 | cut -d"M" -f1)

#Clean it up and get raw Upload time in MiB
RAW_UP=$(cat /tmp/speedtest-rrd.txt | grep U | sed -r 's/\s+//g'| cut -d":" -f2 | cut -d"M" -f1)

#get data into rrd
cd /etc/speedtest/
rrdtool update /etc/speedtest/speedtest_ms.rrd $DATE:$RAW_MS
rrdtool update /etc/speedtest/speedtest_dl.rrd $DATE:$RAW_DL
rrdtool update /etc/speedtest/speedtest_up.rrd $DATE:$RAW_UP


#create the daily graphs
# Ping
rrdtool graph /var/www/html/speedtest/speedtest_ms_day.png \
--title 'Ping daily' \
--vertical-label 'Thousand miliseconds' \
--width '620' \
--height '200' \
-s -1day DEF:speedtest_ms=/etc/speedtest/speedtest_ms.rrd:temp:AVERAGE \
GPRINT:speedtest_ms:LAST:"Last %8.3lf%s ms \\n" \
GPRINT:speedtest_ms:MAX:"Max %8.3lf%s ms" \
GPRINT:speedtest_ms:MIN:"Min %8.3lf%s ms" \
GPRINT:speedtest_ms:AVERAGE:"AVG %8.3lf%s ms" \
VDEF:avg=speedtest_ms,AVERAGE \
'LINE1:speedtest_ms#000000:Last' \
'LINE2:avg#FFBB00:Average :dashes=10'

#Download
rrdtool graph /var/www/html/speedtest/speedtest_dl_day.png \
--title 'Download daily' \
--vertical-label 'Mbit' \
--width '620' \
--height '200' \
-s -1day DEF:speedtest_dl=/etc/speedtest/speedtest_dl.rrd:temp:AVERAGE \
GPRINT:speedtest_dl:LAST:"Last %8.2lf%s Mbit \\n" \
GPRINT:speedtest_dl:MAX:"Max %8.2lf%s Mbit" \
GPRINT:speedtest_dl:MIN:"Min %8.2lf%s Mbit" \
GPRINT:speedtest_dl:AVERAGE:"AVG %8.2lf%s Mbit" \
VDEF:avg=speedtest_dl,AVERAGE \
'LINE1:speedtest_dl#000000:Last' \
'LINE2:avg#FFBB00:Average :dashes=10'

# Upload
rrdtool graph /var/www/html/speedtest/speedtest_up_day.png \
--title 'Upload daily' \
--vertical-label 'Mbit' \
--width '620' \
--height '200' \
-s -1day DEF:speedtest_up=/etc/speedtest/speedtest_up.rrd:temp:AVERAGE \
GPRINT:speedtest_up:LAST:"Last %8.2lf%s Mbit \\n" \
GPRINT:speedtest_up:MAX:"Max %8.2lf%s Mbit" \
GPRINT:speedtest_up:MIN:"Min %8.2lf%s Mbit" \
GPRINT:speedtest_up:AVERAGE:"AVG %8.2lf%s Mbit" \
VDEF:avg=speedtest_up,AVERAGE \
'LINE1:speedtest_up#000000:Last' \
'LINE2:avg#FFBB00:Average :dashes=10'

#create the week graphs
# Ping
rrdtool graph /var/www/html/speedtest/speedtest_ms_week.png \
--title 'Ping week' \
--vertical-label 'Thousand miliseconds' \
--width '620' \
--height '200' \
-s -1week DEF:speedtest_ms=/etc/speedtest/speedtest_ms.rrd:temp:AVERAGE \
GPRINT:speedtest_ms:LAST:"Last %8.3lf%s ms \\n" \
GPRINT:speedtest_ms:MAX:"Max %8.3lf%s ms" \
GPRINT:speedtest_ms:MIN:"Min %8.3lf%s ms" \
GPRINT:speedtest_ms:AVERAGE:"AVG %8.3lf%s ms" \
VDEF:avg=speedtest_ms,AVERAGE \
'LINE1:speedtest_ms#000000:Last' \
'LINE2:avg#FFBB00:Average :dashes=10'

#Download
rrdtool graph /var/www/html/speedtest/speedtest_dl_week.png \
--title 'Download week' \
--vertical-label 'Mbit' \
--width '620' \
--height '200' \
-s -1week DEF:speedtest_dl=/etc/speedtest/speedtest_dl.rrd:temp:AVERAGE \
GPRINT:speedtest_dl:LAST:"Last %8.2lf%s Mbit \\n" \
GPRINT:speedtest_dl:MAX:"Max %8.2lf%s Mbit" \
GPRINT:speedtest_dl:MIN:"Min %8.2lf%s Mbit" \
GPRINT:speedtest_dl:AVERAGE:"AVG %8.2lf%s Mbit" \
VDEF:avg=speedtest_dl,AVERAGE \
'LINE1:speedtest_dl#000000:Last' \
'LINE2:avg#FFBB00:Average :dashes=10'

# Upload
rrdtool graph /var/www/html/speedtest/speedtest_up_week.png \
--title 'Upload week' \
--vertical-label 'Mbit' \
--width '620' \
--height '200' \
-s -1week DEF:speedtest_up=/etc/speedtest/speedtest_up.rrd:temp:AVERAGE \
GPRINT:speedtest_up:LAST:"Last %8.2lf%s Mbit \\n" \
GPRINT:speedtest_up:MAX:"Max %8.2lf%s Mbit" \
GPRINT:speedtest_up:MIN:"Min %8.2lf%s Mbit" \
GPRINT:speedtest_up:AVERAGE:"AVG %8.2lf%s Mbit" \
VDEF:avg=speedtest_up,AVERAGE \
'LINE1:speedtest_up#000000:Last' \
'LINE2:avg#FFBB00:Average :dashes=10'

#create the month graphs
# Ping
rrdtool graph /var/www/html/speedtest/speedtest_ms_month.png \
--title 'Ping month' \
--vertical-label 'Thousand miliseconds' \
--width '620' \
--height '200' \
-s -1month DEF:speedtest_ms=/etc/speedtest/speedtest_ms.rrd:temp:AVERAGE \
GPRINT:speedtest_ms:LAST:"Last %8.3lf%s ms \\n" \
GPRINT:speedtest_ms:MAX:"Max %8.3lf%s ms" \
GPRINT:speedtest_ms:MIN:"Min %8.3lf%s ms" \
GPRINT:speedtest_ms:AVERAGE:"AVG %8.3lf%s ms" \
VDEF:avg=speedtest_ms,AVERAGE \
'LINE1:speedtest_ms#000000:Last' \
'LINE2:avg#FFBB00:Average :dashes=10'

#Download
rrdtool graph /var/www/html/speedtest/speedtest_dl_month.png \
--title 'Download month' \
--vertical-label 'Mbit' \
--width '620' \
--height '200' \
-s -1month DEF:speedtest_dl=/etc/speedtest/speedtest_dl.rrd:temp:AVERAGE \
GPRINT:speedtest_dl:LAST:"Last %8.2lf%s Mbit \\n" \
GPRINT:speedtest_dl:MAX:"Max %8.2lf%s Mbit" \
GPRINT:speedtest_dl:MIN:"Min %8.2lf%s Mbit" \
GPRINT:speedtest_dl:AVERAGE:"AVG %8.2lf%s Mbit" \
VDEF:avg=speedtest_dl,AVERAGE \
'LINE1:speedtest_dl#000000:Last' \
'LINE2:avg#FFBB00:Average :dashes=10'

# Upload
rrdtool graph /var/www/html/speedtest/speedtest_up_month.png \
--title 'Upload month' \
--vertical-label 'Mbit' \
--width '620' \
--height '200' \
-s -1month DEF:speedtest_up=/etc/speedtest/speedtest_up.rrd:temp:AVERAGE \
GPRINT:speedtest_up:LAST:"Last %8.2lf%s Mbit \\n" \
GPRINT:speedtest_up:MAX:"Max %8.2lf%s Mbit" \
GPRINT:speedtest_up:MIN:"Min %8.2lf%s Mbit" \
GPRINT:speedtest_up:AVERAGE:"AVG %8.2lf%s Mbit" \
VDEF:avg=speedtest_up,AVERAGE \
'LINE1:speedtest_up#000000:Last' \
'LINE2:avg#FFBB00:Average :dashes=10'

#create the year graphs
# Ping
rrdtool graph /var/www/html/speedtest/speedtest_ms_year.png \
--title 'Ping year' \
--vertical-label 'Thousand miliseconds' \
--width '620' \
--height '200' \
-s -1year DEF:speedtest_ms=/etc/speedtest/speedtest_ms.rrd:temp:AVERAGE \
GPRINT:speedtest_ms:LAST:"Last %8.3lf%s ms \\n" \
GPRINT:speedtest_ms:MAX:"Max %8.3lf%s ms" \
GPRINT:speedtest_ms:MIN:"Min %8.3lf%s ms" \
GPRINT:speedtest_ms:AVERAGE:"AVG %8.3lf%s ms" \
VDEF:avg=speedtest_ms,AVERAGE \
'LINE1:speedtest_ms#000000:Last' \
'LINE2:avg#FFBB00:Average :dashes=10'

#Download
rrdtool graph /var/www/html/speedtest/speedtest_dl_year.png \
--title 'Download year' \
--vertical-label 'Mbit' \
--width '620' \
--height '200' \
-s -1year DEF:speedtest_dl=/etc/speedtest/speedtest_dl.rrd:temp:AVERAGE \
GPRINT:speedtest_dl:LAST:"Last %8.2lf%s Mbit \\n" \
GPRINT:speedtest_dl:MAX:"Max %8.2lf%s Mbit" \
GPRINT:speedtest_dl:MIN:"Min %8.2lf%s Mbit" \
GPRINT:speedtest_dl:AVERAGE:"AVG %8.2lf%s Mbit" \
VDEF:avg=speedtest_dl,AVERAGE \
'LINE1:speedtest_dl#000000:Last' \
'LINE2:avg#FFBB00:Average :dashes=10'

# Upload
rrdtool graph /var/www/html/speedtest/speedtest_up_year.png \
--title 'Upload year' \
--vertical-label 'Mbit' \
--width '620' \
--height '200' \
-s -1year DEF:speedtest_up=/etc/speedtest/speedtest_up.rrd:temp:AVERAGE \
GPRINT:speedtest_up:LAST:"Last %8.2lf%s Mbit \\n" \
GPRINT:speedtest_up:MAX:"Max %8.2lf%s Mbit" \
GPRINT:speedtest_up:MIN:"Min %8.2lf%s Mbit" \
GPRINT:speedtest_up:AVERAGE:"AVG %8.2lf%s Mbit" \
VDEF:avg=speedtest_up,AVERAGE \
'LINE1:speedtest_up#000000:Last' \
'LINE2:avg#FFBB00:Average :dashes=10'

#Clean up
rm /tmp/speedtest-rrd.txt