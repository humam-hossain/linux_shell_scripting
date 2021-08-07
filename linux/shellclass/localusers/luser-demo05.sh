#!/bin/bash

# This script generates a list of random passwords.

SPECIAL_CHARACTER=$(echo '!@#$%^&*()_+-=' | fold -w1 | shuf | head -c1)
PASSWORD="$(date +%s%N${RANSOM}${RANDOM} | sha256sum | head -c48)"
echo "${PASSWORD}${SPECIAL_CHARACTER}"

