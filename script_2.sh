gcd() {
    if [ $2 -eq 0 ]; then
        echo $1
    else
        gcd $2 $(($1 % $2))
    fi
}

while true; do 
    echo "введите 2 числа"
    read m n 
    if [ -z "$m" ] || [ -z "$n" ]; then
        echo "bye" 
        exit 1
    fi
    result=$(gcd $m $n)
    echo "gcd is $result"
done 