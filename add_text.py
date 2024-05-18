import json
import boto3
import os
from uuid import uuid4

dynamodb = boto3.resource('dynamodb')
table_name = os.getenv('TABLE_NAME')
table = dynamodb.Table(table_name)


def lambda_handler(event, context):
    text = event.get('text', '')
    if not text:
        return {'statusCode': 400, 'body': json.dumps('No text provided')}

    item = {'ID': str(uuid4()), 'Text': text}
    table.put_item(Item=item)

    return {'statusCode': 200, 'body': json.dumps('Text added successfully')}
