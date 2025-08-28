# --- Dockerfile ---
FROM python:3.11-slim

# System deps (minimal)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install Python deps first (better layer cache)
COPY requirements.txt /app/
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy your notebook + modules (Visualizers, etc.)
COPY . /app/

# Hugging Face Spaces expects port 7860
EXPOSE 7860

# Serve the notebook with Voila
# If you rename the notebook, update the filename below
CMD ["voila", "NeuralNetGuide.ipynb", "--port=7860", "--no-browser", "--VoilaConfiguration.enable_nbextensions=True"]
