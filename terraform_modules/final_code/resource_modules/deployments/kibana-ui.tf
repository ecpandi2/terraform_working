resource "kubernetes_ingress_v1" "kibana_ingress" {
  metadata {
    name      = "ingress-kibana"
    namespace = "default"

    annotations = {
      "alb.ingress.kubernetes.io/certificate-arn"            = "${aws_acm_certificate.acm_cert.arn}"  
      "alb.ingress.kubernetes.io/healthcheck-interval-seconds" = "15"
      "alb.ingress.kubernetes.io/healthcheck-port"           = "traffic-port"
      "alb.ingress.kubernetes.io/healthcheck-protocol"       = "HTTP"
      "alb.ingress.kubernetes.io/healthcheck-timeout-seconds" = "5"
      "alb.ingress.kubernetes.io/healthy-threshold-count"    = "2"
      "alb.ingress.kubernetes.io/listen-ports"               = "[{\"HTTPS\":443},{\"HTTP\":80}]"
      "alb.ingress.kubernetes.io/load-balancer-name"         = "ingress-kibana"
      "alb.ingress.kubernetes.io/scheme"                     = "internet-facing"
      "alb.ingress.kubernetes.io/ssl-redirect"               = "443"
      "alb.ingress.kubernetes.io/success-codes"              = "200"
      "alb.ingress.kubernetes.io/unhealthy-threshold-count"  = "2"
      "external-dns.alpha.kubernetes.io/hostname"            = "kibanan1.533267367927.realhandsonlabs.net, kibana2.533267367927.realhandsonlabs.net"
    }

#    finalizers = ["ingress.k8s.aws/resources"]
  }

  spec {
    ingress_class_name = "my-aws-ingress-class"

    default_backend {
      service {
        name = "kibana-kibana"

        port {
          number = 5601
        }
      }
    }
  }
}
