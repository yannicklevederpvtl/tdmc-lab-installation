Tanzu Data Management Console Demo Lab Installation
=================

Scripts to download Tanzu Data Management Console tools and generate artifacts for installation on VMware vSphere Kubernetes Service

### Download and install tools in your jumpbox ###

- Clone this project in your jumpbox (Linux Ubuntu)
- Copy the **tmc-config.yaml** template
```
cp ./templates/tdmc-config_template.yaml tdmc-config.yaml
```
- Configure your environment variables and credentials in this **tmc-config.yaml** file

- Once this is done, run the script to download tools and the TDMC Installer from the Broadcom Support Portal.

```
./download.sh
```

### Generate artifacts for the installation ###

- Run the script to generate the artifacts for the TDMC installation based on your environment variables and credentials

```
./configure.sh
```

### Follow the generated instructions ###

Follow the generated instructions based on your environment variables and credentials here
```
./generated/instructions.md
```

Links
-------

Tanzu Data Management Console documentation\
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-data-management-console/1-0/tdmc/index.html

To get your Tanzu Pivnet Token\
https://support.broadcom.com/group/ecx/tanzu-token

To get your Broadcom Support Portal credential\
https://support.broadcom.com/group/ecx/productdownloads?subfamily=Tanzu%20Data%20Management%20Console


