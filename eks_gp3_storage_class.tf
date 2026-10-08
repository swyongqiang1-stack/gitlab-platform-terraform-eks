resource "kubernetes_storage_class_v1" "ebs" {
  metadata {
    name = "ebs-storage"
    labels = {
      Component = "storage"
    }
  }
  storage_provisioner = "ebs.csi.eks.amazonaws.com"
  volume_binding_mode = "WaitForFirstConsumer"
  allowed_topologies {
    match_label_expressions {
      key = eks.amazonaws.com/compute-type
      values = "auto"
    }
  }
  parameters = {
    type = "gp3"
    encrypted = "true"
  }
}


