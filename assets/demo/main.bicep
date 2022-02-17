param location string = 'westeurope'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'myAppServicePlan'
  location: location
}

resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: 'myWebApp'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}
