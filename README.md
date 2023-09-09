# spark-on-k8s-playground

Reference: <https://spark.apache.org/docs/latest/running-on-kubernetes.html>

## Prereq

```bash
brew install temurin
brew install apache-spark
```

## Create K8S Service Account

```bash
kubectl create namespace spark
kubectl create serviceaccount spark --namespace spark
kubectl create clusterrolebinding spark-role --clusterrole=edit --serviceaccount=spark:spark --namespace=spark
```

## Usage

If encounter `To use support for EC Keys` error: <https://stackoverflow.com/questions/75796747/spark-submit-error-to-use-support-for-ec-keys-you-must-explicitly-add-this-depe>

```bash
spark-submit \
--master k8s://https://fringe-division:6443 \
--deploy-mode cluster \
--name spark-pi \
--conf spark.kubernetes.namespace=spark \
--conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
--conf spark.executor.instances=3 \
--conf spark.kubernetes.driver.request.cores=2 \
--conf spark.kubernetes.driver.request.memory=1G \
--conf spark.kubernetes.executor.request.cores=2 \
--conf spark.kubernetes.executor.request.memory=1G \
--conf spark.kubernetes.container.image=spark:3.4.1 \
local:///opt/spark/examples/src/main/python/pi.py
```

### Build spark app image

```bash
docker build -t registry.karnwong.me/spark/app:latest .
docker push registry.karnwong.me/spark/app:latest
```

```bash
spark-submit \
--master k8s://https://fringe-division:6443 \
--deploy-mode cluster \
--name spark-pi \
--conf spark.kubernetes.namespace=spark \
--conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
--conf spark.kubernetes.container.image.pullSecrets=harbor-cfg \
--conf spark.executor.instances=5 \
--conf spark.kubernetes.container.image=registry.karnwong.me/spark/app:latest \
local:///app/examples/pi.py
```

### With JARs

```bash
spark-submit \
--master k8s://https://fringe-division:6443 \
--deploy-mode cluster \
--name spark-pi \
--conf spark.kubernetes.namespace=spark \
--conf spark.executor.instances=3 \
--conf spark.kubernetes.driver.request.cores=2 \
--conf spark.kubernetes.driver.request.memory=1G \
--conf spark.kubernetes.executor.request.cores=2 \
--conf spark.kubernetes.executor.request.memory=1G \
--conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
--conf spark.kubernetes.container.image.pullSecrets=harbor-cfg \
--conf spark.kubernetes.container.image.pullPolicy=Always \
--conf spark.kubernetes.container.image=registry.karnwong.me/spark/app:latest \
--conf spark.kubernetes.driver.secretKeyRef.AWS_ACCESS_KEY_ID=aws:AWS_ACCESS_KEY_ID \
--conf spark.kubernetes.driver.secretKeyRef.AWS_SECRET_ACCESS_KEY=aws:AWS_SECRET_ACCESS_KEY \
--conf spark.kubernetes.executor.secretKeyRef.AWS_ACCESS_KEY_ID=aws:AWS_ACCESS_KEY_ID \
--conf spark.kubernetes.executor.secretKeyRef.AWS_SECRET_ACCESS_KEY=aws:AWS_SECRET_ACCESS_KEY \
--packages org.apache.hadoop:hadoop-aws:3.3.4 \
--conf spark.driver.extraJavaOptions="-Divy.cache.dir=/tmp -Divy.home=/tmp" \
local:///app/examples/pi.py
```

## Useful commands

```bash
kubectl create secret generic my-secret --from-literal=key1=value1 --from-literal=key2=value2

kubectl create secret docker-registry regcred --docker-server=<your-registry-server> --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>
```

## TODO

- [ ] set pod template for spot instances: <https://spark.apache.org/docs/latest/running-on-kubernetes.html#pod-template>
