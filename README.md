# OSSIM-ALPINE

This repo contains the tools to create an ossim builder docker image, and to use that image to build ossim.

For building the builder image, you need to be able to run docker build with the --squash argument. This may
itself require experimental features to be enable in your docker daemon configuration.

## Special Branches

Per the two `Jenkinsfile`s, certain branches are treated as special, and commits to these branches have implications 
listed below:

### Master

Each commit to master will result in a newly published docker image of the version specified in `version.txt`.
Docker images cannot be overridden in our docker registry (that is, nexus), so each commit must be accompanied by a 
bumped version, or else a new docker image will not be pushed.