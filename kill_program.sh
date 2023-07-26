#!/usr/bin/env bash
set -e

ps -ef | grep $1 | grep -v grep | awk '{print $2}' | xargs kill


