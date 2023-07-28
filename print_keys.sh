#!/usr/bin/env bash
set -e


generate_address_copy() {
	subkey inspect ${3:-} ${4:-} "//$2"
}

generate_data() {
	ADDRESS=$(generate_address_copy $1 $2 $3)
	printf "$ADDRESS"
}

AUTHORITIES=""
NAME=$1

for i in $(seq 1 $V_NUM); do
	AUTHORITIES+="(\n"
	AUTHORITIES+="$(generate_data $i $NAME '--scheme sr25519' true)\n" # stash
	AUTHORITIES+="$(generate_data $i $NAME  '--scheme sr25519' true)\n" # controller 
	AUTHORITIES+="$(generate_data $i $NAME  '--scheme sr25519' true)\n" # babe
	AUTHORITIES+="$(generate_data $i $NAME  '--scheme ed25519' true)\n" # grandpa
	AUTHORITIES+="$(generate_data $i $NAME  '--scheme sr25519' true)\n" # im_online
	AUTHORITIES+="$(generate_data $i $NAME  '--scheme sr25519' true)\n" # para_validator
	AUTHORITIES+="$(generate_data $i $NAME  '--scheme sr25519' true)\n" # para_assignment
	AUTHORITIES+="$(generate_data $i $NAME  '--scheme sr25519' true)\n" # authority_discovery
	AUTHORITIES+="$(generate_data $i $NAME  '--scheme ecdsa' true)\n" # beefy
	AUTHORITIES+="),\n"
done

printf "$AUTHORITIES"