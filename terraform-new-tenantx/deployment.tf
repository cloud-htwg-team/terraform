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
               container_port = var.porthis
            }
        }
    }
    
    }
  }

  #depends_on = [module.gke]
}


resource "kubernetes_deployment" "qrcode" {
  metadata {
    name = "qr-deployment-${var.namespace}"
    namespace = var.namespace

    labels = {
      maintained_by = "terraform"
      app           = "qrcode"
      type  = "qrcode-generator-${var.namespace}"
    }
  }
  spec {
    selector {
      match_labels = {
        maintained_by = "terraform"
        app = "qrcode"
        type = "qrcode-generator-${var.namespace}"
      }
    }
    template {
        metadata {
            labels = {
                maintained_by = "terraform"
                app           = "qrcode"
                type  = "qrcode-generator-${var.namespace}"
            }
        }
      spec{
        container {
            image= "eu.gcr.io/qrcode-374515/qrcode-service"
            name= "qrcode"
            port {
               container_port = var.portqr
            }
        }
    }
    
    }
  }

  #depends_on = [module.gke]
}