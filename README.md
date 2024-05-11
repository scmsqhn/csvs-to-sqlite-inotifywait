# csvs-to-sqlite-inotifywait
a tools for csv to sqlite3 db async purpose

## csvs-to-sqlite 应用

监测路径下csv文件的变化，同时将csv文件写入sqlite3，只监控写入后缀名为csv或者CSV的文件

## build docker 镜像

./run_build.sh

## 运行 docker 容器

./run_dkr_run.sh

## 数据格式

第一行为title，使用','分隔

```
Hour,Minute,Second,Usecond,Horiacc,Vertacc
8,33,1,3.7816e+05,0.092,0.044
8,33,1,3.782e+05,-0.025,0.432
```

## 数据路径

`csv_input 原始csv文件`
`sqlite3_db_output db文件`
提供一个测试文件

## 概述

```
+---------+          +---------------+
| CSV DIR |--sense-->| inotify-tools |
+---------+          +---+-----------+
                         |
                         V
                     +----------------+           +------------+
                     | csvs-to-sqlite |--update-->| sqlite3 db |
                     +----------------+           +------------+
```

sqlite3 可以多 Client 读，但只能一 Client 写

