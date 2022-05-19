#!/bin/bash

echo -e  '--------------------BEGIN TEST 1-----------------------\n'
echo "All .sh files in $1 are: "
find $1 -name "*.sh" > output.txt
awk '{print NR,$0}' output.txt
echo -e  '--------------------END TEST 1------------------------\n'

echo -e  '--------------------BEGIN TEST 2-----------------------\n'
echo -e "The file's index that you want to replace: $2"
echo -e  '\n------------------'
echo -e "The string you find: $3"
echo -e  '\n------------------'
echo -e "The string you replace: $4" 
echo -e  '\n------------------'

a=$3
b=$4
echo "The new file after replacing character $a by $b in the file index $2 having been found"

if [[ $4  == *"\\"* ]]; then
	echo $4 > new.txt
	b=$(awk '{gsub ("\\","\\\\\\")} 1' new.txt)
fi

if [[ $3  == *"\\"* ]]; then
	echo $3 > old.txt
        a=$(awk '{gsub ("\\","\\\\\\")} 1' old.txt)
fi
if [[ $3  == *"."* ]]; then
        echo $3 > old.txt
        a=$(awk '{gsub ("\.","\\\.")} 1' old.txt)
fi

awk -v a=$a -v b=$b '{gsub (a, b)} 1' $(awk "NR==$2" output.txt) > newfile.txt
cat newfile.txt
echo -e  '--------------------END TEST 2------------------------\n'
 
echo -e  '--------------------BEGIN TEST 3-----------------------\n'
echo -e "The port number is - $5"
lsof -i :$5 >output.txt
echo "The service running is: $(awk 'NR==2 {print $1}' output.txt)"
echo -e  '--------------------END TEST 3-----------------------\n'

echo -e  '--------------------BEGIN TEST 4-----------------------\n'
top -n 1 > output.txt

echo "%CPU in use is - $(awk 'NR==3 {print (100-$8)}' output.txt)"
echo -e  '\n------------------'
echo "Total Memory is - $(awk 'NR==4 {print $4}' output.txt) MB"
echo "%Memory in use is - $(awk 'NR==4 {print (($4-$6)*100/$4)}' output.txt)"
echo -e  '\n------------------'
df /dev/sda2 > output.txt
echo "Total Memory is - $(awk 'NR==2 {print $2}' output.txt) Bytes"
echo "%Memory in use is - $(awk 'NR==2 {print ($3*100/$2)}' output.txt)"
awk 'NR==3 {print (100-$8)}' output.txt
echo -e  '\n--------------------END TEST 4-----------------------\n'
exit 0
