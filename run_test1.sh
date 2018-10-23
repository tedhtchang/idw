#!/bin/bash
HOME='/root/idw'
SCRIPT=$HOME/idw1.jmx
RESULT="$HOME/result/"
DURATION=60
SERVER=''

if [ ! -d $RESULT ];then
  mkdir -p $RESULT
fi
#for th in 1 5 10 20 40 80
for th in 200
do
  echo "Running $th threads using script $SCRIPT for $DURATION sec"
  $HOME/apache-jmeter-5.0/bin/jmeter -n -t $SCRIPT -l ${RESULT}/idw1_${DURATION}_sec_${th}_threads_result.jtl -JSERVER=$SERVER -JDURATION=$DURATION -JTHREADS=$th
  $HOME/apache-jmeter-5.0/bin/JMeterPluginsCMD.sh --input-jtl ${RESULT}/idw1_${DURATION}_sec_${th}_threads_result.jtl --generate-csv ${RESULT}/idw1_${DURATION}_sec_${th}_threads_result_aggregate.csv --plugin-type AggregateReport
  $HOME/apache-jmeter-5.0/bin/JMeterPluginsCMD.sh --input-jtl ${RESULT}/idw1_${DURATION}_sec_${th}_threads_result.jtl --generate-csv ${RESULT}/idw1_${DURATION}_sec_${th}_threadresult_Synthesis.csv --plugin-type SynthesisReport
done
