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
	
variable "name"{
  type = "string"
  default = "ramana"
}

output "myname" {
  value = "${var.name}"
}
2. map example
// this is map variable example
variable "mapexample" {
  type = "map"
  default = {
    "us-east" = "ami1"
    "us-west" = "ami2"
  }
}

3. list example

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
### Q) where do you maintain state files?
 --> state files will be maintained in s3. 
 --> object lock option is there in aws s3.
 --> we can create dynamodb table and configure in terraform.tf file 