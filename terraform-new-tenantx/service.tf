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
      target_port = var.porthis
    }

    type = "ClusterIP"
  }

  #depends_on = [module.gke]
}

resource "kubernetes_service" "qrcode" {
  metadata {
        name = "qr-cluster-service-${var.namespace}"
        namespace = var.namespace
        labels = {
            maintained_by = "terraform"
            app = kubernetes_deployment.qrcode.metadata[0].labels.app
            type = kubernetes_deployment.qrcode.metadata[0].labels.type
        }
  }

  spec {
    selector = {
        maintained_by = "terraform"
        app = kubernetes_deployment.qrcode.metadata[0].labels.app
        type = kubernetes_deployment.qrcode.metadata[0].labels.type
    }

    #session_affinity = "ClientIP"

    port {
      port        = 80
      target_port = var.portqr
    }

    type = "ClusterIP"
  }

  #depends_on = [module.gke]
}

resource "kubernetes_service" "ext_front" {
  metadata {
        name = "front-service-from-${var.namespace}"
        namespace = var.namespace
  }
  spec {
    port {
      port = 80
    }
    type = "ExternalName"
    external_name = "front-cluster-service.default.svc.cluster.local"
  }
}

resource "kubernetes_service" "ext_auth" {
  metadata {
        name = "auth-service-from-${var.namespace}"
        namespace = var.namespace
  }
  spec {
    port {
      port = 80
    }
    type = "ExternalName"
    external_name = "auth-cluster-service.default.svc.cluster.local"
  }
}