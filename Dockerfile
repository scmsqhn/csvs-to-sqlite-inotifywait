FROM --platform=linux/amd64 python:3.8
SHELL ["sh", "-c"]
WORKDIR /opt/csv2sql3
ADD csvs-to-sqlite /opt/csvs-to-sqlite
RUN set -xe && \
apt update && \
apt install inotify-tools -y && \
pip install -U pip --timeout=120 -i https://pypi.tuna.tsinghua.edu.cn/simple && \
pip install csvs-to-sqlite --timeout=120 -i https://pypi.tuna.tsinghua.edu.cn/simple && \
pip uninstall -y pandas && \
cd /opt/csvs-to-sqlite && python setup.py install