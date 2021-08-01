FROM telegraf:latest

RUN curl -s https://install.speedtest.net/app/cli/install.deb.sh | bash

RUN DEBIAN_FRONTEND=noninteractive apt install speedtest

CMD ["telegraf"]
