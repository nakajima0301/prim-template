#!/bin/bash

CMDNAME=`basename $0`

# Default value
TEMPLATE="template/default.template"
ENV="env/default.env"
QUANTITY=1

export $(cat $ENV | grep -v ^# | xargs) 

function usage() {
    echo "Usage: $CMDNAME [-f filename] [-e env] [-q quantity]" 1>&2
    exit 1
}

while getopts hf:e:q: OPT
do
    case $OPT in
        "f" ) flag_f="true"; value_f="$OPTARG";;
        "e" ) flag_e="true"; value_e="$OPTARG";;
        "q" ) flag_q="true"; value_q="$OPTARG";;
        "h" ) usage;;
        * ) usage
    esac
done

# Check template
if [[ $flag_f == "true" ]]; then
    TEMPLATE=$value_f
fi

if [[ -e $TEMPLATE ]]; then
    echo "Using template: $TEMPLATE"
else
    echo "$TEMPLATE: No such file" 1>&2
    exit 1
fi

# Check environment
if [[ $flag_e == "true" ]]; then
    ENV=$value_e
fi

if [[ -e $ENV ]]; then
    echo "Using env: $ENV"
else
    echo "$ENV: No such file" 1>&2
    exit 1
fi

# Check quantity
if [[ $flag_q == "true" ]]; then
    QUANTITY=$value_q
fi

expr $QUANTITY + 1 > /dev/null 2>&1
if [[ $? -lt 2 ]]; then
    echo "Quantity: $QUANTITY"
else
    echo "$QUANTITY: Not number, exit"
    exit 1
fi

for i in $(seq 0 `expr $QUANTITY - 1`); do
    export FILE_NO=$i
    envsubst < ${TEMPLATE} > ${i}.out
done

