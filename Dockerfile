FROM telegraf:latest

RUN DEBIAN_FRONTEND=noninteractive curl -s https://install.speedtest.net/app/cli/install.deb.sh | bash

RUN DEBIAN_FRONTEND=noninteractive apt install speedtest

EXPOSE 8125/udp 8092/udp 8094

CMD ["telegraf"]
