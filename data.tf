data "hcloud_datacenter" "ds" {
  name = "nbg1-dc3"
}

data "hcloud_image" "ubuntu" {
  id = "15512617"
}


