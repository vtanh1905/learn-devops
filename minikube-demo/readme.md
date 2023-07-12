Document to install minikube https://kubernetes.io/vi/docs/tasks/tools/install-minikube/
1. Install kubectl https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/
2. Install minikube https://github.com/kubernetes/minikube/releases/tag/v1.30.1

To test minikube work
3. run this script to start minikube
/**
  minikube start
*/
4. Create a pod 
/**
  kubectl apply -f nginx.pod.yaml
*/
5. to access this k8s dashboard
/**
  minikube dashboard
*/
