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
--chain ~/files/rococo/relay_chain_spec.json \
--port 30001 \
--rpc-port 9001 \
--node-key 0000000000000000000000000000000000000000000000000000000000000001 \
&> ~/.data/relay_chain_1.log &

polkadot \
--bob \
--validator \
--base-path ~/.data/relay_chain_2__data \
--chain ~/files/rococo/relay_chain_spec.json \
--port 30002 \
--rpc-port 9002 \
--node-key 0000000000000000000000000000000000000000000000000000000000000002 \
--bootnodes /ip4/127.0.0.1/tcp/30001/p2p/12D3KooWEyoppNCUx8Yx66oV9fJnriXwCcXwDDUA2kj6vnc6iDEp \
&> ~/.data/relay_chain_2.log &

# polkadot \
# --charlie \
# --validator \
# --base-path ~/.data/relay_chain_3__data \
# --chain ~/files/rococo/relay_chain_spec.json \
# --port 30003 \
# --rpc-port 9003 \
# --node-key 0000000000000000000000000000000000000000000000000000000000000003 \
# --bootnodes /ip4/127.0.0.1/tcp/30001/p2p/12D3KooWEyoppNCUx8Yx66oV9fJnriXwCcXwDDUA2kj6vnc6iDEp \
# &> ~/.data/relay_chain_3.log &


polkadot \
--chain ~/files/rococo/relay_chain_spec.json \
--name alice \
--rpc-cors all \
-lparachain=debug \
--no-mdns \
--node-key 0000000000000000000000000000000000000000000000000000000000000001 \
--validator \
--rpc-port 9001 \
--listen-addr /ip4/127.0.0.1/tcp/30001/ws \
--base-path ~/.data/relay_chain_1__data \
&> ~/.data/relay_chain_1.log &

polkadot \
--chain ~/files/rococo/relay_chain_spec.json \
--name bob \
-lparachain=debug \
--no-mdns \
--node-key 0000000000000000000000000000000000000000000000000000000000000002 \
--validator \
--bootnodes /ip4/127.0.0.1/tcp/30001/ws/p2p/12D3KooWEyoppNCUx8Yx66oV9fJnriXwCcXwDDUA2kj6vnc6iDEp \
--rpc-port 9002 \
--listen-addr /ip4/127.0.0.1/tcp/30002/ws \
--base-path ~/.data/relay_chain_2__data \
&> ~/.data/relay_chain_2.log &

# genesis-node --name genesis-node \
# --node-key b75137c9ee61356d09d774fcdbaeefffc2b9732f9d3c13963ddee762751b95dd \
# --chain rococo-local-2000.json \
# --base-path genesis-node/data \
# --listen-addr /ip4/0.0.0.0/tcp/36561/ws \
# --prometheus-external \
# --rpc-cors all \
# --unsafe-rpc-external \
# --rpc-methods unsafe \
# --prometheus-port 36645 \
# --rpc-port 34853 \
# --collator \
# -- \
# --chain rococo-local.json \
# --execution wasm \
# --port 38475 \
# --rpc-port 39885
