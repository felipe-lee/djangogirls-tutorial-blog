FROM python:3

ENV PROJECT_PATH=/app \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

WORKDIR ${PROJECT_PATH}

COPY *requirements.txt ./

RUN pip install -r test_requirements.txt

RUN echo 'alias ls="ls -la --color=auto"' > /root/.bashrc
