# Sliderule Quick Deploy

This is a quick deploy of the Sliderule project. It is intended to be used for development and testing purposes only. It is not intended for production use.

## Purpose

The purpose of this project is to provide a quick way to deploy the Sliderule project for development and testing purposes.

It is intended to be used as a trial and demo while the main Sliderule project is being installed.

## Prerequisites

Launching this project requires the following:
- Terraform
- Valid AWS credentials and a configured AWS profile

Hosting this project in AWS requires the following:
- An EKS cluster in AWS
- A Route53 hosted zone
- Optionally, the AWS ALB controller installed in EKS. However, you can configure this stack to deploy that for you if needed.


## Installation
- Copy `example.tfvars.txt` to `main.tfvars`
- Populate `main.tfvars` with your values. Refer to the `variables.tf` file for descriptions of each variable.
- Optionally run `make apply` in this directory to deploy the stack. This will deploy the stack using the values in `main.tfvars`. This will also deploy the stack with no backend, and will save the backend to your local directory.
- Alternatively, run your own terraform init commands or edit main.tf to add a backend in a location like S3, according to your organization's standards.

## Configuration

Refer to the `variables.tf` file for descriptions of each variable and how to customize your installation.

## Usage

You can use Sliderule by interacting with the web endpoints it deploys. Endpoints are made availalbe for the web app and the API, and are detailed in the outputs of this Terraform stack.

Refer to the output of your `terraform apply` command, or run `terraform output` to see the endpoints.
