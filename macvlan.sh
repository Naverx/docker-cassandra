#!/usr/bin/env bash
#Имя интерфейса
NIC_NAME="enp0s8"
#Имя нашей прокси macvlan сети
DOCKER_ROUTING_INTERFACE_NAME="dockerroute"
#Адресс сети и айпи диапазон который будет через эту сеть роутится
DOCKERNETWORK_IP_ADDRESS="192.168.1.205/32"
DOCKERNETWORK_IP_RANGE="192.168.1.200/30"

ip link add ${DOCKER_ROUTING_INTERFACE_NAME} link ${NIC_NAME} type macvlan mode bridge ; ip addr add ${DOCKERNETWORK_IP_ADDRESS} dev ${DOCKER_ROUTING_INTERFACE_NAME} ; ip link set ${DOCKER_ROUTING_INTERFACE_NAME} up
ip route add ${DOCKERNETWORK_IP_RANGE} dev ${DOCKER_ROUTING_INTERFACE_NAME}
