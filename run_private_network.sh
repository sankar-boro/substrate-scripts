#!/usr/bin/env bash
set -e

polkadot \
--alice \
--validator \
--base-path ~/.data/relay_chain_1__data \
--chain ~/files/rococo/rococo-raw-local-chainspec.json \
--port 30001 \
--rpc-port 9001 \
--node-key 0000000000000000000000000000000000000000000000000000000000000001 \
&> ~/.data/relay_chain_1.log &

polkadot \
--bob \
--validator \
--base-path ~/.data/relay_chain_2__data \
--chain ~/files/rococo/rococo-raw-local-chainspec.json \
--port 30002 \
--rpc-port 9002 \
--node-key 0000000000000000000000000000000000000000000000000000000000000002 \
--bootnodes /ip4/127.0.0.1/tcp/30001/p2p/12D3KooWEyoppNCUx8Yx66oV9fJnriXwCcXwDDUA2kj6vnc6iDEp \
&> ~/.data/relay_chain_2.log &

polkadot \
--charlie \
--validator \
--base-path ~/.data/relay_chain_3__data \
--chain ~/files/rococo/rococo-raw-local-chainspec.json \
--port 30003 \
--rpc-port 9003 \
--node-key 0000000000000000000000000000000000000000000000000000000000000003 \
--bootnodes /ip4/127.0.0.1/tcp/30001/p2p/12D3KooWEyoppNCUx8Yx66oV9fJnriXwCcXwDDUA2kj6vnc6iDEp \
&> ~/.data/relay_chain_3.log &