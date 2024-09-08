# Dockerized AWS API Scraper

This repository contains a script for scraping data from the AWS API using Docker. Follow the instructions below to get started.

## Prerequisites

Before running the script, make sure you have the following:

- Docker installed on your machine
- AWS CLI installed and configured with your AWS credentials
- aws-vault installed and configured for secure provision of AWS credentials to the Docker container

## Configuration

To configure aws-vault for secure provision of AWS credentials to the Docker container, follow these steps:

1. Install aws-vault by following the instructions in the [official documentation](https://github.com/99designs/aws-vault#installation).
2. Configure aws-vault with your AWS credentials by running `aws-vault add <profile-name>`. Replace `<profile-name>` with the name of your AWS profile.
3. Set the `AWS_PROFILE` environment variable in your terminal by running `export AWS_PROFILE=<profile-name>`. Replace `<profile-name>` with the name of your AWS profile.

## Running the Script with docker

To start the script using Docker, follow these steps:

1. Navigate to the repository's directory.
2. Open a terminal and set the `AWS_PROFILE` environment variable by running `export AWS_PROFILE=<profile-name>`. Replace `<profile-name>` with the name of your AWS profile.
3. Run the `manual_run_with_docker.sh` script by executing the following command: `./manual_run_with_docker.sh`.

The script will now run inside a Docker container, utilizing the AWS credentials provided by aws-vault.

## Running the Script via Python

To run a Python script with initialization steps, such as installing requirements, you can follow these steps:

1. Open a terminal and navigate to the repository's directory.

2. Create a virtual environment by running the following command:
```
python3 -m venv venv
```

3. Activate the virtual environment by executing the appropriate command based on your operating system:
    - For macOS/Linux:
    ```
    source venv/bin/activate
    ```
    - For Windows:
    ```
    venv\Scripts\activate
    ```

4. Install the required packages by running the following command:
```
pip install -r requirements.txt
```

5. Once the packages are installed, you can run your Python script using the following command:
```
python scraper.py
```

6. Check output in the ./outpuy directory