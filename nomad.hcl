datacenter = "dc1"
data_dir   = "/opt/nomad"
bind_addr  = "172.18.245.202"

server {
  enabled          = true
  bootstrap_expect = 1
}

client {
  enabled = true
  servers = ["172.18.245.202:4647"]
}

consul {
  address = "172.18.245.202:8500"
}

ui {
  enabled = true
}
