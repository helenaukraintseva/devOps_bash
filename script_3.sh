
# Проверяем, задан ли PREFIX
if [ $# -ne 1 ]; then
    echo "Usage: $0 PREFIX"
    exit 1
fi

PREFIX=$1
DATE=$(date +%Y-%m-%d)
DIR="${DATE}"
RESULT_FILE="${DIR}/${DATE}.result"
TAR_FILE="${PREFIX}.${DATE}.tar.gz"

# Создаем директорию
mkdir -p "${DIR}"

# Генерируем 100 файлов с случайными числами
for i in $(seq 1 100); do
    echo $(( RANDOM % 9000 + 1000 )) > "${DIR}/${i}"
done

# Вычисляем суммы
SUM1=0
SUM2=0
for i in $(seq 1 100); do
    num=$(cat "${DIR}/${i}")
    if [ $i -le 50 ]; then
        SUM1=$((SUM1 + num))
    else
        SUM2=$((SUM2 + num))
    fi
done

# Сравниваем суммы
if [ $SUM1 -gt $SUM2 ]; then
    echo "Сумма первых 50 чисел ($SUM1) больше." > "$RESULT_FILE"
elif [ $SUM2 -gt $SUM1 ]; then
    echo "Сумма вторых 50 чисел ($SUM2) больше." > "$RESULT_FILE"
else
    echo "Суммы равны." > "$RESULT_FILE"
fi

# Находим файлы с максимальным и минимальным числами
MAX_NUM=0
MIN_NUM=9999
for i in $(seq 1 100); do
    num=$(cat "${DIR}/${i}")
    if [ $num -gt $MAX_NUM ]; then
        MAX_NUM=$num
        MAX_FILE=$i
    fi
    if [ $num -lt $MIN_NUM ]; then
        MIN_NUM=$num
        MIN_FILE=$i
    fi
done

echo "Наибольшее число $MAX_NUM в файле $MAX_FILE" >> "$RESULT_FILE"
echo "Наименьшее число $MIN_NUM в файле $MIN_FILE" >> "$RESULT_FILE"

# Упаковываем файлы
tar -czf "$TAR_FILE" "$DIR" "$0"

# Удаляем файлы
rm -r "${DIR}"

echo "Скрипт завершил работу, результаты в файле $RESULT_FILE и архиве $TAR_FILE"