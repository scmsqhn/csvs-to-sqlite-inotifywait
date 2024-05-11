#!/bin/bash

while true
do
    FILENAME=`date "+%s"`
    cp acc_00001.csv ./csv_input/$FILENAME\-1.csv
    cp acc_00001.csv ./csv_input/$FILENAME\-2.csv
    cp acc_00001.csv ./csv_input/$FILENAME\-3.csv
    sleep 3
done

