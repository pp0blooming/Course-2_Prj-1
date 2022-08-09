# Course-2_Prj-1
Course-2_Prj-1  Launch an EC2 instance using Terraform

- 1. create a repo in GitHub 
- 2. git clone the repo in terminal	
- 3. Go to AWS -> IAM -> create user

  add user "devops" with "admin" permission. 
  Access key ID ==  AKIA2UKO5EL5RJ2NMB55 
  Secret access key ==  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

- 4. setup AWS profile 	

  $ aws configure 
  > AWS Access Key ID [****************KSBI]: AKIA2UKO5EL5RJ2NMB55
  > AWS Secret Access Key [****************GbPc]: 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
  > Default region name [us-east-1]: 
  > Default output format [json]: 
  $ aws s3 ls		--> if no error returns that's good. 

- 5. write the terraform script
- 6. Check on AWS console. VM is provisioned or not?     

