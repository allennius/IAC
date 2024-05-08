$rgName = 'FA-SomeName-RG'
$appServicePlan = "godsplan"
$location = "West Europe"
$webappname = "flaskbotten"
$linuxFxVersion = "PYTHON|3.12"

#subscription
$subscriptionId = "548c19b9-0e27-4e84-9c96-69f7d2857158"
Select-AzSubscription -SubscriptionId $subscriptionId

#resource group
New-AzResourceGroup -Name $rgName -Location $location -Force

#app service plan
New-AzAppServicePlan -ResourceGroupName $rgName -Name $appServicePlan `
-Location $location -Linux -Tier Standard

# webapp with 3 slots total, autoscaling, budget and alert for 4xx errors
New-AzResourceGroupDeployment `
    -Name -'test-app' `
    -ResourceGroupName $rgName `
    -TemplateFile "02-webapp.json" `
    -webbAppName $webappname `
    -appServicePlanName $appServicePlan `
    -linuxFxVersion $linuxFxVersion

# COMMENT OUT FROM HERE IF APP IS ALREADY CREATED
#Backup storage for app
# $storageName = "$($webappname)storage"
# $storage = New-AzStorageAccount -ResourceGroupName $rgName `
# -Name $storageName -SkuName Standard_LRS -Location $location

# #Backupcontainer
# $containerName = "appbackup"
# New-AzStorageContainer -Name $containerName -Context $storage.Context

# # Valid 1 Year
# $sasUrl = New-AzStorageContainerSASToken -Name $containerName -Permission rwdl `
# -Context $storage.Context -ExpiryTime (Get-Date).AddYears(1) -FullUri

# #Backup schedule once a week, starting in one hour, retaining for 2 weeks
# Edit-AzWebAppBackupConfiguration -ResourceGroupName $rgName -Name $webappname `
# -StorageAccountUrl $sasUrl -FrequencyInterval 7 -FrequencyUnit Day -KeepAtLeastOneBackup `
# -StartTime (Get-Date).AddHours(1) -RetentionPeriodInDays 14 -Enabled

# # List statuses of  all backups that  are complete or executing
# Get-AzWebAppBackupList -ResourceGroupName $rgName -Name $webappname

# TO HERE