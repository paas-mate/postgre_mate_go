FROM shoothzj/base:go AS build
COPY . /opt
WORKDIR /opt/pkg
RUN go build -o postgre_mate .

FROM ttbb/postgre:nake

COPY docker-build /usr/lib/postgresql/15/mate

COPY --from=build /opt/pkg/postgre_mate /usr/lib/postgresql/15/mate/postgre_mate

CMD ["/usr/bin/dumb-init", "bash", "-vx", "/usr/lib/postgresql/15/mate/scripts/start.sh"]
