# Solution instructions and commentaries

All the build and usage commands aredeclared in the `Makefile`. I recommend
using the instructions in there, but if you want, you can use the commands
declared there and run them individually.

## General commentaries

There are some decitions on the code that are not recommended for the
deployment, for example the hardcoded ports for each service in the frontend
microservice. As a pure SRE team, I've tried my best to avoid touching the code
BUT with a mode DevSecOps aproach I'd work with the developers team to improve
this. Ideally i'd recommend exposing all this configuratiosn as environment
variables, and handle all of them with an speciffic tool like
[Infisical](https://infisical.com/) or a vault.

## Dependencies

- GNU make
- Docker (=> 27.1.1) with docker compose (=> 2.29.1)
- Terraform (=> v1.9.2)
- Ansible (=> 2.17.2)


## Developer instructions


## Deploy instructions
