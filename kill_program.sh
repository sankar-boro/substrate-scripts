#!/usr/bin/env bash
set -e

killall polkadot
killall genesis-n

rm -rf ~/.data/*

sudo lsof -i -P -n | grep LISTEN