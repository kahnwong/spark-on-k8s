# spark-on-k8s-playground

Reference: <https://spark.apache.org/docs/latest/running-on-kubernetes.html>

## Prereq

```bash
brew install temurin
brew install apache-spark
```

## Create K8S Service Account

```bash
kubectl create serviceaccount spark
kubectl create clusterrolebinding spark-role --clusterrole=edit --serviceaccount=default:spark --namespace=default
```

## Usage

If encounter `To use support for EC Keys` error: <https://stackoverflow.com/questions/75796747/spark-submit-error-to-use-support-for-ec-keys-you-must-explicitly-add-this-depe>

```bash
spark-submit \
--master k8s://https://fringe-division:6443 \
--deploy-mode cluster \
--name spark-pi \
--conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
--conf spark.executor.instances=5 \
--conf spark.kubernetes.container.image=spark:3.4.1 \
local:///opt/spark/examples/src/main/python/pi.py
```

## Build spark app image

```bash
docker build -t registry.karnwong.me/spark/app:latest .
docker push registry.karnwong.me/spark/app:latest
```

```bash
spark-submit \
--master k8s://https://fringe-division:6443 \
--deploy-mode cluster \
--name spark-pi \
--conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
--conf spark.kubernetes.container.image.pullSecrets=harbor-cfg \
--conf spark.executor.instances=5 \
--conf spark.kubernetes.container.image=registry.karnwong.me/spark/app:latest \
local:///app/examples/pi.py
```
