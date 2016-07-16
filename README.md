# Alpine Dockerbeat

This is docker image for [Dockerbeat][1].
[Dockerbeat][1] is the [Beat][2] used for docker deamon monitoring.

Base image use Alpine Linux.

## Usages

### Build Image
1. Move to dockerbeat directory.
1. Build docker image.
```bash
$ docker build .
```

> If you want to change PyYAML version, run the following command.
> `$ docker build --build-arg PYYAML_VERSION=3.11 .`

### Run dockerbeat
1. Run elasticsearch.
1. To launch the dockerbeat, run the following command.
```bash
$ docker run -d -v /var/run/docker.sock:/var/run/docker.sock \
             --link elastic:elasticsearch \
             alpine-dockerbeat
```

> If you want to use custom configuration, specific volume option.
> `-v custom_config.yml:/etc/dockerbeat/dockerbeat.yml`

[1]: https://github.com/Ingensi/dockerbeat
[2]: https://www.elastic.co/products/beats
