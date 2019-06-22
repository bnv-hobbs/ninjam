FROM ubuntu:18.04 as dev

RUN apt update && apt-get -y install build-essential

COPY jmde /app/jmde
COPY WDL /app/WDL
COPY ninjam /app/ninjam
WORKDIR /app/ninjam/server
RUN make

FROM ubuntu:18.04 as prod

ENTRYPOINT ["/app/bin/ninjamsrv"]
CMD ["/app/etc/ninjam.cfg"]
WORKDIR /app/bin
COPY etc /app/etc
COPY --from=dev /app/ninjam/server/ninjamsrv /app/bin/ninjamsrv



