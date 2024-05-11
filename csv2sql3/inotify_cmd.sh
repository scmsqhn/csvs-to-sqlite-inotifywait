#!/bin/sh
# 定义ENVS要监控的目录
# 这些配置路径不可以改变
CSV2SQL_BASE_DIR="/opt/data/csv_sql"
CSV2SQL_CSV_DIR="$CSV2SQL_BASE_DIR/csv_input"
CSV2SQL_DB_DIR="$CSV2SQL_BASE_DIR/sqlite3_db_output"
CSV2SQL_LOG_PATH="$CSV2SQL_BASE_DIR/inotifywait.log"
CSV2SQL_SQLITE3_DB_NAME="$CSV2SQL_DB_DIR/ieee-phm-2012-challenge-dataset.db"

# -------------------------------------------------------------
# 使用inotifywait命令监控目录，并在事件发生时执行相应的操作
# -------------------------------------------------------------
# By QinHN at 2024-05-11
# 	if use the -o ,the event can not be handled by us direct likely
# 	inotifywait -d '守护进程' likely can not triger the code of csvs-to-sqlite
# -------------------------------------------------------------

# ...... CAUTION!..................................
# THIS IS NOT WORK， BELOW
#inotifywait -drq \
#			-o $CSV2SQL_LOG_PATH \
#			--timefmt '%Y-%m-%d %H:%M:%S' \
#			--format '%T %w%f event: %;e' \
#			-e create,delete,move,modify \
#			--exclude ".*\.swp$" \
#			$CSV2SQL_CSV_DIR |
# ...... CAUTION!...................................


inotifywait -mrq \
			--timefmt '%Y-%m-%d %H:%M:%S' \
			--format '%T %w%f event: %;e' \
			-e create,delete,move,modify \
			--exclude ".*\.swp$" \
			$CSV2SQL_CSV_DIR |
	while read DATE TIME DIR EVENT
	do
		# code here
		WEATHER_CSV=${DIR##*\.}
		if [ $WEATHER_CSV = "csv" -o  $WEATHER_CSV = "CSV" ]; then
		echo ">>> do sth to handle the $EVENT, ${TIME} on ${DATE}, file $DIR"
		echo csvs-to-sqlite -t $DIR -s \',\' --skip-errors --replace-tables $DIR $CSV2SQL_SQLITE3_DB_NAME
		echo csvs-to-sqlite -t $DIR -s \',\' --skip-errors --replace-tables $DIR $CSV2SQL_SQLITE3_DB_NAME | sh
		fi
	done