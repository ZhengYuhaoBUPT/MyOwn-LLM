# Qwen-7B 本地部署指南

本文档将指导你如何在本地服务器上部署 [Qwen-7B](https://github.com/QwenLM/Qwen-7B) 模型，并运行一个基础的 Web API 服务。

## 📦 环境准备

```bash
# 安装 Git Large File Storage（用于拉取大模型权重）
# 如果你还未安装 git-lfs，请执行以下命令安装：
sudo apt update
sudo apt install git-lfs -y

# 初始化 git-lfs
git lfs install
```

## 🧱 启动 tmux 会话（可选）

```bash
# 推荐在 tmux 下运行，避免中断
tmux
```

## 🔄 克隆模型代码和权重

```bash
# 克隆 Qwen-7B 模型代码
git clone https://github.com/QwenLM/Qwen-7B.git

# 从 ModelScope 克隆 Qwen-7B-Chat 权重（包含 tokenizer 等配置）
git clone https://www.modelscope.cn/qwen/Qwen-7B-Chat.git qwen-7b-chat
```

## 📦 安装依赖

```bash
# 安装 Qwen-7B 模型所需的依赖
pip install -r ~/Qwen-7B/requirements.txt

# 安装 Qwen-7B-Chat 的额外依赖
pip install -r ~/qwen-7b-chat/requirements.txt
```

⚠️ 安装较慢时建议使用国内镜像：

```bash
# 使用阿里云镜像加速
pip install -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple
```

## 🚀 启动 Web 服务

```bash
# 启动 web_demo.py，指定模型权重路径和监听地址
cd ~/Qwen-7B
python web_demo.py -c ../qwen-7b-chat --server-name 0.0.0.0 --server-port 7860
```

启动成功后，Web API 会运行在：

```
http://<你的服务器IP>:7860
```

---

## ✅ 常见问题

- **git lfs 不是命令？**
  > 请确保执行了 `sudo apt install git-lfs`，并再次运行 `git lfs install`。

- **依赖安装太慢？**
  > 使用国内镜像源，例如清华或阿里云镜像，可大幅提升速度。

---

## 🧠 注意事项

- 默认模型为 Qwen-7B，部署时需预留约 16GB GPU 显存。
- 若使用 CPU 或低显存 GPU，请使用 `--cpu-only` 参数或尝试量化模型。

---

## 🤪 拉取Qwen的Python运行程序

```bash
wget https://raw.githubusercontent.com/ZhengYuhaoBUPT/MyOwn-LLM/main/Qwen/StartQwen.py
```
- 也可以使用batch推理加速
```bash
wget https://raw.githubusercontent.com/ZhengYuhaoBUPT/MyOwn-LLM/main/Qwen/Batch_Inference.py
```

---

## 量化

- 首先安装量化包
pip install auto-gptq optimum
- 从modelscope下载Qwen的Int4量化模型
git clone https://www.modelscope.cn/Qwen/Qwen-7B-Chat-Int4.git

- 修改之前的启动代码
```bash
model = AutoModelForCausalLM.from_pretrained(
    "Qwen/Qwen-7B-Chat-Int4",
    device_map="auto",
    trust_remote_code=True
).eval()
response, history = model.chat(tokenizer, "Hi", history=None)
```

- 可以直接用在github中修改的版本
```bash
wget https://raw.githubusercontent.com/ZhengYuhaoBUPT/MyOwn-LLM/main/Qwen/GPTQ_Batch_Inference.py
```

- 注意版本要求
> torch==2.1 auto-gptq>=0.5.1 transformers>=4.35.0 optimum>=1.14.0 peft>=0.6.1
torch>=2.0,<2.1 auto-gptq<0.5.0 transformers<4.35.0 optimum<1.14.0 peft>=0.5.0,<0.6.0
---


## 📚 参考

- [Qwen-7B GitHub](https://github.com/QwenLM/Qwen-7B)
- [Qwen-7B ModelScope 权重](https://modelscope.cn/models/qwen/Qwen-7B-Chat/summary)
