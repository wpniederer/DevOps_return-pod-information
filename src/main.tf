// resource "null_resource" "start-minikube" {
//  provisioner "local-exec" {
//    command = "minikube start"
// }

//  provisioner "local-exec" {
//    command = "minikube ip > minikube-ip.txt"
// }
// }

data "local_file" "minikube-ip" {
  filename = "../config_files/minikube-ip.txt"
}

provider "kubernetes" {
  config_context_cluster = "minikube"
}
resource "kubernetes_deployment" "pod-details-app" {
  metadata {
    name = "return-pod-details"
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "pod-details-app"
      }
    }
    template {
      metadata {
        labels = {
          App = "pod-details-app"
        }
      }
      spec {
        container {
          image = "nginx"
          name  = "placeholder_app"

          port {
            container_port = 80
          }

          resources {
            limits {
              cpu    = "0.1"
              memory = "128Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "pod-details-app-lb" {
  metadata {
    name = "pod-details-lb"
  }
  spec {
    selector = {
      App = "pod-details-app"
    }
    port {
      port        = 80
      target_port = 80
    }

    type         = "LoadBalancer"
    external_ips = [chomp(data.local_file.minikube-ip.content)]
  }
}

output "lb_ip" {
  value = kubernetes_service.pod-details-app-lb.load_balancer_ingress[0].ip
}
