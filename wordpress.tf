provider "kubernetes" {
 config_context_cluster = "minikube"
}
resource "kubernetes_deployment" "wordpress" {
 metadata {
  name = "wp"
 
}
spec {
 replicas = 2
 selector {
  match_labels = {
   env = "development"
   region = "IN"
   App = "wordpress"
  }
  match_expressions {
   key = "env"
   operator = "In"
   values = ["development" , "webserver"]
  }
            
 }
  
 template {
  metadata {
   labels = {
    env = "development"
    region = "IN"
    App = "wordpress"
    
}
   }
   spec {
    container {
     image = "wordpress:4.8-apache"
     name = "wordpressdb"
    }
   }
  }
 }
}
resource "kubernetes_service" "wordpresslb" {
 metadata {
  name = "wplb"
 }
 spec {
  selector = {
   app = "wordpress"
  }
  port {
   node_port = 32145
   port = 80
   target_port = 80
  }
  type = "NodePort"
 }
