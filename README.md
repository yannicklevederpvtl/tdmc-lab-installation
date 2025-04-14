Tanzu Data Management Console Demo Lab Installation
=================

Scripts to download Tanzu Data Management Console tools and generate artifacts for installation on VMware vSphere Kubernetes Service

### Download and install tools in your jumpbox ###

- Clone this project in your jumpbox (Linux Ubuntu)
- Copy the **tmc-config.yaml** template to create your own
```
cp ./templates/tdmc-config_template.yaml tdmc-config.yaml
```
- Configure your environment variables and credentials in your **tmc-config.yaml** file

- Once this is done, run the **download.sh** script to download tools and TDMC Installer from the Broadcom Support Portal

```
./download.sh
```

### Generate artifacts for the installation ###

- Run the **configure.sh** script to generate artifacts for the TDMC installation based on your environment variables and credentials

```
./configure.sh
```

### Follow the generated instructions ###

Follow the generated instructions based on your environment variables and credentials here
```
./generated/instructions.md
```

Tanzu Platform for CF Integration
------
As of Tanzu Data Management Console version 1.0, there is a pre-alpha quality integration for Tanzu Platform for CF.  To get it working currently requires manually updating records in the TDMC management database.  Even when you do get it working, you can't control policies, backups, and you don't get a pgadmin interface to the database.  You can read the [current findings](https://docs.google.com/document/d/1RynLWLsBlK_0A3ymfBKdFDM4zIpAadHtDcEei5ND24o/edit?tab=t.0) from the team on this integration.

The entire integration is being redesigned, and you can read up on some of [the plans for that integration in this document](https://docs.google.com/document/d/1AnjuxVsq1yRSd8iDN86hwmZHJCapHalheS2ujGmke38/edit?tab=t.0#heading=h.1x4gnkmhvbf9).

Links
-------

Tanzu Data Management Console documentation\
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-data-management-console/1-0/tdmc/index.html

To get your Tanzu Pivnet Token\
https://support.broadcom.com/group/ecx/tanzu-token

To get your Broadcom Support Portal credential\
https://support.broadcom.com/group/ecx/productdownloads?subfamily=Tanzu%20Data%20Management%20Console


