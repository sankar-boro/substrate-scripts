#!/usr/bin/env bash

genesis-node \
--collator \
--force-authoring \
--base-path ~/.data/para_chain_1__data \
--chain ~/files/humidefi/files/para_chain_spec.json \
--port 20000 \
--rpc-port 8000 \
--node-key 0000000000000000000000000000000000000000000000000000000000000003 \
-- \
--execution wasm \
--chain ~/files/rococo/relay_chain_spec.json \
--bootnodes /ip4/127.0.0.1/tcp/30000/p2p/12D3KooWEyoppNCUx8Yx66oV9fJnriXwCcXwDDUA2kj6vnc6iDEp \
--port 20001 \
--rpc-port 8001 \
&> ~/.data/para_chain_1.log &