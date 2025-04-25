FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org --no-cache-dir -r requirements.txt

RUN python -m ipykernel install --user

COPY . .

EXPOSE 8866

CMD ["voila", "app.ipynb", "--port=8866", "--no-browser"]