import pytest # Brings in the testing framework
import sys, os                      
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))
# Adds the parent folder to Python's module search path
# This lets Python find lambda_function.py one level up

from lambda_function import lambda_handler   # Imports your Lambda code
from unittest.mock import patch  # Lets you mock AWS calls like boto3


@patch("lambda_function.boto3.resource")
def test_lambda_handler(mock_dynamodb_resource):
    # Arrange: fake table + context
    mock_table = mock_dynamodb_resource.return_value.Table.return_value
    mock_table.update_item.return_value = {"Attributes": {"count": 42}}

    event = {}
    context = {}

    # Act
    response = lambda_handler(event, context)

    # Assert
    assert response["statusCode"] == 200
    assert "Visitor count updated" in response["body"]

@patch("lambda_function.boto3.resource")
def test_lambda_handler_error(mock_dynamodb_resource):
    # Arrange: Simulate DynamoDB failure
    mock_table = mock_dynamodb_resource.return_value.Table.return_value
    mock_table.update_item.side_effect = Exception("DynamoDB failure")

    event = {}
    context = {}

    # Act
    response = lambda_handler(event, context)

    # Assert
    assert response["statusCode"] == 500
    assert "Error updating visitor count" in response["body"]
