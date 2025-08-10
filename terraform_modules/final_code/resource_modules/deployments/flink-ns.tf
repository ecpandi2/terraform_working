resource "kubernetes_namespace" "flink" {
  metadata {
    name = "flink"
  }
}
