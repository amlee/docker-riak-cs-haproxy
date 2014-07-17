# docker-riak-cs-haproxy [![Build Status](https://secure.travis-ci.org/hectcastro/docker-riak-cs-haproxy.png?branch=develop)](http://travis-ci.org/hectcastro/docker-riak-cs-haproxy)

This is a [Docker](http://docker.io) project to bring up an HAProxy instance
that automatically populates linked [Riak CS](https://github.com/basho/riak_cs)
containers into an HAProxy backend.

## Prerequisites

### Install Docker

Follow the [instructions on Docker's website](https://www.docker.io/gettingstarted/#h_installation)
to install Docker 0.10.0+.

From there, ensure that your `DOCKER_HOST` environmental variable is set
correctly:

```bash
$ export DOCKER_HOST="tcp://192.168.59.103:2375"
```

**Note:** If you're using [boot2docker](https://github.com/boot2docker/boot2docker)
ensure that you forward the virtual machine ports `8080` and `8888`. This
will allow you to interact with the container as if it were running locally:

```bash
$ for i in {8080,8888}; do
 VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port$i,tcp,,$i,,$i";
 VBoxManage modifyvm "boot2docker-vm" --natpf1 "udp-port$i,udp,,$i,,$i";
done
```

## Build image

### Clone repository and build

```bash
$ git clone https://github.com/hectcastro/docker-riak-cs-haproxy.git
$ cd docker-riak-cs-haproxy
$ make build
```

## SSH

The [phusion/baseimage-docker](https://github.com/phusion/baseimage-docker)
image has the ability to enable an __insecure__ key for conveniently logging
into a container via SSH. It is enabled in the `Dockerfile` by default here:

```docker
RUN /usr/sbin/enable_insecure_key
```

In order to login to the container via SSH using the __insecure__ key, follow
the steps below.

Use `docker inspect` to determine the container IP address:

```bash
$ docker inspect $CONTAINER_ID | egrep IPAddress
        "IPAddress": "172.17.0.2",
```

Download the insecure key, alter its permissions, and use it to SSH into the
container via its IP address:

```bash
$ curl -o insecure_key -fSL https://github.com/phusion/baseimage-docker/raw/master/image/insecure_key
$ chmod 600 insecure_key
$ ssh -i insecure_key root@172.17.0.2
```

**Note:** If you're using
[boot2docker](https://github.com/boot2docker/boot2docker), ensure that you're
issuing the SSH command from within the virtual machine running `boot2docker`.
