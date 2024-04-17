#!/bin/bash

# Define variables
identity_keypair="icex1C6pnZxznQWiHZZANjGU8nZ8kNquFnjyY7XXrXE.json"
vote_pubkey="votem3UdGx5xWFbY9EFbyZ1X2pBuswfR5yd2oB3JAaj.json"
genesis_hash="5eykt4UsFv8P8NJdTREpY1vzqKqZKvdpKuc147dw2N9d"
jito_block_engine_url="https://frankfurt.mainnet.block-engine.jito.wtf"
jito_relayer_url="http://frankfurt.mainnet.relayer.jito.wtf:8100"
jito_shred_receiver_address="145.40.93.84:1002"
ntp="ntp.frankfurt.jito.wtf"
commission_bps=100

# Execute the Solana validator command
solana-validator \
    --identity "$identity_keypair" \
    --vote-account "$vote_pubkey" \
    --only-known-rpc \
    --log /home/sol/solana-validator.log \
    --ledger /mnt/ledger \
    --accounts /accounts \
    --rpc-port 8899 \
    --dynamic-port-range 8000-8020 \
    --entrypoint entrypoint.mainnet-beta.solana.com:8001 \
    --entrypoint entrypoint2.mainnet-beta.solana.com:8001 \
    --entrypoint entrypoint3.mainnet-beta.solana.com:8001 \
    --entrypoint entrypoint4.mainnet-beta.solana.com:8001 \
    --entrypoint entrypoint5.mainnet-beta.solana.com:8001 \
    --expected-genesis-hash "$genesis_hash" \
    --limit-ledger-size \
    --private-rpc \
    --no-snapshot-fetch \
    --tip-payment-program-pubkey T1pyyaTNZsKv2WcRAB8oVnk93mLJw2XzjtVYqCsaHqt \
    --tip-distribution-program-pubkey 4R3gSG8BpU4t19KYj8CfnbtRpnT8gtk4dvTHxVRwc2r7 \
    --merkle-root-upload-authority GZctHpWXmsZC1YHACTGGcHhYxjdRqQvTpYkb9LMvxDib \
    --commission-bps $commission_bps \
    --relayer-url "$jito_relayer_url" \
    --block-engine-url "$jito_block_engine_url" \
    --expected-bank-hash 69p75jzzT1P2vJwVn3wbTVutxHDcWKAgcbjqXvwCVUDE \
    --shred-receiver-address "$jito_shred_receiver_address"
