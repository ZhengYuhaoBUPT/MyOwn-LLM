# Run a large language model on your Raspberry Pi

From [Raspberry Pi Foundation](https://projects.raspberrypi.org/en/projects/llm-rpi/4)

We need to split the LLM in the edge. For the reason that we need Cloud-Edge collaborative, we use Docker for Kubernetes (kind) to deploy the LLM on both cloud and the edge.

## 🔹Solution: Deploy Kubernetes (Control Plane) Using Containerization on the L40

Running a Containerized Kubernetes Cluster (Local Isolated Environment). We can use kind (Kubernetes in Docker) to launch a Kubernetes cluster. Essentially, they run Kubernetes in Docker containers, isolated from the host machine and preventing contamination of the host environment.

kind is the most widely used, while k3d is more lightweight (based on k3s).

```
# Install kind
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.24.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Create a local cluster
kind create cluster --name mycluster
```

This will start a master node in Docker on the L40. You can verify this by running
```
kubectl get nodes
```
---

