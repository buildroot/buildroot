filename = $1

echo "Reading $(filename)..."

input=`cat filename|grep -v "^#"|grep "\c"`
set -- $input

while [ $1 ]
 do
  eval $1=$3
  shift 3
 done
