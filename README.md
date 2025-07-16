# Cloud Resume Challenge - Build
![CI](https://github.com/AlexPR704/Cloud_Portfolio/actions/workflows/python-app.yml/badge.svg)
![Frontend Deploy](https://github.com/AlexPR704/Cloud_Portfolio/actions/workflows/deploy-frontend.yml/badge.svg)

Welcome! This is my end-to-end deployment of a cloud-native resume site built on AWS, using infrastructure as code, CI/CD, and Python-based Lambda for backend logic.

## Features
- Static site hosted via S3 + CloudFront
- Secure access with HTTPS and custom DNS
- Visitor counter using JavaScript, API Gateway, and Lambda
- Visitor tracking stored in DynamoDB
- Infrastructure deployed with Terraform
- Unit tests with `pytest` and mocking
- CI/CD with GitHub Actions for backend reliability
- Fully version-controlled repo

## Why I Built This
This project was part of the [Cloud Resume Challenge](https://cloudresumechallenge.dev) with a twist to strengthen my cloud engineering skills. I wanted to create a production-grade setup using best practices in automation, testing, and security.

## Live Demo
👉 [alexander-resume-site.com](https://d17qrlv1yga6q4.cloudfront.net)

## Repo Structure
| Directory            | Purpose                            |
|----------------------|-------------------------------------|
| `terraform/`         | Infra as code for AWS provisioning |
| `lambda/`            | Backend logic for visitor counter  |
| `test_lambda/`       | Pytest-based unit tests            |
| `.github/workflows/` | CI/CD workflows for backend + frontend |
| `index.html`         | Static resume homepage             |
| `style.css`          | Styling for resume site            |


## Tech Stack
Technology: The purpose

AWS S3: Hosts the static HTML/CSS resume site

Amazon: CloudFront	Distributes content globally with HTTPS

Route 53: Manages DNS and custom domain settings

AWS Lambda: Runs Python backend logic for visitor counter

API Gateway: Connects frontend JavaScript to backend Lambda function

DynamoDB: Stores and updates visitor count

Python 3.12: Powers the Lambda function and local development

Boto3: AWS SDK for interacting with DynamoDB

pytest: Framework used to write and run unit tests

Terraform: Manages AWS infrastructure as code

GitHub Actions: Automates CI/CD for backend testing and deployment

## Unit Testing
The Lambda function includes robust unit tests that validate both success and failure scenarios:

* Successful DynamoDB updates Ensures correct visitor count increments are returned

* Simulated DynamoDB failures Uses mocking to verify graceful error handling and appropriate 500 responses

To run the tests locally with pytest:

- bash
- pytest

All test dependencies are managed via requirements.txt, and the tests automatically run on every GitHub push thanks to CI/CD integration.

## What I Learned

This project helped me go beyond basic cloud concepts and actually build something real! I got hands-on with AWS services like Lambda, DynamoDB, and API Gateway. I was able to learn how they fit together in a serverless setup. I also worked through troubleshooting IAM configs and getting CI/CD working in GitHub Actions. It pushed me to think like a cloud engineer, not just follow tutorials. I was  very excited to pass the AWS Cloud Practitioner certification but I knew I needed more. I wanted to understand the ins and outs.This challenge made it all click and drives me to want more. My goal is to become a Cloud or Data Engineer, and this definitely helped me get closer!

