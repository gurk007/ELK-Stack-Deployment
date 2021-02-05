#! /bin/bash
echo "syntax roulette_dealer_finder_by_time <date> <time> <AM/PM>"
echo "example  ./roulette_dealer_finder_by_time 0310 05:00 AM"

echo "Hour AM/PM     Roulette_Dealer"
grep ''$2'.*'$3'' $1_Dealer_schedule | awk '{print $1, $2, $5, $6}'




