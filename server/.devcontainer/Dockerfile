FROM elixir:1.10.4-slim

# ** [Optional] Uncomment this section to install additional packages. **
#
RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends inotify-tools bash \
    && apt-get -y install git

RUN mix local.hex --force
RUN mix archive.install hex phx_new 1.5.4 --force

