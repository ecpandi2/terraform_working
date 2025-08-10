resource "kubernetes_ingress_v1" "ingress_flink" {
  metadata {
    name      = "ingress-flink"
    namespace = "flink"
    annotations = {
      "alb.ingress.kubernetes.io/certificate-arn"                  = "${aws_acm_certificate.acm_cert.arn}" 
      "alb.ingress.kubernetes.io/healthcheck-interval-seconds"     = "15"
      "alb.ingress.kubernetes.io/healthcheck-port"                 = "traffic-port"
      "alb.ingress.kubernetes.io/healthcheck-protocol"             = "HTTP"
      "alb.ingress.kubernetes.io/healthcheck-timeout-seconds"      = "5"
      "alb.ingress.kubernetes.io/healthy-threshold-count"          = "2"
      "alb.ingress.kubernetes.io/listen-ports"                     = "[{\"HTTPS\":443},{\"HTTP\":80}]"
      "alb.ingress.kubernetes.io/load-balancer-name"               = "ingress-flink"
      "alb.ingress.kubernetes.io/scheme"                           = "internet-facing"
      "alb.ingress.kubernetes.io/ssl-redirect"                     = "443"
      "alb.ingress.kubernetes.io/success-codes"                    = "200"
      "alb.ingress.kubernetes.io/unhealthy-threshold-count"        = "2"
      "external-dns.alpha.kubernetes.io/hostname"                  = "flink1.992382546373.realhandsonlabs.net, flink2.992382546373.realhandsonlabs.net"
    }

    labels = {} # optional, you can add if needed
  }

  spec {
    ingress_class_name = "my-aws-ingress-class"

    default_backend {
      service {
        name = "flink-jobmanager"

        port {
          number = 8081
        }
      }
    }
  }
}
