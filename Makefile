setup-python:
	pyenv virtualenv 3.10.8 spark-on-k8s-playground
	pyenv local spark-on-k8s-playground
	pip install -r requirements.txt
