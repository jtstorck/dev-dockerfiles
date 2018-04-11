#!/bin/bash

systemctl enable squid
systemctl start squid && tail -f /var/log/squid/*
