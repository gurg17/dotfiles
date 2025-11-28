#!/usr/bin/env bash
# Setup script for pulling default Ollama models

set -e

echo "🤖 Setting up Ollama models..."

# Check if ollama is installed
if ! command -v ollama &> /dev/null; then
    echo "❌ Error: ollama is not installed or not in PATH"
    echo "Please install ollama first using:"
    echo "  - macOS: darwin-rebuild switch --flake .#<hostname>"
    echo "  - Linux: home-manager switch --flake .#<username>@linux"
    exit 1
fi

# Check if ollama service is running
if ! ollama list &> /dev/null; then
    echo "⚠️  Warning: ollama service might not be running"
    echo "Starting ollama service..."
    # Try to start ollama in the background
    ollama serve &> /dev/null &
    OLLAMA_PID=$!
    sleep 3
    echo "✓ Ollama service started (PID: $OLLAMA_PID)"
fi

# Pull models
echo ""
echo "📦 Pulling qwen2.5-coder:1.5b..."
ollama pull qwen2.5-coder:1.5b

echo ""
echo "📦 Pulling deepseek-r1:14b..."
ollama pull deepseek-r1:14b

echo ""
echo "✅ Ollama setup complete!"
echo ""
echo "Available models:"
ollama list

