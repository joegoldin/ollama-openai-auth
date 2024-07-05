# Docker Image for Ollama Service with Basic Auth using Caddy Server

This project provides a Docker image that runs the Ollama service with basic authentication using the Caddy server. The image is designed to be easy to use, with a simple command to get started. The basic authentication credentials can be set using environment variables when running the Docker container.

## Usage:

To use this Docker image, you can run the following command:
```
docker run -p 80:80 -p 443:443 -e DOMAIN=my-domain.com -e EMAIL=john@my-domain.com -e TOKEN=my-token-here ghcr.io/iosifnicolae2/ollama-openai-auth:latest 
```
This will start the Ollama service with basic authentication using the Caddy server. The service will be available at `https://my-domain.com` on the host machine. The OpenAI token authentication credentials will be set to `my-token-here`. Also, there will be provisioned an https certificate for the domain `my-domain.com` using Let's Encrypt.

## Building the Docker Image:

To build the Docker image yourself, you can use the following command:
```
docker build -t ollama-openai-auth .
```
This will build the Docker image using the `Dockerfile` in the current directory, and tag it with the name `ollama-openai-auth`.

## Running the Ollama Service:

The Ollama service is started automatically when the Docker container is launched. It will be available at `https://localhost` on the host machine.

You can access the OpenAI compatible API like below:
```bash
curl https://my-domain.com/v1/chat/completions   -H "Content-Type: application/json"   -H "Authorization: Bearer my-token-here"   -d '{
    "model": "llama2",
    "messages": [
      {
        "role": "system",
        "content": "You are a poetic assistant, skilled in explaining complex programming concepts with creative flair."
      },
      {
        "role": "user",
        "content": "Compose a poem that explains the concept of recursion in programming."
      }
    ]
  }'
  ```
or using OpenAI Python library:
```python
from openai import OpenAI

client = OpenAI(
    base_url = 'https://my-domain.com/v1',
    api_key='my-token-here',
)

response = client.chat.completions.create(
  model="llama2",
  messages=[
    {"role": "system", "content": "You are a helpful assistant."},
    {"role": "user", "content": "Who won the world series in 2020?"},
    {"role": "assistant", "content": "The LA Dodgers won in 2020."},
    {"role": "user", "content": "Where was it played?"}
  ]
)
print(response.choices[0].message.content)
```