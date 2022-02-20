read line

if [[ "$line" == "y" ]]
then
    echo "YES"
elif [[ "$line" == "Y" ]]
then
    echo "YES"
elif [[ "$line" == "n" ]]
then
    echo "NO"
elif [[ "$line" == "N" ]]
then
    echo "NO"
fi