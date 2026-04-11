FROM python:3.12-slim AS builder

COPY install-pdm.py .
RUN python3 install-pdm.py

WORKDIR /app

COPY pdm.lock pyproject.toml /app/
RUN /root/.local/bin/pdm sync -g -p /app --no-self --prod;

FROM python:3.12-slim AS app

WORKDIR /app

COPY --from=builder /usr/local/lib/python3.12/site-packages/ /usr/local/lib/python3.12/site-packages/
COPY --from=builder /usr/local/bin/ /usr/local/bin/

COPY . .

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]
