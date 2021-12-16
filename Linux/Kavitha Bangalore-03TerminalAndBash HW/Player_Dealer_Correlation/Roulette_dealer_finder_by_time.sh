#!/bin/bash

# finds the roullette dealer on a given data ($1) at a given time ($2)
# this script will return two name, the first being the dealer working the AM shift,
# the second being the dealer working the PM shift
grep -i $2 $1* | awk '{print $5" "$6}'

