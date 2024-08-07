FROM trinodb/trino:453

USER root
#COPY ./trino-config.properties /etc/trino/config.properties

RUN mkdir -p /etc/catalog && chmod -R 755 /etc/catalog
COPY ./example.properties /etc/trino/catalog/example.properties

USER trino

WORKDIR /etc/trino