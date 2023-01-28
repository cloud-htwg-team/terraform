resource "kubernetes_service" "qrhistory" {
  metadata {
        name = "his-cluster-service-${var.namespace}"
        namespace = var.namespace
        labels = {
            maintained_by = "terraform"
            app = kubernetes_deployment.qrhistory.metadata[0].labels.app
            type = kubernetes_deployment.qrhistory.metadata[0].labels.type
        }
  }

  spec {
    selector = {
        maintained_by = "terraform"
        app = kubernetes_deployment.qrhistory.metadata[0].labels.app
        type = kubernetes_deployment.qrhistory.metadata[0].labels.type
    }

    #session_affinity = "ClientIP"

    port {
      port        = 80
      target_port = var.port
    }

    type = "ClusterIP"
  }

  #depends_on = [module.gke]
}

resource "kubernetes_service" "extqrhistory" {
  metadata {
        name = "his-cluster-service-ext"
        namespace = "default"
        labels = {
            maintained_by = "terraform"
            app = kubernetes_deployment.qrhistory.metadata[0].labels.app
            type = kubernetes_deployment.qrhistory.metadata[0].labels.type
        }
  }

  spec {
    selector = {
        maintained_by = "terraform"
        app = kubernetes_deployment.qrhistory.metadata[0].labels.app
        type = kubernetes_deployment.qrhistory.metadata[0].labels.type
    }


    port {
      port        = 80
    }

    type = "ExternalName"
    external_name = "his-cluster-service.${var.namespace}.svc.cluster.local"
  }
}
