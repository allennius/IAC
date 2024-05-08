Powershell script deploys the json ARM template

webapp.ps1 functionality
* choses subscription on azure
* creates resource group
* creates app service plan (needs to be created here or webapp wont find the service plan in webapp.json, alternative is to run script twice)
* deploys webapp.json with previous info
* creates backup storage to resource group
* creates backup schedule for webapp with 7 days interval 

webapp.json deploys
* webapp with 2 extra slots (production, staging, dev),
* autoscaling to a max scale of 3
* Budget 800kr montly, emails if cost goes above 80% of Budget
* Alert Http 4xx, more then 5 past 15min
 

* Module Az required in powershell
following commands to deploy storage via powershell

Connect-AzAccount
.\02-webapp.ps1
