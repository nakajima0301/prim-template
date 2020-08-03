#!/bin/bash

TEMPLATE='template.conf'
WORKERS=10

export TAG="test.tag"
export WORKER_NUMBER="0"

for i in $(seq 0 `expr $WORKERS - 1`); do
    export WORKER_NUMBER="$i"
    envsubst < ${TEMPLATE} > ${WORKER_NUMBER}.conf
done

