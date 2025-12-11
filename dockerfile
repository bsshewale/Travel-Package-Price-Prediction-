
FROM python:3.10.11-slim-buster

# set the working directory in the container
WORKDIR /app

# copy the current directory contents into the container at /app
COPY . /app

# Copy only requirements.txt first to leverage Docker cache
COPY requirements.txt /app/requirements.txt

# copy Ml model files
COPY decision_tree_reg_latest.joblib /app/decision_tree_reg_latest.joblib
COPY pca.joblib /app/pca.joblib
COPY scaler.joblib /app/scaler.joblib

# install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# make port 5000 available to the world outside this container
EXPOSE 8000

# define environment variable
ENV FLASK_APP=app.py

# run the application
CMD ["flask", "run", "--host=0.0.0.0", "--port=8000"]   
