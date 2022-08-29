#!/bin/bash

#Se eliminan las reglas del firewall
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP

#Servicio SSH puerto 22
iptables -A INPUT -i enp0s8 -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o enp0s8 -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT

#Servicio HTTP puerto 80
iptables -A INPUT -i enp0s8 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o enp0s8 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT

#Servicio HTTPS puerto 443
iptables -A INPUT -i enp0s8 -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o enp0s8 -p tcp --dport 433 -m state --state NEW,ESTABLISHED -j ACCEPT

#Servicio MYSQL puerto 3306
iptables -A INPUT -i enp0s8 -p tcp --dport 3306 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o enp0s8 -p tcp --dport 3306 -m state --state NEW,ESTABLISHED -j ACCEPT

#Impedir DDos
iptables -A INPUT -p tcp --dport 80 -m limit --limit 25/minute --limit-burst 100 -j ACCEPT

#Permitir paquetes ICMP
iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT

#Bloquear trafico de un rango IP
iptables -A INPUT -p tcp -m iprange --src-range 192.168.1.2-192.168.1.20

#Bloquear una url
iptables -A OUTPUT -p tcp -d www.youtube.com -j DROP

#Bloquear peticiones ping
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
