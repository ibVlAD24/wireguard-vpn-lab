#!/bin/bash
wg genkey | tee server_private.key | wg pubkey > server_public.key
wg genkey | tee client_private.key | wg pubkey > client_public.key
echo "Ключи сгенерированы:"
ls -la *.key
