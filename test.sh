#!/usr/bin/env bash

curl -X POST http://localhost:5002/talk \
   -H 'Content-Type: application/json' \
   -d '{"message":"This is a test of the emergency broadcast system"}'
#   -d '{"message":"Id like to teach the world to sing, in perfect harmony."}'

