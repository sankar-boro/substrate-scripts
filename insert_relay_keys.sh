#!/usr/bin/env bash
set -e

# 1=loop_id
# 2=stash/controller/babe

# generate_account_id() {
# 	subkey inspect "//$2" | grep "Account ID" | awk '{ print $3 }'
# }

# generate_address() {
# 	subkey inspect "//$2" | grep "SS58 Address" | awk '{ print $3 }'
# }

insert() {
    arg1='{ "jsonrpc":"2.0", "method":"author_insertKey", "params":['
    arg2=""$1""
    arg3=""$2""
    arg4=""$3""
    arg5='],"id":1 }'
    upload_data="${arg1}\"${arg2}\", \"${arg3}\", \"${arg4}\"${arg5}"
    echo $upload_data

    # curl -H 'Content-Type: application/json' \
    # --data "\"$upload_data\"" http://localhost:$4
}

# insert aura //Alice 0xljdflsk 9999
generate_address() {
    res=$(subkey inspect $1)
    dd=($(printf "$res" | grep "Public" | awk '{ print $4 }'))
	printf ${dd[1]}
}

generate_address //Alice

# generate() {
# 	ADDRESS=$(generate_address $1 $2 $3)

# 	printf "$ADDRESS"
# }

# NAME=$1
# PORT=$2

# AUTHORITIES=""

# for i in $(seq 1 $V_NUM); do
# 	AUTHORITIES+="(\n"
# 	AUTHORITIES+="$(generate $i $NAME '--scheme sr25519' true)\n"
# 	AUTHORITIES+="$(generate $i $NAME '--scheme sr25519' true)\n"
# 	AUTHORITIES+="$(generate $i $NAME '--scheme sr25519' true)\n"
# 	AUTHORITIES+="$(generate $i $NAME '--scheme ed25519' true)\n"
# 	AUTHORITIES+="$(generate $i $NAME '--scheme sr25519' true)\n"
# 	AUTHORITIES+="$(generate $i $NAME '--scheme sr25519' true)\n"
# 	AUTHORITIES+="$(generate $i $NAME '--scheme sr25519' true)\n"
# 	AUTHORITIES+="$(generate $i $NAME '--scheme sr25519' true)\n"
# 	AUTHORITIES+="$(generate $i $NAME '--scheme ecdsa' true)\n"
# 	AUTHORITIES+="),\n"
# done

# printf "$AUTHORITIES"

# 
