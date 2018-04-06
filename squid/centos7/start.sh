#!/bin/bash

systemctl start squid && tail -f /var/log/squid/*
