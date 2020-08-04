#!/bin/bash

CMDNAME=`basename $0`

# Default value
TEMPLATE="template.conf"
QUANTITY=1

function usage() {
    echo "Usage: $CMDNAME [-f filename]" 1>&2
    exit 1
}

while getopts hf: OPT
do
    case $OPT in
        "f" ) flag_f="true"; value_f="$OPTARG";;
        "h" ) usage;;
        * ) usage
    esac
done

if [[ $flag_f == "true" ]]; then
    TEMPLATE=$value_f
fi

if [[ -e $TEMPLATE ]]; then
    echo "Using template: $TEMPLATE"
else
    echo "$TEMPLATE: No such file" 1>&2
    exit 1
fi

for i in $(seq 0 `expr $QUANTITY - 1`); do
    envsubst < ${TEMPLATE} > ${i}.out
done

