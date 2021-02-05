#! /bin/bash
echo "syntax - roulette_dealer_finder_by_time_and_game.sh <date> <time> <AM/PM> <[b][r][t]>"
echo "b-BlackJack, r-Roulette, t-Texas HoldEM"
echo "example  roulette_dealer_finder_by_time_and_game.sh 0310 05:00 AM b"
echo " "
echo " "


if [ $4 == b ]; then
echo "Hour AM/PM  BlackJack Dealer"
grep ''$2'.*'$3'' $1_Dealer_schedule | 	awk '{print $1, $2, $3, $4}'
elif [ $4 == r ]; then
echo "Hour AM/PM  Roulette Dealer"
grep ''$2'.*'$3'' $1_Dealer_schedule | awk '{print $1, $2, $5, $6}'
elif [ $4 == t ];then
echo "Hour AM/PM Texas Hold EM dealer"
grep ''$2'.*'$3'' $1_Dealer_schedule | awk '{print $1, $2, $7, $7}'


fi

