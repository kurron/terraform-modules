variable "region" {
    type = "string"
    description = "The AWS region to deploy into (e.g. us-east-1)"
}

variable "aws_access_key" {
    type = "string"
    description = "ID of the API key to use"
}

variable "aws_secret_key" {
    type = "string"
    description = "Secret value of the API key to use"
}

variable "iam_bucket" {
    type = "string"
    description = "S3 bucket containing the IAM Terraform state"
}

variable "iam_key" {
    type = "string"
    description = "S3 key pointing to the IAM Terraform state"
}

variable "iam_region" {
    type = "string"
    description = "Region where the S3 bucket containing the IAM Terraform state is located"
}

variable "lambda_bucket" {
    type = "string"
    description = "S3 bucket containing the scheduling Lambda function Terraform state"
}

variable "lambda_key" {
    type = "string"
    description = "S3 key pointing to the scheduling Lambda function Terraform state"
}

variable "lambda_region" {
    type = "string"
    description = "Region where the S3 bucket containing the scheduling Lambda function Terraform state is located"
}

variable "project" {
    type = "string"
    description = "Name of the project these resources are being created for"
}

variable "creator" {
    type = "string"
    description = "Person creating the resources"
}

variable "environment" {
    type = "string"
    description = "Context the resources will be used in, e.g. production"
}

variable "freetext" {
    type = "string"
    description = "Information that does not fit in the other tags"
}
