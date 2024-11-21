# Use uma imagem base do Python
FROM python:3.9-slim

# Defina o diretório de trabalho no contêiner
WORKDIR /app

# Copie os arquivos necessários para o contêiner
COPY . /app

# Instale as dependências da aplicação
RUN pip install --no-cache-dir flask

# Exponha a porta 80
EXPOSE 80

# Comando para iniciar a aplicação no Flask rodando na porta 80
CMD ["python", "-m", "flask", "run", "--host=0.0.0.0", "--port=80"]
