az storage account create --name storageaula06 --resource-group rg-aula06-projetofinal --location eastus  --sku Standard_LRS
az storage container create --name tfstate --account-name storageaula06