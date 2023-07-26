genesis-node build-spec --chain ~/files/humidefi/humidefi-2000-defaultkeys-roclocal.json --disable-default-bootnode \
--raw > ~/files/humidefi/humidefi-2000-defaultkeys-roclocal-raw.json

genesis-node export-genesis-state --chain ~/files/humidefi/humidefi-2000-defaultkeys-roclocal-raw.json > ~/files/humidefi/genesis-state-2000
genesis-node export-genesis-wasm --chain ~/files/humidefi/humidefi-2000-defaultkeys-roclocal-raw.json > ~/files/humidefi/genesis-wasm-2000

genesis-node \
--alice \
--collator \
--force-authoring \
--base-path ~/.data/para_chain_1__data \
--chain ~/files/humidefi/humidefi-2000-defaultkeys-roclocal-raw.json \
--port 30004 \
--rpc-port 9004 \
--ws-port 9005 \
--node-key 0000000000000000000000000000000000000000000000000000000000000004 \
--bootnodes /ip4/127.0.0.1/tcp/30001/p2p/12D3KooWEyoppNCUx8Yx66oV9fJnriXwCcXwDDUA2kj6vnc6iDEp \
-- \
--execution wasm \
--chain ~/files/rococo/rococo-raw-local-chainspec.json \
--port 30005 \
--rpc-port 9006 \
--ws-port 9007 \
&> ~/.data/para_chain_1.log &






# Custom keys
#
#

genesis-node build-spec --chain ~/files/humidefi/humidefi-2000-customkeys-roclocal.json --disable-default-bootnode \
--raw > ~/files/humidefi/humidefi-2000-customkeys-roclocal-raw.json

genesis-node export-genesis-state --chain ~/files/humidefi/humidefi-2000-customkeys-roclocal-raw.json > ~/files/humidefi/genesis-state-2000-custom_keys
genesis-node export-genesis-wasm --chain ~/files/humidefi/humidefi-2000-customkeys-roclocal-raw.json > ~/files/humidefi/genesis-wasm-2000-custom_keys

genesis-node \
--collator \
--force-authoring \
--base-path ~/.data/para_chain_2__data \
--chain ~/files/humidefi/humidefi-2000-customkeys-roclocal-raw.json \
--port 30006 \
--rpc-port 9008 \
--ws-port 9009 \
--node-key 0000000000000000000000000000000000000000000000000000000000000005 \
--bootnodes /ip4/127.0.0.1/tcp/30001/p2p/12D3KooWEyoppNCUx8Yx66oV9fJnriXwCcXwDDUA2kj6vnc6iDEp \
-- \
--execution wasm \
--chain ~/files/rococo/rococo-raw-local-chainspec.json \
--port 30007 \
--rpc-port 9010 \
--ws-port 9011 \
&> ~/.data/para_chain_2.log &

curl -H 'Content-Type: application/json' --data '{ "jsonrpc":"2.0", "method":"author_insertKey", "params":["aura", "daughter peasant twelve bless century neglect title mouse habit plate galaxy ticket//1//aura", "0x008012573a4e334d065cd67895d1b7b1576e514d3f599c20d3b405c315a3da4f"],"id":1 }' http://localhost:9008