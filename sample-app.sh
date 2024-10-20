#!/bin/bash

#Find available port
find_port() {
	port=5050
	while docker ps --format '{{.Ports}}' | grep -q "$port"; do
		((port++))
	done
	echo $port

}

#Retrieve usable port
PORT=$(find_port)

#Set container name
CONTAINER_NAME="sample_$(date +%s)_$PORT"

set -euo pipefail

mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

cat > tempdir/Dockerfile << _EOF_
FROM python
RUN pip install flask
COPY  ./static /home/myapp/static/
COPY  ./templates /home/myapp/templates/
COPY  sample_app.py /home/myapp/
EXPOSE 5050
CMD python /home/myapp/sample_app.py
_EOF_

cd tempdir || exit
docker build -t sampleapp .
docker run -t -d -p ${PORT}:5050 --name ${CONTAINER_NAME} sampleapp
docker ps -a 
