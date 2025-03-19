Got it! Here’s the updated `README.md` file with "Real-time DevOps Day2Day" removed:

```markdown
# Serverless Web Application using AWS Amplify, Lambda, and DynamoDB

## Project Overview
This project demonstrates how to build a serverless architecture web application using AWS services such as:
- **AWS Amplify** for frontend hosting,
- **AWS Lambda** for backend logic, and
- **Amazon DynamoDB** for data storage.

The web application accepts user input (First Name and Last Name), displays a personalized message, and stores the interaction in a DynamoDB table.

---

## Project Roadmap

### 1. Frontend Setup with AWS Amplify
- Create an `index.html` file with the following content:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Learn IT with Azizul</title>
    <style>
        .headline {
            font-size: 24px;
            font-weight: bold;
            color: green;
        }
        .actions {
            font-size: 18px;
            color: black;
        }
    </style>
</head>
<body>
    <p class="headline">Learn IT with Azizul</p>
    <p class="actions">Like / Dislike / Comment / Subscribe</p>
</body>
</html>
```

- Compress the file into a ZIP format.
- Go to **AWS Amplify** and deploy the frontend (without Git integration).
- Select the environment as `dev`, upload the ZIP file, and deploy.
- Access the web application through the generated domain URL.

---

### 2. Create AWS Lambda Function
- Go to the AWS Lambda console and create a function using the Python 3.12 runtime.
- Use this initial Lambda function code:

```python
import json
def lambda_handler(event, context):
    name = event['firstName'] + ' ' + event['lastName']
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda, ' + name)
    }
```

- Deploy and test the function using this payload:
```json
{
  "firstName": "Ada",
  "lastName": "Lovelace"
}
```
- Save and overwrite the test.

---

### 3. API Gateway Setup
- Create a REST API with an **edge-optimized endpoint** in API Gateway.
- Add a **POST method** and link it to the Lambda function.
- Enable **CORS** and save the configuration.
- Deploy the API to a new stage named `dev` and save the invoke URL.

---

### 4. DynamoDB Table Setup
- Create a DynamoDB table with a partition key named `ID`.
- Copy the table **ARN** for later use.

---

### 5. Enhance Lambda Function to Store Data in DynamoDB
- Replace the previous Lambda function code with the following:

```python
import json
import boto3
from time import gmtime, strftime

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('HelloWorldDatabase')
now = strftime("%a, %d %b %Y %H:%M:%S +0000", gmtime())

def lambda_handler(event, context):
    name = event['firstName'] + ' ' + event['lastName']
    table.put_item(
        Item={
            'ID': name,
            'LatestGreetingTime': now
        }
    )
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda, ' + name)
    }
```

- Deploy the updated function.

---

### 6. Update Lambda Permissions
- Navigate to the Lambda Execution Role and add an **inline policy** with the following JSON:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:PutItem",
        "dynamodb:GetItem"
      ],
      "Resource": "YOUR-TABLE-ARN"
    }
  ]
}
```

- Replace `YOUR-TABLE-ARN` with the copied ARN and create the policy.

---

### 7. Interactive Web Application
- Update `index.html` with an interactive form and JavaScript to call the API:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>API Test Form</title>
    <style>
        input {
            color: #232F3E;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 20px;
            margin-left: 20px;
        }
    </style>
    <script>
        function callAPI() {
            const firstName = document.getElementById('fName').value;
            const lastName = document.getElementById('lName').value;

            if (!firstName || !lastName) {
                alert("Please enter both First Name and Last Name.");
                return;
            }

            fetch("your-api-invoke-url", {
                method: 'POST',
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ firstName, lastName })
            })
            .then(response => response.json())
            .then(result => alert(result.body || `Error: ${result.error}`))
            .catch(() => alert("An error occurred while calling the API."));
        }
    </script>
</head>
<body>
    <form>
        <label for="fName">First Name:</label>
        <input type="text" id="fName">
        <label for="lName">Last Name:</label>
        <input type="text" id="lName">
        <button type="button" onclick="callAPI()">Call API</button>
    </form>
</body>
</html>
```

- Replace `your-api-invoke-url` with the actual API Gateway Invoke URL.
- Compress the updated `index.html` file and redeploy to AWS Amplify.

---

### 8. Final Testing
- Visit the web application URL.
- Enter First and Last Names and click **Call API**.
- Verify the response and check the DynamoDB table for stored entries.

---

## Project Deliverables
- **Web Application URL**: Hosted on AWS Amplify.
- **API Gateway**: Connected to Lambda for processing requests.
- **DynamoDB Table**: Stores user interactions.
- **AWS Lambda Function**: Handles backend logic.

---

## Security and Scalability Considerations
- Enable **IAM Role Permissions** for secure access to DynamoDB.
- Use **API Gateway Throttling** to handle traffic spikes.
- Implement **CloudWatch Alarms** for monitoring Lambda performance.

