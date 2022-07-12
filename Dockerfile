FROM gvenzl/oracle-xe:21
ENV ORACLE_PASSWORD=oracle
COPY --chown=oracle:dba root /
