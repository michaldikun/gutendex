#!/bin/sh


python3 manage.py migrate
python3 manage.py updatecatalog
python3 manage.py collectstatic
python3 manage.py runserver 0.0.0.0:8000