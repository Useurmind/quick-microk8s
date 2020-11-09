#!/bin/bash

ansible-playbook -b -u adminuser --key-file ~/.ssh/id_rsa_btwwc -i hosts.yml install-microk8s.yml