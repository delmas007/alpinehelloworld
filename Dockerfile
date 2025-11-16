# Grab the latest alpine image
FROM alpine:latest

# Install python, pip and required build dependencies
RUN apk add --no-cache --update \
        python3 \
        py3-pip \
        py3-virtualenv \
        bash \
        build-base \
        linux-headers

# Copy requirements
ADD ./webapp/requirements.txt /tmp/requirements.txt

# Install dependencies
RUN pip3 install --no-cache-dir --break-system-packages -r /tmp/requirements.txt

# Add code
ADD ./webapp /opt/webapp/
WORKDIR /opt/webapp

# Add non-root user
RUN adduser -D myuser
USER myuser

# Run the app
CMD gunicorn --bind 0.0.0.0:$PORT wsgi
