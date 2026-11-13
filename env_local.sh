# source env_local.sh で読み込む。この端末の CLI と boto3 だけが手元のエミュレータを向く
# 1・2行目が向け先と鍵。3行目は安全のため（EC2 の上で本物の鍵を拾わない）で、向け先には効かない
export AWS_CONFIG_FILE=$HOME/.aws/emulator/9297/config
export AWS_SHARED_CREDENTIALS_FILE=$HOME/.aws/emulator/9297/emulator_credentials
export AWS_EC2_METADATA_DISABLED=true
