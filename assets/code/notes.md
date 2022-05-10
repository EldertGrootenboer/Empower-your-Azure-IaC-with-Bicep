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
2. Empty template
3. Bicep context menu
4. Create namespace
5. Parameters
6. Variables
7. String interpolation
8. Conditionals
9. Decorators
10. Use outputs
11. Looping
12. Existing resources
13. Modules
14. Visualizer
15. Deployment
16. Decompiling
