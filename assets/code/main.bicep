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
