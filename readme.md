
# Easy HTTPS Proxy for Ollama

This project provides an HTTPS proxy for Ollama, allowing secure communication with the Ollama API server.

## Prerequisites

- Docker and Docker Compose
- Ollama running on the host machine (default port: 11434)

## Setup and Running

1. Clone this repository:
   ```
   git clone https://github.com/your-username/easy-proxy-ollama-https.git
   cd easy-proxy-ollama-https
   ```

2. Start the Docker container:
   ```
   docker-compose up --build -d
   ```

3. The proxy will be available at `https://localhost:11435`

## Trusting the Self-Signed Certificate

To avoid browser warnings about the self-signed certificate, you need to add the root CA certificate to your system's trust store. Follow the steps for your operating system:

### macOS

1. Open Terminal and navigate to the project directory.
2. Run the following command:
   ```
   sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ssl/rootCA.pem
   ```
3. Enter your administrator password when prompted.

### Linux (Ubuntu/Debian)

1. Open Terminal and navigate to the project directory.
2. Run the following commands:
   ```
   sudo cp ssl/rootCA.pem /usr/local/share/ca-certificates/ollama-proxy-rootCA.crt
   sudo update-ca-certificates
   ```

### Windows

1. Open PowerShell as Administrator and navigate to the project directory.
2. Run the following command:
   ```
   Import-Certificate -FilePath ".\ssl\rootCA.pem" -CertStoreLocation Cert:\LocalMachine\Root
   ```

### Firefox Browser

Firefox uses its own certificate store, so you need to import the certificate separately:

1. Open Firefox settings.
2. Search for "certificates" and click "View Certificates".
3. In the "Authorities" tab, click "Import".
4. Select the `ssl/rootCA.pem` file and trust it for identifying websites.

## Usage

After starting the Docker container and trusting the certificate, you can make HTTPS requests to the proxy. For example:

```bash
curl  https://localhost:11435/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "qwen2:0.5b",
    "messages": [
      {
        "role": "user",
        "content": "Hello, how are you?"
      }
    ]
  }'
```

Replace `qwen2:0.5b` with the model you're using in Ollama.

## Security Note

The self-signed certificate is for development and testing purposes only. For production use, obtain a properly signed certificate from a trusted Certificate Authority.

## License

[MIT License](LICENSE)
