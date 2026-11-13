#!/bin/bash
set -euo pipefail
BUCKET=zunda-emu-demo-b0482d4d
TABLE=zunda-emu-demo
aws s3api create-bucket --bucket "$BUCKET"
aws dynamodb create-table --table-name "$TABLE" \
  --attribute-definitions AttributeName=id,AttributeType=S \
  --key-schema AttributeName=id,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST
aws dynamodb wait table-exists --table-name "$TABLE"
