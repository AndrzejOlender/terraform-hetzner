resource "hcloud_ssh_key" "nuc" {
  name       = "nuc"
  public_key = var.ssh_nuc
}

resource "hcloud_ssh_key" "mac" {
  name       = "mac"
  public_key = var.ssh_mac
}
