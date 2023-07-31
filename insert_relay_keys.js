const { spawn, exec } = require('node:child_process');

const seed = "daughter peasant twelve bless century neglect title mouse habit plate galaxy ticket";

// sr25519, ed25519, ecdsa
const allKeys = [
    {scheme: 'sr25519', keyType: 'aura', short: 'aura' },
    {scheme: 'sr25519', keyType: 'babe', short: 'babe' },
    {scheme: 'ed25519', keyType: 'grandpa', short: 'gran' },
    {scheme: 'sr25519', keyType: 'im_online', short: 'imon' },
    {scheme: 'sr25519', keyType: 'para_validator', short: 'para' },
    {scheme: 'sr25519', keyType: 'para_assignment', short: 'asgn' },
    {scheme: 'sr25519', keyType: 'authority_discovery', short: 'audi' },
    {scheme: 'ecdsa', keyType: 'beefy', short: 'beef' },
];

async function generateSpecificAddress(schemeType) {
    return new Promise((resolve, reject) => {
        const sr25519res = spawn('subkey', ['inspect', '--scheme', schemeType, seed]);
        sr25519res.stdout.on('data', (data) => {
            resolve(data)
        });
        sr25519res.stderr.on('data', (data) => {
            console.log(data)
            reject(data)
        });
        // sr25519res.on('close', (code) => {
        // }); 
    })
}

async function generateAddress() {
    let p1 = generateSpecificAddress('sr25519');
    let p2 = generateSpecificAddress('ed25519');
    let p3 = generateSpecificAddress('ecdsa');
    
    return Promise.all([p1, p2, p3]);
}

function sendCurlRequest(name, suri, publicHexKey) {
    console.log(`{ "jsonrpc":"2.0", "method":"author_insertKey", "params":["${name}", "${suri}", "${publicHexKey}"],"id":1 }`)
}

generateAddress()
.then((data) => {
    let mappedValues = data.map((r) => `${r}`);
    let filteredValues = mappedValues.map((d) => {
        let x = d.split("\n").filter((f, i) => i > 1 && i < 7).map((m) => {
            let s = m.split(" ");
            return s[s.length - 1]
        });
        return {secretSeed: x[0], publicKeyHex: x[1], accountId: x[2], publicKeySS58: x[3], ss58Address: x[4] };
    })
    console.log(filteredValues)
    allKeys.forEach((d) => {
        if (d.scheme === 'sr25519') {
            sendCurlRequest(d.short, seed, filteredValues[0].publicKeyHex);
        }
        if (d.scheme === 'ed25519') {
            sendCurlRequest(d.short, seed, filteredValues[1].publicKeyHex);
        }
        if (d.scheme === 'ecdsa') {
            sendCurlRequest(d.short, seed, filteredValues[2].publicKeyHex);
        }
    })
    // console.log(filteredValues)
})

// curl -H 'Content-Type: application/json' --data '{ "jsonrpc":"2.0", "method":"author_insertKey", "params":["aura", "daughter peasant twelve bless century neglect title mouse habit plate galaxy ticket//2//aura", "0xb46f4dc3ade8c29e2e9cf838db61f2da2e0db79df3c5de8698d58c2ccff59137"],"id":1 }' http://localhost:9008