resource "kubernetes_deployment" "flink_jobmanager" {
  metadata {
    name      = "flink-jobmanager"
    namespace = "flink"
    labels = {
      app       = "flink"
      component = "jobmanager"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app       = "flink"
        component = "jobmanager"
      }
    }

    template {
      metadata {
        labels = {
          app       = "flink"
          component = "jobmanager"
        }
      }

      spec {
        container {
          name  = "jobmanager"
          image = "flink:latest"
          args  = ["jobmanager"]

          port {
            container_port = 6123
            name           = "rpc"
          }

          port {
            container_port = 8081
            name           = "web"
          }

          env {
            name  = "JOB_MANAGER_RPC_ADDRESS"
            value = "flink-jobmanager"
          }
        }
      }
    }
  }
}
