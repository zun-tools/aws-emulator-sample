import datetime
import boto3

BUCKET = "zunda-emu-demo-b0482d4d"
TABLE = "zunda-emu-demo"

s3 = boto3.client("s3")
dynamodb = boto3.client("dynamodb")

with open("report.csv", "rb") as f:
    s3.put_object(Bucket=BUCKET, Key="report.csv", Body=f.read())
print(f"uploaded: report.csv → s3://{BUCKET}")

dynamodb.put_item(
    TableName=TABLE,
    Item={
        "id": {"S": "1"},
        "file": {"S": "report.csv"},
        "uploaded_at": {"S": datetime.datetime.now(datetime.timezone.utc).isoformat()},
    },
)
print(f"saved: id=1 → table {TABLE}")
