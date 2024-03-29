resource "kubernetes_deployment" "qrhistory" {
  metadata {
    name = "his-deployment-${var.namespace}"
    namespace = kubernetes_namespace.tenantx.metadata[0].name

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
        #service_account_name=  "default"
        node_selector={
          "iam.gke.io/gke-metadata-server-enabled"= "true"
        } 
        container {
            image= "eu.gcr.io/qrcode-374515/history-service"
            name= "qrhistory"
            port {
               container_port = var.porthis
            }
        env {
            name = "BUCKET_NAME"
            value = google_storage_bucket.static-site.name
        }
    }
    
    }
  }

  #depends_on = [module.gke]
}
}


resource "kubernetes_deployment" "qrcode" {
  metadata {
    name = "qr-deployment-${var.namespace}"
    namespace = kubernetes_namespace.tenantx.metadata[0].name

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
        #service_account_name=  "default"
        #node_selector={
        #  iam.gke.io/gke-metadata-server-enabled= "true"
        #} 
        container {
            image= "eu.gcr.io/qrcode-374515/qrcode-service"
            name= "qrcode"
            port {
               container_port = var.portqr
            }
        env {
            name = "HISTORY_SERVICE_SERVER"
            value = "his-cluster-service-${var.namespace}"
          }
        env {
            name = "HISTORY_SERVICE_PORT"
            value = "8888"
          }         
                        
        }
    }
    
    }
  }

  #depends_on = [module.gke]
}
