resource "kubernetes_ingress_v1" "elasticsearch_ingress" {
  metadata {
    name      = "ingress-elasticsearch"
    namespace = "default"

    annotations = {
      "alb.ingress.kubernetes.io/certificate-arn"            = "${aws_acm_certificate.acm_cert.arn}"  
      "alb.ingress.kubernetes.io/healthcheck-interval-seconds" = "15"
      "alb.ingress.kubernetes.io/healthcheck-port"           = "traffic-port"
      "alb.ingress.kubernetes.io/healthcheck-protocol"       = "HTTP"
      "alb.ingress.kubernetes.io/backend-protocol"         =  "HTTPS"
      "alb.ingress.kubernetes.io/healthcheck-path" =  "/"
      "alb.ingress.kubernetes.io/healthcheck-timeout-seconds" = "5"
      "alb.ingress.kubernetes.io/healthy-threshold-count"    = "2"
      "alb.ingress.kubernetes.io/listen-ports"               = "[{\"HTTPS\":443},{\"HTTP\":80}]"
      "alb.ingress.kubernetes.io/load-balancer-name"         = "ingress-elasticsearch"
      "alb.ingress.kubernetes.io/scheme"                     = "internet-facing"
      "alb.ingress.kubernetes.io/ssl-redirect"               = "443"
      "alb.ingress.kubernetes.io/success-codes"              = "401"
      "alb.ingress.kubernetes.io/unhealthy-threshold-count"  = "2"
      "external-dns.alpha.kubernetes.io/hostname"            = "elastic1.533267367927.realhandsonlabs.net, elastic2.533267367927.realhandsonlabs.net"
    }

#    finalizers = ["ingress.k8s.aws/resources"]
  }

  spec {
    ingress_class_name = "my-aws-ingress-class"

    default_backend {
      service {
        name = "elasticsearch-master"

        port {
          number = 9200
        }
      }
    }
  }
}
