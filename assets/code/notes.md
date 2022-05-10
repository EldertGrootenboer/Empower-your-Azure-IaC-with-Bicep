# Notes

## Installation & tooling

<https://github.com/Azure/bicep/blob/main/docs/installing.md#install-the-bicep-cli-details>

## Compiling Bicep

az bicep build --files .\assets\demo\demo.bicep

## Decompiling Bicep

az bicep decompile --file .\assets\demo\sample.json

## Deploying Bicep

az deployment group create -g rg-eldert-empower-your-azure-iac-with-bicep --template-file .\assets\demo\main.bicep -environment production

## Login to Azure

az login
az account set -s my-subscription-id

## Set up KeyVault

<https://docs.microsoft.com/en-us/azure/service-bus-messaging/configure-customer-managed-key>

## Steps

1. Installation & tooling
1. Empty template
1. Bicep context menu
1. Create namespace
1. Parameters (location & maxMessageSizeInMegabytes)
1. Variables ( maxMessageSizeInKilobytes)
1. String interpolation (namespaceName)
1. Conditionals (environment)
1. Decorators (all parameters)
1. Child resource (queue)
1. DependsOn (topic and subscription)
1. Use outputs (serviceBusEndpoint)
1. Looping (queues)
1. Existing resources (Key Vault)
1. Modules
1. Visualizer
1. Deployment
1. Decompiling
