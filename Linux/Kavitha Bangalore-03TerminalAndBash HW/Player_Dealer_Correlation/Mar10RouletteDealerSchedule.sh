#!/Bin/bash

echo "March 10, Roulette Dealer Schedule:\n"
awk '{print $1,$2,$5,$6}' ./0310_Dealer_schedule > Mar10RouletteDealerSchedule
echo "Completed saving to file Mar10RouletteDealerSchedule. \n"
