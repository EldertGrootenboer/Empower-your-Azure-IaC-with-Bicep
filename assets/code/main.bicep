module sbModule 'servicebus.bicep' = {
  name: 'sbModule'
  params: {
    maxMessageSizeInMegabytes: 50
    environment: 'production'
    location: 'westeurope' 
  }
}
