# If you do not have the Az (Azure) Module installed in PowerShell, you will need to install it
# Note you only need to do this once
# Install-Module Az

# Login to Azure. This will open your default web browser and ask you to login to Azure.
# If you are already logged in, it will just ask you to confirm the account to use
az login

# Set Account
# az account set --subscription "Visual Studio Ultimate with MSDN"
# az account set --subscription "Pay-As-You-Go"
az account set --subscription "Azure Free Trial"

# Create the resource group
az group create --location centralus --name acadmsrg

# This is to deploy from the Microsoft github site for this ADMS tutorial
# The amount of time it takes is dependant on your account and how busy
# Azure is, but times of 20 minutes are not uncommon
az group deployment create --name acadmsdeploy --resource-group acadmsrg --template-uri https://raw.githubusercontent.com/arcanecode/Introduction-to-the-Azure-Data-Migration-Service/master/Demo/adms.deploy.json --parameters https://raw.githubusercontent.com/arcanecode/Introduction-to-the-Azure-Data-Migration-Service/master/Demo/adms.parameters.json


#------------------------------------------------------------------------------
# This section is just some useful helper commands for use in dev
#------------------------------------------------------------------------------
# To reset when done, delete the group
# az group delete --name acadmsrg

# For this demo, we are using the centralus location. You may wish to change
# to a location closer to you. In order to get a list of locations, use the
# following command:
# az account list-locations --output table


