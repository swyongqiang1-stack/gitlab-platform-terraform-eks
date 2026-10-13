resource "kubernetes_storage_class_v1" "ebs" {
  metadata {
    name = "ebs-storage"
    labels = {
      Component = "storage"
    }
  }
  storage_provisioner = "ebs.csi.amazonaws.com"
  volume_binding_mode = "WaitForFirstConsumer"

  parameters = {
    type      = "gp3"
    encrypted = "true"
  }
}


