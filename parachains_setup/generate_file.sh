#!/bin/bash

# specfile=humidefi-2000-v2-customkeys-roclocal.json
specfile=humidefi-2000-defaultkeys-v2-roclocal.json
# specfile=cumulus-2000-customkeys-roclocal.json
# specfile=cumulus-2000-defaultkeys-roclocal.json
node=genesis-node
# node=polkadot-parachain

$node build-spec --chain ~/files/humidefi/$specfile --disable-default-bootnode \
--raw > ~/files/humidefi/files/para_chain_spec.json \
&& $node export-genesis-state --chain ~/files/humidefi/files/para_chain_spec.json > ~/files/humidefi/files/genesis-state \
&& $node export-genesis-wasm --chain ~/files/humidefi/files/para_chain_spec.json > ~/files/humidefi/files/genesis-wasm
