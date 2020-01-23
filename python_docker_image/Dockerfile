FROM ubuntu:latest

RUN mkdir -p /var/www/testing \
    && apt-get update -y \
    && apt-get install python3 -y \
    && apt-get install python3-pip -y \
    && pip3 install flask \
    && pip3 install psycopg2-binary

ADD hello_world.py /var/www/testing/

RUN chmod 755 /var/www/testing/hello_world.py

CMD ["python3", "/var/www/testing/hello_world.py"]
