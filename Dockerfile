FROM fedora/tools:latest

LABEL maintainer "hekmekk"
EXPOSE 1500
VOLUME /docker-entrypoint.d

COPY server.sh input_reader.sh request_handler.sh /docker-entrypoint/

WORKDIR /docker-entrypoint

ENTRYPOINT ["/docker-entrypoint/server.sh", "-l", "1500", "-m", "OK", "-c", "/docker-entrypoint.d"]

