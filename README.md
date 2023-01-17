# Azure Container Registry
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/)

This Terraform module creates an Azure Container Registry.

  - It applies a default diagnostics settings  
  - It configures a private endpoint if private access is enabled
  - It configures user managed identities scoped at the ACR for AcrPull and AcrPush roles 

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## Related documentation

Microsoft Azure documentation: [Azure Container Registry](https://docs.microsoft.com/en-us/azure/container-registry/).
