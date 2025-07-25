# 🧠 MyOwn-LLM: Local Multi-Model Deployment & Inference Platform

📍 **MyOwn-LLM** is an experimental platform designed for local deployment and service integration of multiple open-source large language models (LLMs). It aims to explore the inference performance, API service design, and edge adaptation capabilities of LLMs for Chinese semantic tasks.

---

## 🚀 Supported Models

| Model Name        | Parameters | Source/Architecture   | Inference Framework         | Status      |
|------------------|------------|------------------------|-----------------------------|-------------|
| Qwen-7B           | 7B         | Alibaba Qwen           | HuggingFace + Transformers | ✅ Deployed  |
| ChatGLM3-6B       | 6B         | Tsinghua Zhipu         | HuggingFace + PEFT         | 🟡 Planned   |
| LLaMA2-7B         | 7B         | Meta + Chinese Tuning  | PEFT + LoRA                | 🟡 Planned   |
| Baichuan2-13B     | 13B        | Baichuan AI            | Distributed Deployment Exp. | 🔲 Untested |
| InternLM-Chat-7B  | 7B         | Shanghai AI Lab        | 🤖 Multi-turn Dialog Exp.   | 🔲 Pending   |

---

## 🧠 Project Goals

- ✅ Rapid deployment & local inference of multiple Chinese LLMs;
- ✅ Unified API interface for different models to improve scalability;
- ✅ Exploration of lightweight tuning (LoRA, quantization) under various tasks;
- ✅ Support for model performance benchmarking (latency, accuracy, memory usage);
- ❓ Evaluate feasibility of edge/low-resource deployment (e.g., satellite-edge computing);

---

## 🧪 Use Cases

- 💬 Chinese question-answering systems
- 📝 Intelligent summarization & rewriting
- 🤖 Multi-turn dialog construction
- 🔒 Private local deployment & secure Q&A
- 📡 Edge/satellite device deployment experiments

---

## 📌 Example Usage

For usage instructions of each model, refer to the corresponding subdirectory `README.md`. For example:

- [Qwen-7B Instructions](./Qwen/README.md)
- [ChatGLM3-6B Instructions](./chatglm3-6b/README.md) *(in progress)*

---

## 📈 Planned Model Performance Comparison

| Model     | GPU Inference Time (s) | CPU Inference Time (s) | VRAM Usage | Multi-turn Dialog | Fine-tuning Support |
|-----------|------------------------|-------------------------|------------|-------------------|---------------------|
| Qwen-7B   | ✅ Fast                 | ⚠️ Slow                 | 16 GB      | ✅ Supported       | ✅ LoRA             |
| ChatGLM3  | 🔲 TBD                 | 🔲 TBD                 | 🔲 TBD      | 🔲 TBD            | 🔲 TBD              |
| LLaMA2    | 🔲 TBD                 | 🔲 TBD                 | 🔲 TBD      | 🔲 TBD            | ✅ PEFT             |

---

## 📌 TODO Features

- [x] Qwen-7B Inference API Deployment (FastAPI)
- [ ] ChatGLM3 Integration & Evaluation
- [ ] Unified LoRA Fine-tuning Pipeline
- [ ] Gradio / Web UI Integration
- [ ] Model Performance Benchmarking Module
- [ ] Logging System & Multi-user Support
- [ ] LangChain Integration (Agent-based)

---

## 👨‍💻 Author

**Yuhao Zheng**  
M.Sc. in Information and Communication Engineering, Beijing University of Posts and Telecommunications (BUPT)  
Research Interests: Edge Computing, Satellite Networks, Large Language Model Applications  
📫 yuhao_zheng@bupt.edu.cn  
🌐 [GitHub](https://github.com/ZhengYuhaoBUPT)
