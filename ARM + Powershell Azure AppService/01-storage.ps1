$subscriptionId = "548c19b9-0e27-4e84-9c96-69f7d2857158"
Select-AzSubscription -SubscriptionId $subscriptionId

$rg = 'FA-SomeName-RG'
New-AzResourceGroup -Name $rg -location westeurope -Force

New-AzResourceGroupDeployment `
    -Name -'test-storage' `
    -ResourceGroupName $rg `
    -TemplateFile "01-storage.json" `
    -storageName 'thecoolteststorage' `
    -storageSKU 'Standard_GRS'