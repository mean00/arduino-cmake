export EEPROM=` grep "\.eeprom" *.map | sed 's/.eeprom *//g' | sed 's/ [ \t]*0x.*$//g' `
export TAIL=` grep 0x0000000008 *.map | sed 's/^.*0x0000000008/0x0000000008/g' | sed 's/ .*//g' | sort  | grep -v ${EEPROM} | tail -1`
export FREE=$(($EEPROM-$TAIL))
echo "Tail : [$TAIL] EEPROM [$EEPROM] FREE ${FREE}"
printf "Free Flash = %d kB\n" $(($FREE/1024))
