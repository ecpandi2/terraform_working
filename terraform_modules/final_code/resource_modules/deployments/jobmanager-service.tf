resource "kubernetes_service" "flink_jobmanager" {
  metadata {
    name      = "flink-jobmanager"
    namespace = "flink"
    labels = {
      app       = "flink"
      component = "jobmanager"
    }
  }

  spec {
    type = "NodePort"

    selector = {
      app       = "flink"
      component = "jobmanager"
    }

    port {
      port        = 6123
      name        = "rpc"
      target_port = 6123
    }

    port {
      port        = 8081
      name        = "web"
      target_port = 8081
    }
  }
}
