@allowed([
  'westeurope'
  'westus'
])
param location string = 'westeurope'

@allowed([
  'test'
  'production'
])
param environment string = 'test'

@minValue(1)
@maxValue(100)
param maxMessageSizeInMegabytes int

var namespaceName = 'sb-elder-demo-${uniqueString(resourceGroup().id)}'
var maxMessageSizeInKilobytes = maxMessageSizeInMegabytes * 1028

var queues = [
  'OrderQueue'
  'InvoiceQueue'
]

resource serviceBus 'Microsoft.ServiceBus/namespaces@2021-11-01' = {
  name: namespaceName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  sku: {
    name:  'Premium'
  }
  properties: {
    disableLocalAuth: environment == 'test' ? false : true
    zoneRedundant: true
    encryption: {
      keySource: 'Microsoft.KeyVault'
      keyVaultProperties: [
        {
          keyVaultUri: keyVault.properties.vaultUri
        }
      ]
    }
  }
}
output serviceBusEndpoint string = serviceBus.properties.serviceBusEndpoint

resource orderQueue 'Microsoft.ServiceBus/namespaces/queues@2021-11-01' = {
  name: 'OrderQueue'
  properties: {
    maxMessageSizeInKilobytes: maxMessageSizeInKilobytes
    requiresDuplicateDetection: true
    requiresSession: true
  }
  parent: serviceBus
}

resource queuesLoop 'Microsoft.ServiceBus/namespaces/queues@2021-11-01' = [for queue in queues: {
  name: queue
  properties: {
    maxMessageSizeInKilobytes: maxMessageSizeInKilobytes
    requiresDuplicateDetection: true
    requiresSession: true
  }
  parent: serviceBus
}]

resource warehouseTopic 'Microsoft.ServiceBus/namespaces/topics@2021-11-01' = {
  name: 'WarehouseTopic'
  properties: {
    maxMessageSizeInKilobytes: maxMessageSizeInKilobytes
    requiresDuplicateDetection: true
  }
  parent: serviceBus
}

resource euSubscription 'Microsoft.ServiceBus/namespaces/topics/subscriptions@2021-11-01' = {
  name: 'emeaSubscription'
  properties: {
    requiresSession: true
  }
  parent: warehouseTopic
  resource filter 'rules' = {
    name: 'emeaFilter'
    properties: {
      sqlFilter: {
        sqlExpression: 'Region = \'EU\''
      }
    }
  }
}

resource naSubscription 'Microsoft.ServiceBus/namespaces/topics/subscriptions@2021-11-01' = {
  name: 'naSubscription'
  properties: {
    requiresSession: true
  }
  parent: warehouseTopic
  resource filter 'rules' = {
    name: 'emeaFilter'
    properties: {
      sqlFilter: {
        sqlExpression: 'Region = \'NA\''
      }
    }
  }
}

resource keyVault 'Microsoft.KeyVault/vaults@2021-11-01-preview' existing = {
  name: 'MyKeyVault'
}
