FROM elixir:1.10-alpine

# ** [Optional] Uncomment this section to install additional packages. **
#
RUN apk add --no-cache build-base git python

RUN mix local.hex --force && \
    mix local.rebar --force
RUN mix archive.install hex phx_new 1.5.4 --force


ENV PORT=4000

ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_DB=lenra_dev
ENV POSTGRES_HOST=host.docker.internal

ENV FAAS_URL=http://host.docker.internal:8080
ENV FAAS_AUTH=Basic YWRtaW46M2kwREc4NTdLWlVaODQ3R0pheW5qMXAwbQ==
