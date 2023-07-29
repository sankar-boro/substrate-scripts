const { spawn, exec } = require('node:child_process');

// sr25519, ed25519, ecdsa
const data = [
    {scheme: 'sr25519', keyType: 'babe', short: 'babe' },
    {scheme: 'ed25519', keyType: 'grandpa', short: 'gran' },
    {scheme: 'sr25519', keyType: 'im_online', short: 'imon' },
    {scheme: 'sr25519', keyType: 'para_validator', short: 'para' },
    {scheme: 'sr25519', keyType: 'para_assignment', short: 'asgn' },
    {scheme: 'sr25519', keyType: 'authority_discovery', short: 'audi' },
    {scheme: 'ecdsa', keyType: 'beefy', short: 'beef' },
];

async function generateSpecificAddress(schemeType, suri) {
    return new Promise((resolve, reject) => {
        const sr25519res = spawn('subkey', ['inspect', '--scheme', schemeType, suri]);
        sr25519res.stdout.on('data', (data) => {
            resolve(data)
        });
        sr25519res.stderr.on('data', (data) => {
            reject(data)
        });
        // sr25519res.on('close', (code) => {
        // }); 
    })
}

async function generateAddress() {
    let n = '//Alice'
    let p1 = generateSpecificAddress('sr25519', n);
    let p2 = generateSpecificAddress('ed25519', n);
    let p3 = generateSpecificAddress('ecdsa', n);
    
    return Promise.all([p1, p2, p3]);
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
})

// const ls = spawn('ls', ['-lh', '/usr']);

// ls.stdout.on('data', (data) => {
//   console.log(`stdout: ${data}`);
// });

// ls.stderr.on('data', (data) => {
//   console.error(`stderr: ${data}`);
// });

// ls.on('close', (code) => {
//   console.log(`child process exited with code ${code}`);
// }); 