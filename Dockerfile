FROM gvenzl/oracle-xe:21-slim
ENV ORACLE_PASSWORD=oracle
COPY --chown=oracle:oinstall root /
RUN chmod 777 -R /opt/oracle/oradata
