#! /bin/bash

grep '11:00.*PM' 0310_Dealer_schedule | awk '{print $1, $2, $5, $6}' >> Dealers_working_during_losses


