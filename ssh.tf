resource "hcloud_ssh_key" "default" {
  name       = "nuc"
  public_key = var.ssh
}
