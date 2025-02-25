Tanzu Data Management Console (TDMC) Deployment Instructions
=================

Commands to deploy one TDMC Control Plane and one TDMC Data Plane in your VMware vSphere Kubernetes Service environment.

- [Custom VM Class Creation](#custom-vm-class-creation)
- [VKS Clusters Creation](#vks-clusters-creation)
- [TDMC Control Plane Installation](#tdmc-control-plane-installation)
- [TDMC Data Plane Creation](#tdmc-data-plane-creation)


Custom VM Class Creation
-----------

Create a custom VM Class for your VKS clusters:

- Workload Management -> "Service" tab -> Click "Manage" on the "VM Service" tile -> Click "Create VM Class"
- Enter **$tdmcControlPlaneTKGCustomVMClass$** as name for the VM CLass
- Configure 8 vCPUs and 16 GB of RAM.
- Add this new VM Class in your vSphere namespace
- Use "kubectl get vmclass" in your vSphere namespace to verify its presence

VKS Clusters Creation
-----------

Create the TDMC Control Plane VKS cluster:

```
export KUBECTL_VSPHERE_PASSWORD='$vcenterPassword$'
kubectl vsphere login --server $supervisorIp$ -u $vcenterUsername$ --insecure-skip-tls-verify -v=10 --tanzu-kubernetes-cluster-namespace $tdmcControlPlaneVCNamespace$
kubectl config use-context $tdmcControlPlaneVCNamespace$
kubectl apply -f ./generated/tdmccp-cluster-generated.yaml
```

Create the TDMC Data plane VKS cluster:

```
kubectl vsphere login --server $supervisorIp$ -u $vcenterUsername$ --insecure-skip-tls-verify -v=10 --tanzu-kubernetes-cluster-namespace $tdmcDataPlaneVCNamespace$
kubectl config use-context $tdmcDataPlaneVCNamespace$
kubectl apply -f ./generated/tdmcdp-cluster-generated.yaml
```

TDMC Control Plane Installation
-----------
Connect to your TDMC Control Plane VKS Cluster:

```
kubectl vsphere login --server $supervisorIp$ -u $vcenterUsername$ --insecure-skip-tls-verify -v=10 --tanzu-kubernetes-cluster-namespace $tdmcControlPlaneVCNamespace$  --tanzu-kubernetes-cluster-name $tdmcControlPlaneTKGClusterName$ 
kubectl config use-context $tdmcControlPlaneTKGClusterName$
```

Launch the Tanzu Data Mangement Console Control Plane installation in this cluster:

```
tdmc-installer install -f ./generated/tdmc-config-generated.yaml
```

Configure DNS records and/or DNS delegation for **$tdmcBaseDomain$** with the details provided at the end of the installation

Then access the TDMC GUI at this URL:

[https://tdmc-cp-tdmc.$tdmcBaseDomain$/](https://tdmc-cp-tdmc.$tdmcBaseDomain$/)



- **Username:** $tdmcSreLoginUsername$

- **Password:** $tdmcSreLoginPassword$




TDMC Data Plane Creation
-----------

To create a data plane go to "Infrastruture" "Cloud Provider Accounts", Click "Add Cloud Provider Acount", Select "TKGS" as provider and use these credentials


```
{
  "userName":"$vcenterUsername$",
  "password":"$vcenterPassword$",
  "supervisorManagementIP":"$supervisorIp$",
  "vsphereNamespace":"$tdmcDataPlaneVCNamespace$"
}
```
Go to "Infrastructure" "Data Planes", Click "Create New Data Plane" 
- Select "TKGS" as Cloud Provider
- Select your newly created Cloud Provider Account
- Select your $tdmcDataPlaneTKGClusterName$ VKS cluster
- Complete the remaining information and create the data plane


### Uninstall

To uninstall the TDMC Controle Plane, switch to the TDMC Control Plane VKS vSphere Namespace context and run:

```
tdmc-installer delete -f ./generated/tdmc-config-generated.yaml
```




Links
-------

Tanzu Data Management Console documentation\
https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-data-management-console/1-0/tdmc/index.html




