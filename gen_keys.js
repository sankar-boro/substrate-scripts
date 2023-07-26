// USAGE
// NUM_VALIDATORS=3 NUM_TECH_COMMITTEE=0 ENDOWMENT='' MNEMONIC='xxx' OUT=../../node/res/khala_local_genesis_info.json node gen_khala_genesis.js

require('dotenv').config();

const { Keyring } = require('@polkadot/keyring');
const { u8aToHex, stringToHex } = require('@polkadot/util');
const { 
    cryptoWaitReady, 
    decodeAddress,
    mnemonicGenerate,
    mnemonicToMiniSecret,
    mnemonicValidate,
    ed25519PairFromSeed,
    mnemonicToLegacySeed,
} = require('@polkadot/util-crypto');
const { exec } = require("child_process");

const NUM_VALIDATORS = 5;
const NUM_TECH_COMMITTEE = 5;
const ENDOWMENT = process.env.ENDOWMENT ?? '1000' + '000000000000';  // 1000 PHA
const MNEMONIC = "daughter peasant twelve bless century neglect title mouse habit plate galaxy ticket";

exec(`subkey inspect "${MNEMONIC}//1//stash"`, (error, stdout, stderr) => {
    if (error) {
        console.log(`error: ${error.message}`);
        return;
    }
    if (stderr) {
        console.log(`stderr: ${stderr}`);
        return;
    }
    console.log(`stdout: ${stdout}`);
});

async function main() {
    await cryptoWaitReady();
    
    const keyring = new Keyring({ type: 'sr25519', ss58Format: 42 });
    const uri = keyring.addFromUri(`${MNEMONIC}//1//stash`);

    const rootKey = uri.address;
    
    const publicKeyU8 = decodeAddress(rootKey);
    const hexPublicKey = u8aToHex(publicKeyU8);

    // const { publicKey, secretKey } = ed25519PairFromSeed(publicKeyU8);

    console.log('Public key (hex):   ', hexPublicKey);
    console.log('Account ID:         ', hexPublicKey);

    console.log('Public key (SS58):  ', rootKey);
    console.log('SS58 Address:       ', rootKey);

}

// async function main () {
//     // Create mnemonic string for Alice using BIP39
//     const mnemonicAlice = MNEMONIC;
  
//     console.log(`Generated mnemonic: ${mnemonicAlice}`);
  
//     // Validate the mnemonic string that was generated
//     const isValidMnemonic = mnemonicValidate(mnemonicAlice);
  
//     console.log(`isValidMnemonic: ${isValidMnemonic}`);
  
//     // Create valid Substrate-compatible seed from mnemonic
//     const seedAlice = mnemonicToMiniSecret(mnemonicAlice);
  
//     // Generate new public/secret keypair for Alice from the supplied seed
//     const { publicKey, secretKey } = ed25519PairFromSeed(seedAlice);
//     console.log(u8aToHex(publicKey))
//     console.log(u8aToHex(secretKey))
//   }

main().catch(console.error).finally(() => {process.exit()});

// Secret Key URI `daughter peasant twelve bless century neglect title mouse habit plate galaxy ticket//1//stash` is account:
//   Network ID:        substrate 
//  Secret seed:       0xb98b08635cf016786b5bb1a4d01cdf961df94da35f197f5cea173f55a82bf1b2
//   Public key (hex):  0x5abc99f49921329dc4fe14b03315e3633950efd2806cda609eb5aa5c71a8ee79
//   Account ID:        0x5abc99f49921329dc4fe14b03315e3633950efd2806cda609eb5aa5c71a8ee79
//   Public key (SS58): 5E7gC9qZGDnHLNfdv37Ps8bASdMUw123LcnBX1Pmt19ap8Ui
//   SS58 Address:      5E7gC9qZGDnHLNfdv37Ps8bASdMUw123LcnBX1Pmt19ap8Ui


// Secret phrase:       daughter peasant twelve bless century neglect title mouse habit plate galaxy ticket
//   Network ID:        substrate
//   Secret seed:       0x1131d703160e61760c6ae21b46fa25ce46936e9026bd6345a526c80096e05de6
//   Public key (hex):  0x3a96ca8370a60797d11431313878bf0ccc38dab6bf4696690078296b5faebd3e
//   Account ID:        0x3a96ca8370a60797d11431313878bf0ccc38dab6bf4696690078296b5faebd3e
//   Public key (SS58): 5DPXRpfCQMRkkJbpdmJQDTCrFcpm5sP2q4zdurgEnH8fM6do
//   SS58 Address:      5DPXRpfCQMRkkJbpdmJQDTCrFcpm5sP2q4zdurgEnH8fM6do

