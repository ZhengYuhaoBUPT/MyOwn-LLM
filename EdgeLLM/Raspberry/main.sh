curl -fsSL https://ollama.com/install.sh | sh

ollama run gemma2:2b

# 重新烧录后需要运行
ssh-keygen -R 192.168.1.14
