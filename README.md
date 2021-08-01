# telegraf-speedtest
Telegraf with Ookla's Speedtest docker image

[https://hub.docker.com/r/foureight84/telegraf-speedtest](https://hub.docker.com/r/foureight84/telegraf-speedtest)

### Usage
The dashboard to use with this container is the Speedtest Influxdata community template [https://github.com/influxdata/community-templates/tree/master/speedtest](https://github.com/influxdata/community-templates/tree/master/speedtest) with InfluxDB v2.

After importing this template, copy the `nostalgic-lederberg-676001` configuration found in the Data > Telegraf page.

The configuration should look something like this:

```
[[outputs.influxdb_v2]]
## The URLs of the InfluxDB cluster nodes.
##
## Multiple URLs can be specified for a single cluster, only ONE of the
## urls will be written to each interval.
## urls exp: http://127.0.0.1:9999
urls = ["$INFLUX_HOST"]

## Token for authentication.
token = "$INFLUX_TOKEN"

## Organization is the name of the organization you wish to write to; must exist.
organization = "$INFLUX_ORG"

## Destination bucket to write into.
bucket = "speedtest"

[agent]
interval = "30m"

[[inputs.exec]]
## Commands array
commands = ["speedtest --format=json-pretty"]

## Timeout for each command to complete.
timeout = "90s"

## measurement name suffix (for separating different commands)
name_suffix = "_speedtest"

## Data format to consume.
## Each data format has its own unique set of configuration options, read
## more about them here:
## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_INPUT.md
data_format = "json"
```

Update `$INFLUX_HOST`, `$INFLUX_TOKEN`, and `$INFLUX_ORG` for your environment.

The `commands` field needs to be modified from `["speedtest --format=json-pretty"]` to `["speedtest speedtest --accept-license --format=json-pretty"]`. This is because an agreement prompt is required on first-run. It's not really feasible to exec into the Docker container to trigger the agreement.

Save the config as `telegraf_speedtest.conf`

Example docker-compose.yaml:

```
version: "3.7"

services:    
  telegraf:
    image: foureight84/telegraf-speedtest:latest
    volumes:
      - ./telegraf_speedtest.conf:/etc/telegraf/telegraf.conf
```