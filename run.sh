#!/usr/bin/env bash
set -e

sudo lsof -i -P -n | grep LISTEN