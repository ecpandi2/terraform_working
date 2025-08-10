resource "kubernetes_deployment" "flink_taskmanager" {
  metadata {
    name      = "flink-taskmanager"
    namespace = "flink"
    labels = {
      app       = "flink"
      component = "taskmanager"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app       = "flink"
        component = "taskmanager"
      }
    }

    template {
      metadata {
        labels = {
          app       = "flink"
          component = "taskmanager"
        }
      }

      spec {
        container {
          name  = "taskmanager"
          image = "flink:latest"
          args  = ["taskmanager"]

          port {
            container_port = 6121
            name           = "data"
          }

          port {
            container_port = 6122
            name           = "rpc"
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
