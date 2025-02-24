Tanzu Data Management Console Demo Lab Installation
=================

Scripts to download Tanzu Data Management Console tools and generate artifacts for the installation on VMware vSphere Kubernetes Service

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
