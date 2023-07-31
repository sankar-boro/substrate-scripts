#!/usr/bin/env bash
set -e

ps -ef | grep polkadot | grep -v grep | awk '{print $2}' | xargs kill
ps -ef | grep polkadot- | grep -v grep | awk '{print $2}' | xargs kill

ps -ef | grep genesis- | grep -v grep | awk '{print $2}' | xargs kill
rm -rf ~/.data/*

sudo lsof -i -P -n | grep LISTEN