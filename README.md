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
helm uninstall prism -n prism
```

```bash
helm upgrade prism ./charts/prism -n prism
```

Forward ports and navigate to `dev.prism.ultraviolet.rs:8000` to test the deployment.

```bash
kubectl port-forward --address 0.0.0.0 service/prism-traefik 80:80 8080:8080 443:443 -n prism;
```

You may need to update permissions for the privileged ports 80 and 443. 
```bash
sudo setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/kubectl
```

Use kubectl to inspect resources and logs in the deployment. Alternatively you can set up rancher and import the cluster if you'd like to use ui instead.

---
