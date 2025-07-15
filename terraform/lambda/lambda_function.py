import json
import boto3

def lambda_handler(event, context):
    try:
        dynamodb = boto3.resource("dynamodb")
        table = dynamodb.Table("VisitorCount")

        response = table.update_item(
            Key={"id": "visitors"},
            UpdateExpression="SET count = if_not_exists(count, :start) + :inc",
            ExpressionAttributeValues={":start": 0, ":inc": 1},
            ReturnValues="UPDATED_NEW"
        )

        new_count = response["Attributes"]["count"]

        return {
            "statusCode": 200,
            "body": json.dumps({
                "message": "Visitor count updated",
                "newCount": new_count
            })
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({
                "message": f"Error updating visitor count: {str(e)}"
            })
        }
