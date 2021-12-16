#!/Bin/bash

echo "March 12, Roulette Dealer Schedule:\n"
awk '{print $1,$2,$5,$6}' ./0312_Dealer_schedule > Mar12RouletteDealerSchedule
echo "Completed saving to file Mar12RouletteDealerSchedule. \n"
