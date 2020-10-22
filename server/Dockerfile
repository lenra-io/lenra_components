FROM elixir:1.10-alpine AS build

ARG secret_key_base
ENV SECRET_KEY_BASE=$secret_key_base

# install build dependencies
RUN apk add --no-cache build-base git python

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile

# build assets
COPY priv priv
RUN mix phx.digest

# compile and build release
COPY lib lib
# uncomment COPY if rel/ exists
# COPY rel rel
RUN mix do compile, release

# prepare release image
# FROM elixir:1.10-alpine AS app
RUN apk add --no-cache openssl ncurses-libs

# WORKDIR /app

# RUN chown nobody:nobody /app

# USER nobody:nobody

# COPY --from=build /app/_build ./_build

ENV HOME=/app

CMD ["_build//prod/rel/lenra/bin/lenra", "start"]