@secure()
param sqlAdminPassword string

resource sqlServer 'Microsoft.Sql/servers@2021-05-01-preview' = {
  name: 'mySqlServer'
  location: 'westeurope'
  properties: {
    administratorLogin: 'Admin'
    administratorLoginPassword: sqlAdminPassword
    version: '12.0'
  }
}
