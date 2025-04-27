FROM jupyter/datascience-notebook:latest

WORKDIR /app

COPY requirements.txt .
RUN pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org --no-cache-dir -r requirements.txt

RUN python -m ipykernel install --user

# Jupyter Notebook 설정
RUN jupyter notebook --generate-config \
    && echo "c.NotebookApp.ip = '0.0.0.0'" >> /etc/jupyter/jupyter_notebook_config.py \
    && echo "c.NotebookApp.port = 8888" >> /etc/jupyter/jupyter_notebook_config.py \
    && echo "c.NotebookApp.notebook_dir = '/home/jovyan/work'" >> /etc/jupyter/jupyter_notebook_config.py

COPY . .

EXPOSE 8888

# 컨테이너 시작 시 Jupyter Notebook 실행
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser"]