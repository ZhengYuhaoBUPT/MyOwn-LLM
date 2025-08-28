# Kubernetes

## 核心概念

- **Pod、Node、Master、Worker**  
- **ReplicationController、Deployment、Service**  
- **ConfigMap、Secret、Ingress**  

### 1. Pod

- **定义**：最小的部署单元，Kubernetes（K8s）里的应用都是以 Pod 为单位运行的。  
- **特性**：一个 Pod 里面可以包含一个或多个容器（通常为 1 个），这些容器共享网络（IP、端口）和存储卷（Volume）。例如，部署一个 Nginx 服务，它会运行在一个 Pod 里。  

### 2. Node

- **定义**：节点，即一台工作机器（物理机或虚拟机）。  
- **分类**：  
  - **Master Node（控制节点）**：负责管理整个集群，调度 Pod、维护状态。  
  - **Worker Node（工作节点）**：负责真正运行 Pod。  

### 3. Master（控制平面）

- **核心组件**：  
  - **API Server**：集群的“入口”，所有请求都通过它进行。  
  - **Scheduler**：负责决定 Pod 运行在哪个 Worker Node 上。  
  - **Controller Manager**：维护集群的期望状态（例如副本数）。  
  - **etcd**：保存集群所有配置和状态。  
- **作用**：可以理解为集群的“大脑”。  

### 4. Worker（工作节点）

- **核心组件**：  
  - **kubelet**：负责和 Master 通信，保证 Pod 按照要求运行。  
  - **kube-proxy**：实现 Pod 的网络转发和负载均衡。  
  - **容器运行时（CRI，例如 Docker、containerd）**：真正运行容器的地方。  
- **作用**：在这里真正运行 Pod。  

### 5. ReplicationController (RC)

- **定义**：早期的副本控制器，保证某个 Pod 始终有指定数量的副本数。  
- **现状**：现在基本上被 Deployment 替代了。  

### 6. Deployment

- **定义**：声明式的 Pod 管理控制器。  
- **功能**：  
  - 你只需要声明：我要运行 3 个 Nginx Pod。  
  - Deployment 会自动保证：  
    - Pod 副本数一致。  
    - Pod 挂了会自动重建。  
    - 支持滚动更新、回滚。  

### 7. Service

- **定义**：Pod 的访问入口（因为 Pod 的 IP 会变，不适合直接访问）。  
- **功能**：  
  - 给一组 Pod 提供一个固定的访问地址（ClusterIP、NodePort、LoadBalancer）。  
  - 还能做负载均衡。  
  - 例如：一个 Nginx Deployment 有 3 个副本，Service 可以统一暴露在一个地址上。  

### 8. ConfigMap

- **定义**：用来存放配置数据（非敏感信息），例如应用的配置文件、环境变量。  
- **使用**：Pod 可以把 ConfigMap 挂载成文件或环境变量使用。  

### 9. Secret

- **定义**：和 ConfigMap 类似，但用于存放敏感信息，比如密码、Token、证书。  
- **特性**：存储时会进行 base64 编码。  

### 10. Ingress

- **定义**：集群外访问 Service 的入口控制器。  
- **功能**：  
  - Service 解决的是“集群内 Pod 的访问问题”，Ingress 解决的是“从集群外访问 Service”的问题。  
  - 它通过 Ingress Controller（如 Nginx Ingress、Traefik）实现 HTTP/HTTPS 路由。  
  - 例如：  
    - www.a.com → 转到 Service A  
    - www.b.com → 转到 Service B  

---

📌 **总结**：

- **Pod** → 应用的最小运行单元。  
- **Node（Worker）** → 运行 Pod 的机器。  
- **Master** → 控制集群的“大脑”。  
- **RC / Deployment** → 确保 Pod 的数量和状态。  
- **Service** → Pod 的统一访问入口。  
- **ConfigMap / Secret** → 应用配置（普通配置 + 敏感配置）。  
- **Ingress** → 提供 HTTP/HTTPS 的外部访问。  

---
