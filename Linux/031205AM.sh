#! /bin/bash

grep '05:00.*AM' 0312_Dealer_schedule | awk '{print $1, $2, $5, $6}' >> Dealers_working_during_losses


