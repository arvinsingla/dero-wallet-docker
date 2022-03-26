# Dero Wallet CLI docker container

Unofficial simple docker container for the dero wallet cli

When I say simple, I mean simple. All this docker container does is pull the most recently released binary and pass along whatever dero-wallet-cli commands you want and executes them against the binary.

## Disclaimer

I built this for myself to easily host on my home infrastructure. No associations with the Dero team exist or are implied. No warranties, guarentees, or any kind of support are promised if you use this.

Don't just blindly trust any container you find. Read the source to make sure there's nothing malicious.

https://github.com/arvinsingla/dero-wallet-docker

## Docker Hub

This repo is used to build the images available at:

https://hub.docker.com/r/arvinsingla/dero-wallet

## Recommended Usage

The docker image itself simply runs the wallet binary without passing ay parameters. This means you are responsible for passing all parameters required to run.

I have not tested creating a wallet using this container, only opening an existing wallet. It should work fine but make sure you mount a local volume so you have access to the generated files.

### Command line

This executes the container directly from the command line. Any dero-wallet-cli options you want to pass can be chained at the end of the docker run command.

```
docker run -it --name="dero-wallet" -p 20209:20209 -v /mnt/dero/wallet:/mnt/dero arvinsingla/dero-wallet:latest --wallet-file=/mnt/dero/wallet.db --password=YOUR_WALLET_PASSWORD --daemon-address=derod:10102 --rpc-server --rpc-bind=0.0.0.0:20209
```

Here's a breakdown of the above command. If none of this makes sense to you then you probably need to learn more about docker, the dero-wallet-cli, or both.

* `docker run -it --name="dero-wallet"`: Primary docker command to run a container in terminal interactive mode and give it a name
* `-p 20209:20209`: Expose the port 20209 to the network interface
* `-v /mnt/dero/wallet:/mnt/dero`: Mounts the local folder `/mnt/dero/wallet` to the container folder `/mnt/dero`
* `arvinsingla/dero-wallet:latest`: Pointing to this docker image 
* `--wallet-file=/mnt/dero/wallet.db`: dero-wallet-cli command to tell the wallet where to find the wallet db file. This is the path we mounted in the earlier command
* `--password=YOUR_WALLET_PASSWORD`: dero-wallet-cli command to specify the wallet password
* `--daemon-address=derod:10102`: dero-wallet-cli command to point the wallet to a specific derod daemon
* `--rpc-server --rpc-bind=0.0.0.0:20209`: dero-wallet-cli command to start the rpc server and bind to 
the network interface on port 20209

To see a list of available dero-wallet-cli options you can run the following.

```
docker run --name="dero-wallet" arvinsingla/dero-wallet:latest --help
```

### Docker compose

This container works great with docker compose. The example above is replicated as the following `docker-compose.yml`    

```
version: '3'
services:
  dero-wallet:
    image: arvinsingla/dero-wallet:latest
    restart: unless-stopped
    container_name: dero-wallet
    tty: true
    stdin_open: true
    volumes:
      - /mnt/dero/wallet:/mnt/dero
    ports:
      - 20209:20209
    command: >-
      --wallet-file=/mnt/dero/dero-wallet.db
      --password=YOUR_WALLET_PASSWORD
      --daemon-address=derod:10102
      --rpc-server
      --rpc-bind=0.0.0.0:20209
```

## Donation

Found it useful? feel free to donate

`dero1qynxvpudx7rhs5z2h6cnll94e446k9hpcaxc8jw322h9ycsd7c0fjqg9lyzel`
