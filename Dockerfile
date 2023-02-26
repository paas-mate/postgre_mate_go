FROM shoothzj/base:go AS build
COPY . /opt
WORKDIR /opt/pkg
RUN go build -o postgre_mate .

FROM ttbb/postgre:nake

COPY --chown=postgres:postgres docker-build /usr/lib/postgresql/15/mate

COPY --chown=postgres:postgres --from=build /opt/pkg/postgre_mate /usr/lib/postgresql/15/mate/postgre_mate

USER postgres

ENV POSTGRE_DATA /usr/lib/postgresql/15/data

CMD ["/usr/bin/dumb-init", "bash", "-vx", "/usr/lib/postgresql/15/mate/scripts/start.sh"]
