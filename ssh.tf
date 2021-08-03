resource "hcloud_ssh_key" "default" {
  name       = "nuc"
  public_key = file("~/.ssh/id_rsa.pub")
}