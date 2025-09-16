## 🔑 边缘计算场景下 Kubernetes 学习重点

### 1️⃣ 资源管理

* **StatefulSet** ⭐⭐（重要性：中）

  * 边缘节点上如果你要跑数据库、消息队列（Kafka、MQTT）、协调组件（etcd、ZK），就必须用。
  * 如果你主要跑推理服务、API 之类的无状态任务，那重点还是 Deployment。
* **Job / CronJob** ⭐⭐⭐（重要性：高）

  * 边缘计算场景里，经常有 **周期性任务**（如数据收集、模型更新、批量推理），CronJob 非常常用。
  * Job 用于一次性离线任务（比如更新边缘缓存、做数据清洗）。
* **ConfigMap / Secret 高级用法** ⭐⭐⭐⭐（重要性：很高）

  * 模型参数、服务配置、访问凭证（API Key、数据库密码）在边缘场景里变化频繁，必须会用。
  * 特别是 Secret（敏感信息分发），在边缘环境下更关键。

👉 **总结**：Job、CronJob、ConfigMap/Secret 要深入；StatefulSet 看你是否跑有状态服务。

---

### 2️⃣ 网络

* **CNI 插件** ⭐⭐⭐⭐（很高）

  * 边缘节点网络环境复杂，很多时候不在一个局域网，跨地域通信要依赖不同的 CNI 插件（Flannel、Calico、Cilium）。
  * 边缘计算对 **低延迟** 有要求，你需要理解 CNI 性能差异。
* **Service 类型** ⭐⭐⭐⭐（很高）

  * Edge 常见的是 NodePort、LoadBalancer（在云上）、ClusterIP + Ingress。
  * 你需要知道边缘节点怎样暴露服务给外部设备（例如 IoT 设备）。
* **Ingress 控制器** ⭐⭐⭐（中等）

  * 如果你有很多微服务要在边缘集群里暴露，Ingress 很有用（路由、TLS、域名）。
  * 但如果只是少量 API 服务，NodePort/LoadBalancer 也能搞定。

👉 **总结**：CNI 和 Service 必须深入；Ingress 根据业务复杂度决定。

---

### 3️⃣ 存储

* **PV / PVC / StorageClass** ⭐⭐⭐⭐（很高）

  * 边缘应用经常需要存数据（缓存、模型文件、传感器数据），必须理解 PVC/PV/SC。
* **存储解决方案（GlusterFS、NFS）** ⭐⭐⭐（中）

  * 边缘环境带宽有限，不像云端能随便用 Ceph。
  * NFS、轻量分布式存储（Longhorn、OpenEBS）在边缘更常见。

👉 **总结**：PVC/PV/SC 一定要掌握；存储方案可以先了解 NFS，后续再看更复杂的。

---

### 4️⃣ 监控与日志

* **Prometheus** ⭐⭐⭐⭐（很高）

  * 边缘计算对性能敏感，需要监控 CPU/GPU/内存/带宽。
* **Grafana** ⭐⭐⭐⭐（很高）

  * 可视化监控结果，方便定位问题。
* **ELK Stack** ⭐⭐（次要）

  * ELK 很重，在边缘环境部署可能成本高，除非你做边缘侧日志聚合，否则掌握基本概念即可。

👉 **总结**：Prometheus + Grafana 必须会；ELK 先了解。

---

## 🎯 总体优先级（结合边缘计算）

### 必须深入掌握（核心）

* **Job / CronJob**
* **ConfigMap / Secret**
* **CNI 插件**
* **Service 类型**
* **PVC / PV / StorageClass**
* **Prometheus + Grafana**

### 了解即可（辅助）

* StatefulSet（除非你要跑有状态数据库）
* Ingress 控制器（看业务复杂度）
* GlusterFS、NFS（先从 NFS 开始）
* ELK（了解概念即可）

---

👉 总结一句话：
**边缘计算更偏向无状态推理 + 周期性任务调度 + 轻量存储 + 强监控**，所以网络、存储、任务编排和监控是重点。

要不要我帮你整理一份 **“边缘计算专属的 Kubernetes 学习路径图”**，按阶段告诉你学哪个、学到什么深度？
