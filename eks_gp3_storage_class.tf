resource "kubernetes_storage_class_v1" "ebs" {
  metadata {
    name = "ebs-storage"

    labels = {
      Component = "storage"
    }
  }

  storage_provisioner = "ebs.csi.aws.com"
  volume_binding_mode = "WaitForFirstConsumer"

  allow_volume_expansion = true
  reclaim_policy         = "Delete"

  parameters = {
    type      = "gp3"
    encrypted = "true"
  }
}