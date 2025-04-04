## Autogenerating Helm Chart Documentation with `helm-docs`

The documentation for the Prism Helm charts in `charts/prism/README.md` is generated automatically using `helm-docs`. It extracts metadata and values from `Chart.yaml` and `values.yaml`. If you make changes to the charts, you need to update the documentation accordingly.

### **Prerequisites**

Before you begin, ensure you have `helm-docs` installed on your machine. If not, follow these steps:

1. **Install `helm-docs`**

   The easiest way to install `helm-docs` is by using the `go` command:

   ```bash
   go install github.com/norwoodj/helm-docs/cmd/helm-docs@latest
   ```

   If you don't have Go installed, follow the [Go installation guide](https://golang.org/doc/install).

2. **Navigate to Your Project Directory**

   Navigate to the root directory where the Helm charts are stored. For this project, it would be:

   ```bash
   cd devops
   ```

3. **Run the `helm-docs` Command**

   Generate or update the Helm chart documentation by running:

   ```bash
   helm-docs
   ```

   This command will parse through the charts in the `charts` directory and update the `charts/prism/README.md` file to reflect the latest chart metadata and values.

   Note: The output you’ll see may vary, but a successful run typically looks something like this:

   ```bash
    INFO[2024-09-11T11:34:20+03:00] Found Chart directories [charts/prism]
    INFO[2024-09-11T11:34:20+03:00] Generating README Documentation for chart charts/prism
   ```

4. **Review, Commit, and Push Your Changes**

   After `helm-docs` has updated the documentation, review the changes to ensure everything looks correct. Then, commit the changes to your Git repository:

   ```bash
   git add charts/prism/README.md
   git commit -m "Update Helm chart documentation"
   git push origin <your-branch>
   ```

   Replace `<your-branch>` with the name of the branch you’re working on.

# Managing Prism in K8s

## 1. Namespace Management

### Verify if a Namespace Exists

To check if a namespace exists, run:

```bash
kubectl get namespaces
```

### Create a Namespace

To create a namespace if it does not exist:

```bash
kubectl create namespace <namespace-name>
```

## 2. Deleting Resources

### Delete an Entire Namespace (Including All Resources)

```bash
kubectl delete namespace <namespace-name>
```

### Delete All Resources in a Specific Namespace

```bash
kubectl delete all --all -n <namespace-name>
```

### Delete All Pods in a Namespace

```bash
kubectl delete pods --all -n <namespace-name>
```

### Delete Persistent Volumes (PVs) and Persistent Volume Claims (PVCs)

#### Delete All PVs

```bash
kubectl delete pv --all
```

#### Delete All PVCs in a Namespace

```bash
kubectl delete pvc --all -n <namespace-name>
```

## 3. Helm Release Management

### Install a Prism Release

```bash
helm install <release-name> ./charts/prism -n <namespace-name>
```

### Upgrade an Existing Helm Release

```bash
helm upgrade <release-name> ./charts/prism -n <namespace-name>
```

### Uninstall a Helm Release

```bash
helm uninstall <release-name> -n <namespace-name>
```

### List Installed Helm Releases in a Namespace

```bash
helm list -n <namespace-name>
```

### Roll Back to a Previous Helm Release Version

```bash
helm rollback <release-name> <revision-number> -n <namespace-name>
```

## 6. Troubleshooting and Debugging

### Check Helm Release Status

```bash
helm status <release-name> -n <namespace-name>
```

### Check Kubernetes Pods

```bash
kubectl get pods
```

### Get Logs from a Pod

```bash
kubectl logs <pod-name>
```

### Describe a Pod for Debugging

```bash
kubectl describe pod <pod-name>
```

### Check Events in a Namespace

```bash
kubectl get events -n <namespace-name>
```

## Installing prism helm charts

Install Vertical Pod Autoscaler CRDs.

```bash
git clone https://github.com/kubernetes/autoscaler.git
cd autoscaler/vertical-pod-autoscaler
./hack/vpa-down.sh
./hack/vpa-up.sh
```

Create the namespace

```bash
kubectl create namespace prism
```

Create the k8s secret for github registry auth token

```bash
kubectl create secret docker-registry ghcr-secret \
--docker-server=ghcr.io \
--docker-username=<user_name> \
--docker-password=<ghcr_token> \
--docker-email=<email> \
--namespace=prism
```

Install releases as needed.

```bash
helm install prism ./charts/prism -n prism
```

In case you run into this error: `Error: INSTALLATION FAILED: cannot re-use a name that is still in use`,
uninstall existing release and then reinstall. Or upgrade the release.

```bash
helm uninstall <release-name> -n <namespace>
```

```bash
helm upgrade <release-name> ./charts/prism -n <namespace>
```

Forward ports and navigate to `dev.prism.ultraviolet.rs:8000` to test the deployment.

```bash
kubectl port-forward --address 0.0.0.0 service/<release-name>-traefik 80:80 8080:8080 443:443 -n prism;
```

You may need to update permissions for the privileged ports 80 and 443.

```bash
sudo setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/kubectl
```

Use kubectl to inspect resources and logs in the deployment. Alternatively you can set up rancher and import the cluster if you'd like to use ui instead.

## Inspecting the release through Kubernetes Dashboard

The file `kubernetes-dashboard-service-account.yaml` defines the service account, secret and cluster role binding resources necessary for accessing the deployment release via kubernetes dashboard.
This Creates a Service Account that is needed for authenticating into the dashboard. You'll need to generate a token for this account.

The Kubernetes Dashboard charts are bundled and install together with prism charts.

After installing the charts, forward system ports as shown below:
```bash
kubectl port-forward --address 0.0.0.0 service/prism-staging-traefik 80:80 8080:8080 9200:9200 443:443 9090:9090 3030:3030 -n staging
```

Now we need to find the token that we can use to log in.

```bash
kubectl -n <namespace> create token admin-user
```

It should print something like:

```bash
eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlcm5ldGVzLWRhc2hib2FyZCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJhZG1pbi11c2VyLXRva2VuLXY1N253Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImFkbWluLXVzZXIiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiIwMzAzMjQzYy00MDQwLTRhNTgtOGE0Ny04NDllZTliYTc5YzEiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZXJuZXRlcy1kYXNoYm9hcmQ6YWRtaW4tdXNlciJ9.Z2JrQlitASVwWbc-s6deLRFVk5DWD3P_vjUFXsqVSY10pbjFLG4njoZwh8p3tLxnX_VBsr7_6bwxhWSYChp9hwxznemD5x5HLtjb16kI9Z7yFWLtohzkTwuFbqmQaMoget_nYcQBUC5fDmBHRfFvNKePh_vSSb2h_aYXa8GV5AcfPQpY7r461itme1EXHQJqv-SN-zUnguDguCTjD80pFZ_CmnSE1z9QdMHPB8hoB4V68gtswR1VLa6mSYdgPwCHauuOobojALSaMc3RH7MmFUumAgguhqAkX3Omqd3rJbYOMRuMjhANqd08piDC3aIabINX6gP5-Tuuw2svnV6NYQ
```

Log In to Dashboard: Access the URL in your local web browser at https://127.0.0.1:9200/, and log in using the token you generated for your service account. You may encounter a certificate warning, so make sure to override it.

Explore and Manage: You'll now have access to the Kubernetes Dashboard's intuitive interface. From here, you can explore your cluster's resources, view pod details, manage deployments, and monitor the health of your cluster.


## Prism Deployment Strategy

Prism uses environment-specific pull deployment strategy using ArgoCD to ensure smooth updates while minimizing downtime and risks associated with new releases.
For a new release simply update the Prism Charts Repo for example with version number for a deployment and argo will sync the change inside the cluster.

### **Production Environment – Canary Deployment**
For production deployments, **Canary Strategy** is used in order to minimize downtime and provide seamless updates. 
Rolling deployment is used for the following reasons:
- **High availability** – Users do not experience downtime since at least some pods remain operational at all times.
- **Incremental rollout** – If an issue is detected in the new version, the deployment can be paused or rolled back before it affects all users.

### **Managing Rollouts**
Prism helm charts use Argo Rollout to manage the strategies mentioned above.
The Argo Rollout dashboard is routed through traefik ingress routes and can be accessed at https://localhost:3100.

```bash
kubectl port-forward --address 0.0.0.0 service/<release-name>-traefik 80:80 8080:8080 9200:9200 443:443 9090:9090 3000:3000 3100:3100-n <namespace>
```

### **Deployment With ArgoCD**

#### Installation
To install ArgoCD in the cluster run the following command:

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
This will create a new namespace, `argocd`, where Argo CD services and application resources will live.
The installation manifests include ClusterRoleBinding resources that reference `argocd` namespace. 
If you are installing Argo CD into a different namespace then make sure to update the namespace reference.   

```bash
kubectl create namespace argo-rollouts
kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml
```

Apply the ArgoCD configuration file `./charts/prism/templates/argocd.yaml`

```bash
kubectl apply -f ./charts/prism/templates/argocd.yaml;
```

To access the ArgoCD UI forward the ports after installing the charts because traefik ingress is set to route traffic to the ArgoCD ui service.

```bash
kubectl port-forward --address 0.0.0.0 service/<release-name>-traefik 80:80 8080:8080 9200:9200 443:443 9090:9090 3000:3000 8085:8085 -n staging
```

To get initial login credentials:
```bash
kubectl get secret -n argocd argocd-initial-admin-secret -o yaml
```
To decode the password:

```bash
echo <password> | base64 --decode
```

Access the URL in your web browser at https://127.0.0.1:8085/, and log in using the credentials.

```bash
kubectl apply -f ./charts/prism/templates/argocd.yaml
```

### **Rollback Strategy**
To handle unexpected failures or issues during deployment, a **rollback strategy** is implemented within ArgoCD. Simply revert the last commit for the respective environment. 
This ensures that if a deployment fails at any stage, the system can automatically revert to the last stable version.

Rollback also be done on the argo ui by clicking on the History and Rollback button, allowing you to access previous deployments and view all the syncs that Argo has performed. 
This screen provides an option to restore an older version, which can be useful if a deployment introduces a bug. 
By rolling back to a previous version, you can avoid pushing a fix until the issue has been resolved.

---
## Monitoring 
For monitoring, we use the  kube-prometheus-stack which is meant for cluster monitoring, so it is pre-configured to collect metrics from all Kubernetes components. 
In addition to that it delivers a default set of dashboards and alerting rules. 
Many of the useful dashboards and alerts come from the kubernetes-mixin project.

The kube-prometheus-stack consists of three main components:
1. **Prometheus Operator**, for spinning up and managing Prometheus instances in your DOKS cluster.
2. **Grafana**, for visualizing metrics and plot data using stunning dashboards.
3. **Alertmanager**, for configuring various notifications (e.g. PagerDuty, Slack, email, etc) based on various alerts received from the Prometheus main server

### Accessing Prometheus Web Panel
You can access Prometheus web console by port forwarding the kube-prometheus-stack-prometheus service:
```bash 
kubectl port-forward --address 0.0.0.0 service/<release-name>-traefik 80:80 8080:8080 9200:9200 443:443 9090:9090 3030:3030 -n <namespace>
```
Next, launch a web browser of your choice, and enter the following URL: https://localhost:9090. To see what targets were discovered by Prometheus, please navigate to http://localhost:9090/targets.

### Accessing Grafana Web Panel
You can connect to Grafana (default credentials: admin/prom-operator), by port forwarding the kube-prometheus-stack-grafana service:

```bash 
kubectl port-forward --address 0.0.0.0 service/<release-name>-traefik 80:80 8080:8080 9200:9200 443:443 9090:9090 3000:3000 -n <namespace>
```
Next, launch a web browser of your choice, and enter the following URL: https://localhost:3000. 
You can take a look around, and see what dashboards are available for you to use from the kubernetes-mixin project as an example, by navigating to the following URL: http://localhost:3000/dashboards?tag=kubernetes-mixin.

Auth credentials for grafana can be found in  `charts/prims/values.yaml`.
              
![Grafana Dashboard](img/grafana.png)
---
