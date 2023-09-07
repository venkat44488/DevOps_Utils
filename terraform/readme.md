# header1

### Terraform top level blocks
	1. terraform block : also called settings block introduced in 0.13 version.
	2. provider block 
	3. resource block 
	4. input variable block
	5. output variable block
	6. local values block
	7. data sources block
	8. modules block

###  VARIABLE interpolation: feteching the value of a resources and passing as value to other resources	
	ex: vpc_id="${aws_vpc.main.id}"
### variable declaration and using them in output 
	1. strng
	2. list
	3. maps
	4. boolean
	
1. string example
```t
variable "name"{
  type = "string"
  default = "ramana"
}

output "myname" {
  value = "${var.name}"
}
```
2. map example
```t
variable "mapexample" {
  type = "map"
  default = {
    "us-east" = "ami1"
    "us-west" = "ami2"
  }
}

```

3. list example
```t
variable "mylist" {
  type = "list"
  default = ["sg1","sg2" , "sg3"]
}


output "printlist" {
  value = "${var.mylist}"
}

output "mapoutput" {
  value = "${var.mapexample["us-east"]}"
}
```
###  worksace: to maintain consistency across all platforms we are having different workspace
	ex: 
	  1. terraform workspace new  dev
      2. terraform workspace new  test
      3. terraform workspace new  prod
      4. terraform workspace list
	  5. terraform workspace select test

 ### provisiones in terraform
	Provisioners are two types: 
		1. local exec: commands that need to be executed on local machine after certain
		resource has been created i.e: where we run "terraform apply".  this kind of approach is usefull 
		to run ansible playbooks.
			ex: 
			resource "aws_instance" "web" {
			  # ...

			  provisioner "local-exec" {
				command    = "echo The server's IP address is ${self.private_ip}"
				on_failure = "continue"
			  }
			}
		2. remote exec: allows to run commands or invoke scripts directly on remote server.
			resource "aws_instance" "web" {
			  # ...

			  provisioner "file" {
				source      = "script.sh"
				destination = "/tmp/script.sh"
			  }

			  provisioner "remote-exec" {
				inline = [
				  "chmod +x /tmp/script.sh",
				  "/tmp/script.sh args",
				]
			  }
			}
	

## FAQ'S in terraform 
-  where do you maintain state files?
   1. state files will be maintained in s3. 
   2. object lock option is there in aws s3.
   3. we can create dynamodb table and configure in terraform.tf file 

 - What is the difference between Terraform state and Terraform plan?
  - Terraform state is a file that keeps track of the resources Terraform manages, while Terraform plan generates an execution plan that shows what actions Terraform will take to achieve the desired infrastructure state.
- How does Terraform handle dependencies between resources?
  - Terraform automatically handles resource dependencies based on the order they are defined in the     configuration. You can also use explicit dependencies and data sources to manage dependencies more precisely.
- What is a Terraform module, and why would you use it?
- How can you manage secrets or sensitive information in Terraform configurations?
 - Suppose you have an AWS access key and secret key that you want to keep secure and not store directly in your Terraform configuration files.
 1. Set Environment Variables:
First, set the AWS access key and secret key as environment variables on your local machine or in your deployment environment. You can do this by running commands like these in your terminal:
```t 
# Read secrets from pass and set as environment variables
$ pass insert db_username
Enter password for db_username: admin
$ pass insert db_password
Enter password for db_password: password
export TF_VAR_username=$(pass db_username)
export TF_VAR_password=$(pass db_password)

variable "username" {
 type = string
}
variable "password" {
 type = string
 provider "aws" {
 access_key = var.username
 secret_key = var.password
}

```
-

 ### Additional Observations
- AMI Name is static - How to make it Dynamic ?
  - Use Terraform Datasources concept
- What are Terraform's main components?
  - providers, resources, modules.
- terraform supported backend types = local,s3,consul,....
- terraform force-unlock ===> command can be used to remove the lock on the terraform state for the current configuration .
- terraform force-unlock == command can be used to remove the locak on the terraform state for the current configuration.
terraform state show aws_internet_gateway.demo
terraform state mv aws_s3_bucket.data-bucket aws_s3_bucket.prod-encrypted-data-s3-bucket == recreate the bucket/ similar to rename.
