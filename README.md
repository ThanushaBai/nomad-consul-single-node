# Nomad & Consul Single-Node Infrastructure

This repository contains the configuration files and documentation to deploy HashiCorp Nomad and Consul on a single machine (tested on WSL2/Ubuntu). 

## Architecture
- **Nomad**: Acts as both Server and Client (Single-node).
- **Consul**: Acts as a single-node server with UI enabled.
- **Integration**: Nomad is configured to auto-register with Consul using the `consul` block.

## Prerequisites & Installation
Install HashiCorp tools via the official APT repository:
```bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update && sudo apt-get install -y consul nomad
Deployment Steps
Apply WSL2 Workaround (If applicable):

bash
sudo mkdir -p /lib/modules/$(uname -r)/
echo '_/bridge.ko' | sudo tee -a /lib/modules/$(uname -r)/modules.builtin
Copy Configs:

bash
sudo cp consul.hcl /etc/consul.d/consul.hcl
sudo cp nomad.hcl /etc/nomad.d/nomad.hcl
Start Services:

bash
sudo mkdir -p /opt/consul /opt/nomad
sudo chown -R consul:consul /opt/consul
sudo chown -R nomad:nomad /opt/nomad
sudo systemctl enable --now consul
sudo systemctl enable --now nomad
Verification
Verify Nomad successfully registered with Consul:

bash
consul catalog services
# Output should include: consul, nomad, nomad-client
Proof of Work (Screenshots)
1. Consul Web UI
The local consul service is passing health checks.
https://screenshots/consul-services.png

The nomad and nomad-client services are registered and passing, explicitly tagged as "Registered via Nomad".
https://screenshots/consul-integration.png

2. Nomad Web UI
The ASUS-X515.global server node is Alive and elected as the cluster Leader.
https://screenshots/nomad-servers.png

The ASUS-X515 client node is Ready and Eligible to receive workloads.
https://screenshots/nomad-clients.png

3. CLI Integration Verification
Terminal command consul catalog services confirming both Nomad server and client are successfully registered.
https://screenshots/terminal-verification.png
