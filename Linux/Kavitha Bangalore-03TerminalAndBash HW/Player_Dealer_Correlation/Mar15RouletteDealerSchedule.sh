#!/Bin/bash

echo "March 15, Roulette Dealer Schedule:\n"
awk '{print $1,$2,$5,$6}' ./0315_Dealer_schedule > Mar15RouletteDealerSchedule
echo "Completed saving to file Mar15RouletteDealerSchedule. \n"
