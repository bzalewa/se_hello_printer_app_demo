FROM python:3

ARG APP_DIR=/home/student/workspace/se_hello_printer_app_demo

WORKDIR /tmp
ADD requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

RUN mkdir -p $APP_DIR
ADD hello_world/ $APP_DIR/hello_world/
ADD main.py $APP_DIR

WORKDIR $APP_DIR
CMD PYTHONPATH=$PYTHONPATH:/home/student/workspace/se_hello_printer_app_demo \
FLASK_APP=hello_world flask run --host=0.0.0.0
