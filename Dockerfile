FROM pytorch/pytorch:latest

# Install dependencies
RUN apt-get update && apt-get install -y wget jq curl

RUN wget --no-check-certificate https://github.com/caddyserver/caddy/releases/download/v2.7.6/caddy_2.7.6_linux_amd64.tar.gz \
    && tar -xvf caddy_2.7.6_linux_amd64.tar.gz \
    && mv caddy /usr/bin/ \
    && chown root:root /usr/bin/caddy \
    && chmod 755 /usr/bin/caddy

# Install Ollama using the provided script
RUN curl -fsSL https://ollama.com/install.sh | sh

# Set the environment variable for the Ollama host
ENV OLLAMA_HOST=127.0.0.1
ENV OLLAMA_NUM_PARALLEL=3
ENV OLLAMA_MAX_LOADED_MODELS=3

# Copy a script to start both Ollama and Caddy
COPY start_services.sh /start_services.sh
RUN chmod +x /start_services.sh

EXPOSE 80
EXPOSE 443

COPY Caddyfile /etc/caddy/Caddyfile

# Set the entrypoint to the script
ENTRYPOINT ["/start_services.sh"]