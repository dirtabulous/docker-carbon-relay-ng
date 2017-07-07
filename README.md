# Carbon-Relay-NG to hosted Grafana, docker image

[![Docker Repository on Quay](https://quay.io/repository/adfin/k8-carbon-replay-ng/status "Docker Repository on Quay")](https://quay.io/repository/adfin/k8-carbon-replay-ng)

This is a container for [Carbon-Relay-NG](https://github.com/graphite-ng/carbon-relay-ng) setup to submit data to [Grafana Cloud](https://grafana.com/cloud). It can be deployed ontop of Docker, Kubernetes. Kubernetes cluster metrics can be submitted to Grafana cloud from [Heapster](https://github.com/kubernetes/heapster). 

# Docker container
The docker container need to be setup using environment variables.

* **GRAFANA_METRIC_URL** - URL to hosted Graphite/Grafana (ex. `https://XXXX.hosted-metrics.grafana.net/metrics`)
* **GRAFANA_API_KEY** - API key for access to endpoint

The container can be pulled by the following command.
```sh
$ docker pull quay.io/adfin/k8-carbon-replay-ng:latest
```

# Deploying to Kubernetes
Carbon-Relay-NG in Kubernetes is setup using a [K8 Secret](https://kubernetes.io/docs/concepts/configuration/secret/). 

Example secret configuration file:
```yaml
apiVersion: v1
metadata:
  name: grafana
  namespace: default
kind: Secret
type: Opaque
data:
  metric-url: $(YOUR_METRIC_URL_BASE64_ENC)
  api-key: $(YOUR_API_KEY_BASE64_ENC)
```

The command submit the secret to the K8 cluster is:
```sh
$ kubectl apply -f kubernetes/hosted-graphite-secret.yaml
````


Once the secret is setup you can deploy the carbon-relay-ng.
```sh
$ kubectl apply -f kubernetes/graphite-proxy.yaml
```

### Heapster metrics
Finally, here is an example standalone heapster [configuration](https://github.com/adfin/docker-carbon-replay-ng/blob/master/kubernetes/heapster-grafana.yaml). This instance will collect K8 cluster metrics and route them to hosted graphite via the Carbon-Relay-NG instance.
```sh
kubectl apply -f kubernetes/heapster-grafana.yaml
```

