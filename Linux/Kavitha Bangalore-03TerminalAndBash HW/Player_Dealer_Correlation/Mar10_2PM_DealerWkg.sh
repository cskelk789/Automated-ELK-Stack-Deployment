#!Bin/bash

grep '0310' /home/sysadmin/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Player_Analysis/Roulette_Losses | grep '02:00:00 PM' | awk '{print $1,$2,$3}' >> Dealers_working_during_losses
printf "Dealer/s working at the time:" >> Dealers_working_during_losses
grep '02:00:00 PM' /home/sysadmin/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Dealer_Analysis/Mar10RouletteDealerSchedule | awk '{print $3,$4}' >>Dealers_working_during_losses
