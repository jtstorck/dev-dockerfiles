curl 'https://data.cityofnewyork.us/api/views/nc67-uf89/rows.csv?accessType=DOWNLOAD' | \
  tail -n +2 `#Remove header` | \
  head -n59620 `#Remove last line, it was missing fields` | \
  sed 's/02\/29\/2015/02\/28\/2015/g' `#Remove 02/29/2015 date from dataset` | \
  sed 's/0.:06A/03:06A/g' `#Fix date typo` | \
  sed 's/[2-9]\([3-9]:[0-9]\+[AP]\)/0\1/g' `#Any time with first hour number > 1 and second > 2 gets a zero` | \
  sed 's/[2-9]\([0-2]:[0-9]\+[AP]\)/1\1/g' `#Any time with first hour number > 1 and second <= 2 gets a one` | \
  sed 's/\([0-9]\+:[0-9]\+\)\([AP]\)/\1 \2M/g' `#Take A or P from end of time and add space and an M so 10:10P -> 10:10 PM` > /tmp/violations
