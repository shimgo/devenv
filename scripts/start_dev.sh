#!/bin/bash
dev_home="$HOME/devenv"
prj_name='one_progress'
prj_docker=$HOME'/devenv/home/projects/one-progress/docker'
docker-compose -p "$prj_name" -f $prj_docker/docker-compose.yml -f $prj_docker/docker-compose-dev.yml up -d
docker-compose -p "$prj_name" -f $dev_home/docker-compose-devenv.yml up -d

