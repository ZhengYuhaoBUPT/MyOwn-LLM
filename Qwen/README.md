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

若不想使用web，可以直接在命令行玩qwen-7b-chat：
```bash
wget https://raw.githubusercontent.com/ZhengYuhaoBUPT/MyOwn-LLM/main/Qwen/cli_demo.py
python cli_demo.py
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

## FastAPI
- 使用FastAPI：
```bash
wget https://raw.githubusercontent.com/ZhengYuhaoBUPT/MyOwn-LLM/main/Qwen/qwen_fastapi
cd qwen_fastapi
uvicorn app:app --host 0.0.0.0 --port 8008
```

## 微调
- 使用LoRA对模型进行微调，采用的数据是question_data.json，与卫星边缘计算和边缘推理相关的内容
```bash
wget https://raw.githubusercontent.com/ZhengYuhaoBUPT/MyOwn-LLM/main/Qwen/question_data.json
cd finetune
wget https://raw.githubusercontent.com/ZhengYuhaoBUPT/MyOwn-LLM/main/Qwen/finetune_lora_single_gpu.sh
bash finetune/finetune_lora_single_gpu.sh
```
- 微调结束就可以获得output_qwen文件夹
```bash
# 加载微调chat
wget https://raw.githubusercontent.com/ZhengYuhaoBUPT/MyOwn-LLM/main/Qwen/lora_cli_demo.json
python lora_cli_demo.json
```

- 未经过微调的回答：
- 回答一：
>User: 什么是卫星边缘计算？  
>Qwen-Chat: 卫星边缘计算是一种新兴的技术，它将计算能力放在卫星上，以提供实时的处理能力。它可以帮助用户更快地处理数据，并可以提高系统效率和安全性。它还可以帮助用户在多个位置访问实时信息，从而节省时间和资源。   
>微调后：卫星边缘计算是指将计算任务和数据处理能力部署到距离用户较近的卫星上，以便能够更快地响应用户的请求。它可以减少通信延迟，并提高系统可靠性、可靠性和可用性。   
>我们给的答案：卫星边缘计算是指将计算能力部署在卫星上，使其能够在太空中就地处理数据，减少地面传输延迟。

- 回答二：
>User: 边缘推理在卫星上的作用是什么？   
>Qwen-Chat: 边缘推理在卫星上主要用于识别和分析传感器采集的数据。它可以实现实时分析，为用户提供更准确、可靠的决策支持。此外，边缘推理还可以减少网络传输延迟，加快处理速度，并降低存储成本。   
>微调后：边缘推理可以将原始数据在卫星上进行实时处理，从而实现数据快速分析，为用户提供更加快速的服务。此外，它还可以帮助提升卫星系统整体性能，降低功耗，减轻网络传输负担等。   
>我们给的答案：边缘推理可以在卫星本地快速处理图像、视频等任务，实现智能预警、目标识别等功能，提升响应速度并节省带宽。  


## 📚 参考

- [Qwen-7B GitHub](https://github.com/QwenLM/Qwen-7B)
- [Qwen-7B ModelScope 权重](https://modelscope.cn/models/qwen/Qwen-7B-Chat/summary)
