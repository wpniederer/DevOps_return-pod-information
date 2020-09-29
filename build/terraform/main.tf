data "local_file" "minikube-ip" {
  filename = "../../config_files/minikube-ip.txt"
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
          image = "wpniederer/return-pod-details-app:latest"
          name  = "pod-details-image"

          port {
            container_port = 8080
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

resource "kubernetes_service" "pod-details-node-port" {
  metadata {
    name = "pod-details-node-port"
  }

  spec {
    selector = {
      App = "pod-details-app"
    }

    port {
      port        = 80
      target_port = 8080
      node_port   = 31111
    }

    session_affinity = "None"
    type             = "NodePort"
    external_ips     = [chomp(data.local_file.minikube-ip.content)]
  }

}

output "node_port_ip" {
  value = kubernetes_service.pod-details-node-port.spec[0].external_ips
}
