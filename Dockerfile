# Using lightweight alpine image
FROM python:2.7.14-alpine3.6

MAINTAINER argvc

RUN apk update \
        && apk add --no-cache git openssh-client curl \
        && pip install pipenv \
        && addgroup -S -g 1001 app \
        && adduser -S -D -h /app -u 1001 -G app app


RUN curl -L -\# \
    https://github.com/progrium/entrykit/releases/download/v0.4.0/entrykit_0.4.0_Linux_x86_64.tgz \
    | tar zx && \
    mv ./entrykit /usr/local/bin/. && \
    chmod +x /usr/local/bin/entrykit && \
    entrykit --symlink


# Creating working directory
RUN mkdir /app/src
WORKDIR /app/src
RUN chown -R app.app /app/

# Creating environment
USER app

CMD ["/bin/sh"]
