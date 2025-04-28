FROM jupyter/datascience-notebook:latest

WORKDIR /app

COPY . .
RUN pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org --no-cache-dir -r requirements.txt

RUN python -m ipykernel install --user

EXPOSE 8888
# Jupyter Notebook 설정
RUN jupyter notebook --generate-config \
    && echo "c.NotebookApp.ip = '0.0.0.0'" >> /etc/jupyter/jupyter_notebook_config.py \
    && echo "c.NotebookApp.port = 8888" >> /etc/jupyter/jupyter_notebook_config.py

# (선택) Health Check 간단 버전 추가 - 서버만 체크
HEALTHCHECK CMD curl --fail http://localhost:8888/ || exit 1

# 컨테이너 시작 시 Jupyter Notebook 실행
CMD ["voila", "--no-browser", "--Voila.ip=0.0.0.0", "--Voila.port=8888", "--no-browser", "--debug", "app.ipynb"]