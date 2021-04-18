// Initial storage account
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'mystorage1516514451'
  location: 'westeurope'
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    supportsHttpsTrafficOnly: true
  }
}

// Parameters
param storageAccountName string = 'mystorage1516514451'

// Variables with string interpolation
var uniqueStorageAccountName = '${storageAccountName}${uniqueString(resourceGroup().name)}'

// Parameters with object
param myStorageAccount object = {
  name: 'mystorage1516514451'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
}

// Storage account with conditional
resource storageAccount2 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'mystorage15165144512'
  location: 'westeurope'
  kind: 'StorageV2'
  sku: {
    name: startsWith(storageAccountName, 'prod') ? 'Standard_ZRS' : 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    supportsHttpsTrafficOnly: true
  }
}

// Parameters with decorators
@allowed([
  'westeurope'
  'northeurope'
])
param location string = 'westeurope'

// Storage account with changes
resource storageAccount3 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: myStorageAccount.name
  location: location
  kind: 'StorageV2'
  sku: {
    name: myStorageAccount.sku.name
    tier: myStorageAccount.sku.tier
  }
  properties: {
    supportsHttpsTrafficOnly: true
  }
}

// Output with property
output storageAccountPrimaryLocation string = storageAccount.properties.primaryLocation

// Parameter array
param storageAccounts array = [
  {
    name: 'mystorage1516514451'
    sku: {
      name: 'Standard_LRS'
      tier: 'Standard'
    }
  }
  {
    name: 'mystorage332651515'
    sku: {
      name: 'Standard_ZRS'
      tier: 'Standard'
    }
  }
]

// Storage account with loops
resource storageAccount4 'Microsoft.Storage/storageAccounts@2021-02-01' = [for account in storageAccounts: {
  name: account.name
  location: 'westeurope'
  kind: 'StorageV2'
  sku: {
    name: account.sku.name
    tier: account.sku.tier
  }
}]

// App service plan
resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'myServerFarm'
  location: location
  sku: {
    name: 'S1'
    tier: 'Standard'
  }
}

// Web app
resource webApp 'Microsoft.Web/sites@2020-12-01' = {
  name: 'myWebApp'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
  identity: {
    type: 'SystemAssigned'
  }
}
