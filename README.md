# gcp-cloud-vpn

# Terraform Google VPN 

This terraform plan can be used to deploy a Google Classic VPN with IPSec IKEv1.

# Usage 
Simply by running:
```
$ terraform plan

$ terraform apply
```

You will need to specify the `region`, the `gcp_project`, the `host_peer_ip` and the `prefix` for the resources.

If you want to get the `peer_ip` of your machine automatically use the following:


```
terraform plan -var "host_peer_ip=$(curl -s 'https://api.ipify.org?format=json' | jq -r '.ip')"
```

To destroy the deployment you can do a `terraform destroy`