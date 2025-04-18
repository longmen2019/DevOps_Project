import json
import boto3
from time import gmtime, strftime

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('HelloWorldDatabase')
now = strftime("%a, %d %b %Y %H:%M:%S +0000", gmtime())

def lambda_handler(event, context):
    name = event['firstName'] + ' ' + event['lastName']
    response = table.put_item(
        Item={
            'ID': name,
            'LatestGreetingTime': now
        })
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda, ' + name)
    }