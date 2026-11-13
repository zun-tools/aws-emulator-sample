#!/bin/bash
set -euo pipefail
BUCKET=zunda-emu-demo-b0482d4d
TABLE=zunda-emu-demo
aws s3 rm "s3://$BUCKET" --recursive
aws s3api delete-bucket --bucket "$BUCKET"
aws dynamodb delete-table --table-name "$TABLE"
aws dynamodb wait table-not-exists --table-name "$TABLE"
