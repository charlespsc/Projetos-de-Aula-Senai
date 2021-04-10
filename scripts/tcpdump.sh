#!/bin/sh
limite=10000000
arquivos=60
contador=0
arquivos=$(($arquivos-1))
nome="`uname -n`_`date +%Y%m%d`"
tcpdump -i any -s 65535 -w /home2/tmp/$nome.cap&
while true
do
  tamanho=`ls -ltr /home2/tmp/$nome.cap|awk '{print $5}'`
  if test $tamanho -gt $limite
  then
#    echo "$tamanho passou $limite"
    killall tcpdump
    mv /home2/tmp/"$nome".cap /home2/tmp/"$nome"_"$contador".cap
    tcpdump -i any -s 65535 -w /home2/tmp/$nome.cap&
    if test $contador -lt $arquivos
    then
      contador="$(($contador+1))"
    else
      contador=0
    fi
#  else
#    echo "Ativo monitorando tamanho = $tamanho"
  fi
  sleep 15
done