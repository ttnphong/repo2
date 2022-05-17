#!/bin/bash

echo -e  '--------------------BEGIN TEST 1-----------------------\n'
read -s -p "Please input your location: " x
echo "All .sh files in $x are: "
find $x -name "*.sh" > output.txt
awk '{print NR,$0}' output.txt
echo -e  '--------------------END TEST 1------------------------\n'

echo -e  '--------------------BEGIN TEST 2-----------------------\n'
read -e -s -p "Please input the file's index that you want to replace: " x
echo -e  '\n------------------'
read -e -s -p "Please input the string you find: " old
echo -e  '\n------------------'
read -e -s -p "Please input the string you replace: " new
echo -e  '\n------------------'

if [[ $new  == *"\\"* ]]; then
	echo $new > new.txt
	new=$(awk '{gsub ("\\","\\\\\\")} 1' new.txt)
fi

if [[ $old  == *"\\"* ]]; then
	echo $old > old.txt
        old=$(awk '{gsub ("\\","\\\\\\")} 1' old.txt)
fi
if [[ $old  == *"."* ]]; then
        echo $old > old.txt
        old=$(awk '{gsub ("\.","\\\.")} 1' old.txt)
fi

echo "Replace character $old by $new in the file index $x having been found"
awk -v a=$old -v b=$new '{gsub (a, b)} 1' $(awk "NR==$x" output.txt) > newfile.txt
cat newfile.txt
echo -e  '--------------------END TEST 2------------------------\n'
 
echo -e  '--------------------BEGIN TEST 3-----------------------\n'
read -s -p "Please input port number: " x
echo "The port number is - $x"
sudo lsof -i :$x >output.txt
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
