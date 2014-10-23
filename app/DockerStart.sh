#!/bin/sh

./manage.py collectstatic --noinput

echo -n "Waiting for db to accept connections ..."
while ! nc -w 1 db 5432 2>/dev/null
do
  echo -n .
  sleep 1
done
echo "ok"

./manage.py syncdb --noinput
./manage.py migrate --noinput
./manage.py runserver 0.0.0.0:8000
