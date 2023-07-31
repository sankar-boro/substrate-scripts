// USAGE: node patch_relay_chainspec.js ../../tmp/specs/test-rococo.json > ../../tmp/specs/test-rococo-patched.json

const fs = require('fs');

const { Keyring } = require('@polkadot/api');
const { cryptoWaitReady, encodeAddress } = require('@polkadot/util-crypto');

function keystore() {
    const sr = new Keyring({ type: 'sr25519' });
    const ed = new Keyring({ type: 'ed25519' });
    const ec = new Keyring({ type: 'ecdsa', prefix: 43 });
    function getSr(suri) {
        return sr.createFromUri(suri).address;
    }
    function getEd(suri) {
        return ed.createFromUri(suri).address;
    }
    function getEc(suri) {
        // Walk around https://github.com/polkadot-js/common/issues/1099
        const raw = ec.createFromUri(suri, undefined, 'ecdsa').publicKey;
        return encodeAddress(raw, 43);
    }
    return {
        get(n) {
            return [
                getSr(`${n}//stash`),
                getSr(`${n}`),
                {
                    grandpa: getEd(`${n}`),
                    babe: getSr(`${n}`),
                    im_online: getSr(`${n}`),
                    para_validator: getSr(`${n}`),
                    para_assignment: getSr(`${n}`),
                    authority_discovery: getSr(`${n}`),
                    beefy: getEc(`${n}`),
                }
            ]
        }
    }
}

function hackJsonBigInt(json) {
    return json.replace(/"BigInt\((\d+)\)"/g, '$1');
}


async function main() {
    await cryptoWaitReady();
    const keys = keystore();
    console.log(keys.get("daughter peasant twelve bless century neglect title mouse habit plate galaxy ticket"))
}

main().then((rs) => { console.log('done')})