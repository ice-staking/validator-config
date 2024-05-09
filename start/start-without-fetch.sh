#!/bin/bash

# Check if the cluster type is provided as a command line argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <cluster-type>"
    echo "cluster-type: mainnet-beta or testnet"
    exit 1
fi

cluster="$1"

# Define variables based on cluster type
if [ "$cluster" = "mainnet-beta" ]; then
    jito_block_engine_url="https://frankfurt.mainnet.block-engine.jito.wtf"
    jito_relayer_url="http://frankfurt.mainnet.relayer.jito.wtf:8100"
    jito_shred_receiver_address="145.40.93.84:1002"
    ntp="ntp.frankfurt.jito.wtf"
    ledger_dir="/mnt/ledger"
    accounts_dir="/mnt/accounts"
    log_file="/home/sol/solana-validator.log"
    entrypoints=(
        "entrypoint.mainnet-beta.solana.com:8001"
        "entrypoint2.mainnet-beta.solana.com:8001"
        "entrypoint3.mainnet-beta.solana.com:8001"
        "entrypoint4.mainnet-beta.solana.com:8001"
        "entrypoint5.mainnet-beta.solana.com:8001"
    )
    tip_payment_pubkey="T1pyyaTNZsKv2WcRAB8oVnk93mLJw2XzjtVYqCsaHqt"
    tip_distribution_pubkey="4R3gSG8BpU4t19KYj8CfnbtRpnT8gtk4dvTHxVRwc2r7"
    merkle_root_authority="GZctHpWXmsZC1YHACTGGcHhYxjdRqQvTpYkb9LMvxDib"
    genesis_hash="5eykt4UsFv8P8NJdTREpY1vzqKqZKvdpKuc147dw2N9d"
    commission_bps=0
    known_validator_1='7Np41oeYqPefeNQEHSv1UDhYrehxin3NStELsSKCT4K2'
    known_validator_2='GdnSyH3YtwcxFvQrVVJMm1JhTS4QVX7MFsX56uJLUfiZ'
    known_validator_3='DE1bawNcRJB9rVm3buyMVfr8mBEoyyu73NBovf2oXJsJ'
    known_validator_4='CakcnaRDHka2gXyfbEd2d3xsvkJkqsLw2akB3zsN1D2S'
    identity_keypair="/home/sol/icex1C6pnZxznQWiHZZANjGU8nZ8kNquFnjyY7XXrXE.json"
    vote_pubkey="/home/sol/votem3UdGx5xWFbY9EFbyZ1X2pBuswfR5yd2oB3JAaj.json"

elif [ "$cluster" = "testnet" ]; then
    jito_block_engine_url="https://ny.testnet.block-engine.jito.wtf"
    jito_relayer_url="http://nyc.testnet.relayer.jito.wtf:8100"
    jito_shred_receiver_address="141.98.216.97:1002"
    ntp="ntp.dallas.jito.wtf"
    ledger_dir="/mnt/ledger"
    accounts_dir="/accounts"
    log_file="/home/sol/solana-validator.log"
    entrypoints=(
        "entrypoint.testnet.solana.com:8001"
        "entrypoint2.testnet.solana.com:8001"
        "entrypoint3.testnet.solana.com:8001"
        "entrypoint4.testnet.solana.com:8001"
        "entrypoint5.testnet.solana.com:8001"
    )
    tip_payment_pubkey="DCN82qDxJAQuSqHhv2BJuAgi41SPeKZB5ioBCTMNDrCC"
    tip_distribution_pubkey="F2Zu7QZiTYUhPd7u9ukRVwxh7B71oA3NMJcHuCHc29P2"
    merkle_root_authority="GZctHpWXmsZC1YHACTGGcHhYxjdRqQvTpYkb9LMvxDib"
    genesis_hash="4uhcVJyU9pJkvQyS88uRDiswHXSCkY3zQawwpjk2NsNY"
    commission_bps=0
    known_validator_1='5D1fNXzvv5NjV1ysLjirC4WY92RNsVH18vjmcszZd8on'
    known_validator_2='7XSY3MrYnK8vq693Rju17bbPkCN3Z7KvvfvJx4kdrsSY'
    known_validator_3='Ft5fbkqNa76vnsjYNwjDZUXoTWpP7VYm3mtsaQckQADN'
    known_validator_4='9QxCLckBiJc783jnMvXZubK4wH86Eqqvashtrwvcsgkv'
    identity_keypair="/home/sol/icex1C6pnZxznQWiHZZANjGU8nZ8kNquFnjyY7XXrXE.json"
    vote_pubkey="/home/sol/votem3UdGx5xWFbY9EFbyZ1X2pBuswfR5yd2oB3JAaj.json"
else
    echo "Invalid cluster type: $cluster"
    echo "Please choose either 'mainnet-beta' or 'testnet'"
    exit 1
fi

# Execute the Solana validator command
/home/sol/.local/share/solana/install/releases/$TAG/bin/solana-validator \
    --identity "$identity_keypair" \
    --vote-account "$vote_pubkey" \
    --only-known-rpc \
    --log "$log_file" \
    --ledger "$ledger_dir" \
    --accounts "$accounts_dir" \
    --snapshots "$accounts_dir" \
    --rpc-port 8899 \
    "${entrypoints[@]/#/--entrypoint }" \
    --expected-genesis-hash "$genesis_hash" \
    --limit-ledger-size \
    --private-rpc \
     --no-snapshot-fetch \
    --tip-payment-program-pubkey "$tip_payment_pubkey" \
    --tip-distribution-program-pubkey "$tip_distribution_pubkey" \
    --merkle-root-upload-authority "$merkle_root_authority" \
    --commission-bps $commission_bps \
    --relayer-url "$jito_relayer_url" \
    --block-engine-url "$jito_block_engine_url" \
    --expected-bank-hash 69p75jzzT1P2vJwVn3wbTVutxHDcWKAgcbjqXvwCVUDE \
    --shred-receiver-address "$jito_shred_receiver_address"\
     --known-validator "$known_validator_1"\
     --known-validator "$known_validator_2"\
     --known-validator "$known_validator_3"\
     --known-validator "$known_validator_4"\
     --maximum-incremental-snapshots-to-retain 3 \
     --incremental-snapshot-interval-slots 200
