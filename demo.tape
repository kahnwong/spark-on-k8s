Type "k3d cluster create spark-cluster --api-port 0.0.0.0:6443"
Sleep 500ms
Enter
Sleep 15s

Type "kubectl get nodes"
Sleep 500ms
Enter
Sleep 2s

Type "kubectl create namespace spark"
Sleep 500ms
Enter
Sleep 2s

Type "echo 'Create a service account for spark'"
Sleep 500ms
Enter
Type "kubectl create serviceaccount spark --namespace spark"
Sleep 500ms
Enter
Type "kubectl create clusterrolebinding spark-role --clusterrole=edit --serviceaccount=spark:spark --namespace=spark"
Sleep 500ms
Enter
Sleep 2s


Type "echo 'Submit a spark job'"
Sleep 500ms
Enter
Type "spark-submit \"
Enter
Type "--master k8s://https://0.0.0.0:6443 \"
Enter
Type "--deploy-mode cluster \"
Enter
Type "--name spark-pi \"
Enter
Type "--conf spark.kubernetes.namespace=spark \"
Enter
Type "--conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \"
Enter
Type "--conf spark.executor.instances=3 \"
Enter
Type "--conf spark.kubernetes.container.image=spark:3.4.1 \"
Enter
Type "local:///opt/spark/examples/src/main/python/pi.py"
Enter
Sleep 80s

# Type "k3d cluster delete spark-cluster"
# Enter
