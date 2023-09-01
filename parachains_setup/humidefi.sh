#!/usr/bin/env bash

genesis-node \
--collator \
--force-authoring \
--base-path ~/.data/para_chain_1__data \
--chain ~/files/humidefi/files/para_chain_spec.json \
--port 30004 \
--rpc-port 9004 \
--node-key 0000000000000000000000000000000000000000000000000000000000000004 \
-- \
--execution wasm \
--chain ~/files/rococo/relay_chain_spec.json \
--bootnodes /ip4/127.0.0.1/tcp/30001/p2p/12D3KooWEyoppNCUx8Yx66oV9fJnriXwCcXwDDUA2kj6vnc6iDEp \
--port 30005 \
--rpc-port 9006 \
&> ~/.data/para_chain_1.log &

genesis-node \
--collator \
--force-authoring \
--base-path ~/.data/para_chain_2__data \
--chain ~/files/humidefi/files/para_chain_spec.json \
--port 30006 \
--rpc-port 9008 \
--node-key 0000000000000000000000000000000000000000000000000000000000000005 \
--bootnodes /ip4/127.0.0.1/tcp/30004/p2p/12D3KooWGNb4d5GyJKoDT2WAZgDeG6Mj6dBD57AyfrLSNsR9tvGp \
-- \
--execution wasm \
--chain ~/files/rococo/rococo-raw-local-chainspec.json \
--port 30007 \
--rpc-port 9010 \
&> ~/.data/para_chain_2.log &


# =======================================================================================================================
# Alice and Bob keys

genesis-node \
--alice \
--collator \
--force-authoring \
--base-path ~/.data/para_chain_1__data \
--chain ~/files/humidefi/files/para_chain_spec.json \
--port 30004 \
--rpc-port 9004 \
--node-key 0000000000000000000000000000000000000000000000000000000000000004 \
-- \
--execution wasm \
--chain ~/files/humidefi/rococo-local.json \
--port 30005 \
--rpc-port 9006 \
&> ~/.data/para_chain_1.log &

genesis-node \
--bob \
--collator \
--force-authoring \
--base-path ~/.data/para_chain_2__data \
--chain ~/files/humidefi/files/para_chain_spec.json \
--port 30006 \
--rpc-port 9008 \
--node-key 0000000000000000000000000000000000000000000000000000000000000005 \
--bootnodes /ip4/127.0.0.1/tcp/30001/p2p/12D3KooWEyoppNCUx8Yx66oV9fJnriXwCcXwDDUA2kj6vnc6iDEp \
-- \
--execution wasm \
--chain ~/files/rococo/rococo-raw-local-chainspec.json \
--port 30007 \
--rpc-port 9010 \
&> ~/.data/para_chain_2.log &