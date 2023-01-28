resource "kubernetes_deployment" "qrhistory" {
  metadata {
    name = "his-deployment-${var.namespace}"
    namespace = var.namespace

    labels = {
      maintained_by = "terraform"
      app           = "qrhistory"
      type  = "qrcode-history-${var.namespace}"
    }
  }
  spec {
    selector {
      match_labels = {
        maintained_by = "terraform"
        app = "qrhistory"
        type = "qrcode-history-${var.namespace}"
      }
    }
    template {
        metadata {
            labels = {
                maintained_by = "terraform"
                app           = "qrhistory"
                type  = "qrcode-history-${var.namespace}"
            }
        }
      spec{
        container {
            image= "eu.gcr.io/qrcode-374515/history-service"
            name= "qrhistory"
            port {
               container_port = var.port
            }
        }
    }
    
    }
  }

  #depends_on = [module.gke]
}
