import json
import boto3
import os

dynamodb = boto3.resource('dynamodb')
table_name = os.getenv('TABLE_NAME')
table = dynamodb.Table(table_name)


def lambda_handler(event, context):
    response = table.scan()
    items = response.get('Items', [])
    return {'statusCode': 200, 'body': json.dumps(items)}
