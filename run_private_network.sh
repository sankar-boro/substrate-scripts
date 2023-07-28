#!/usr/bin/env bash
set -e

# lsof -i -P -n | grep LISTEN
# ./kill_program.sh polkadot
# ./kill_program.sh genesis-n
# rm -rf ~/.data/*

polkadot \
--alice \
--validator \
--base-path ~/.data/relay_chain_1__data \
--chain ~/files/humidefi/rococo-local.json \
--port 30001 \
--rpc-port 9001 \
--node-key 0000000000000000000000000000000000000000000000000000000000000001 \
&> ~/.data/relay_chain_1.log &

polkadot \
--bob \
--validator \
--base-path ~/.data/relay_chain_2__data \
--chain ~/files/humidefi/rococo-local.json \
--port 30002 \
--rpc-port 9002 \
--node-key 0000000000000000000000000000000000000000000000000000000000000002 \
--bootnodes /ip4/127.0.0.1/tcp/30001/p2p/12D3KooWEyoppNCUx8Yx66oV9fJnriXwCcXwDDUA2kj6vnc6iDEp \
&> ~/.data/relay_chain_2.log &

# polkadot \
# --charlie \
# --validator \
# --base-path ~/.data/relay_chain_3__data \
# --chain ~/files/rococo/rococo-raw-local-chainspec.json \
# --port 30003 \
# --rpc-port 9003 \
# --node-key 0000000000000000000000000000000000000000000000000000000000000003 \
# --bootnodes /ip4/127.0.0.1/tcp/30001/p2p/12D3KooWEyoppNCUx8Yx66oV9fJnriXwCcXwDDUA2kj6vnc6iDEp \
# &> ~/.data/relay_chain_3.log &


# polkadot --chain ~/files/rococo/rococo-raw-local-chainspec.json \
# --name alice --rpc-cors all --unsafe-rpc-external --rpc-methods unsafe -lparachain=debug --no-mdns \
# --node-key 2bd806c97f0e00af1a1fc3328fa763a9269723c8db8fac4f93af71db186d6e90 \
# --no-telemetry --prometheus-external --validator --prometheus-port 32803 --rpc-port 41411 \
# --listen-addr /ip4/0.0.0.0/tcp/43677/ws \
# --base-path ~/.data/relay_chain_1__data

# 12D3KooWQCkBm1BYtkHpocxCwMgR8yjitEeHGx8spzcDLGt2gkBm