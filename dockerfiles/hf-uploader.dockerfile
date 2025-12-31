FROM python:3.10-slim

RUN apt-get update -o Acquire::Check-Valid-Until=false -o Acquire::AllowInsecureRepositories=true -o Acquire::AllowDowngradeToInsecureRepositories=true || true
RUN apt-get install -y --allow-unauthenticated git curl git-lfs && \
    rm -rf /var/lib/apt/lists/* && \
    git lfs install

WORKDIR /app

RUN pip install --no-cache-dir \
    huggingface_hub \
    wandb 

COPY trainer/ trainer/
COPY core/ core/

ENV PYTHONPATH=/app

ENTRYPOINT ["python", "trainer/utils/hf_upload.py"]