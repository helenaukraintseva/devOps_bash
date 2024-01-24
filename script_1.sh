if [ $# -ne 2 ]; then
    echo "ошибка"
    exit 1
else 
    echo "введены 2 арг $1 $2"
fi
original_file="$1"
new_extension="$2"
if [[ "$original_file" == *.* ]]; then

    base_name="${original_file%.*}"
    new_file="${base_name}.${new_extension}"
else 
    new_file="${original_file}.${new_extension}"
fi
#переименуем файл 
mv "$original_file" "$new_file"
echo "файл переименован в $new_file"
