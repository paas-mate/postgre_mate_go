FROM ttbb/postgre:nake

COPY --chown=postgres:postgres docker-build /usr/lib/postgresql/15/mate

USER postgres

ENV POSTGRE_DATA /usr/lib/postgresql/15/data

CMD ["/usr/bin/dumb-init", "bash", "-vx", "/usr/lib/postgresql/15/mate/scripts/start.sh"]
