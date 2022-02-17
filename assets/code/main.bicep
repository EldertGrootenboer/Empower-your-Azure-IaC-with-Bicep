module sample 'sample.bicep' = {
  name: 'samplemodule'
  params: {
    storageAccounts: [
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
  }
}

resource keyVault 'Microsoft.KeyVault/vaults@2021-06-01-preview' existing = {
  name: 'myKeyVault'
}

module sql './sql.bicep' = {
  name: 'deploySQL'
  params: {
    sqlAdminPassword: keyVault.getSecret('sqlAdminPassword')
  }
}
