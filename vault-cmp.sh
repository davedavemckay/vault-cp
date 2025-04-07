#!/bin/bash

# Verify that two Vaults match
for i in $(vault kv list $1 | tail -n +3)
do
    orig=$(vault kv get $2$i | grep -A 10 '=== Data ===')
    new=$(vault kv get -mount=kv-v2 $1$i | grep -A 10 '=== Data ===')
    if [[ $orig == $new ]]
    then
        echo $i matches
    else
        echo $i does not match
    fi
done