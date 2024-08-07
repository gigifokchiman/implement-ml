FROM trinodb/trino:453

USER root
#COPY ./trino-config.properties /etc/trino/config.properties

RUN mkdir -p /etc/catalog && chmod -R 755 /etc/catalog
COPY ./*.properties /etc/trino/catalog/

USER trino

WORKDIR /etc/trino