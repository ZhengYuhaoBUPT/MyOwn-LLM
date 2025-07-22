from transformers import AutoTokenizer, AutoModelForCausalLM
import torch

# 加载模型
model_name = "../qwen-7b-chat"
tokenizer = AutoTokenizer.from_pretrained(model_name, trust_remote_code=True)
model = AutoModelForCausalLM.from_pretrained(
    model_name,
    device_map="auto",         # 自动使用GPU
    torch_dtype=torch.float16, # 半精度加速（建议）
    trust_remote_code=True
)
model.eval()

# 推理函数
def generate_answer(query: str) -> str:
    prompt = f"用户：{query}\n助手："
    inputs = tokenizer(prompt, return_tensors="pt").to(model.device)
    outputs = model.generate(**inputs, max_new_tokens=200, do_sample=True, temperature=0.7)
    response = tokenizer.decode(outputs[0], skip_special_tokens=True)
    # 处理掉 prompt 前缀
    return response.split("助手：")[-1].strip()
