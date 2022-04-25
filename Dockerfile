# This Dockerfile defines an Ubuntu image that is able to execucte reconstruct_surface.py out of the box with all dependencies installed.

FROM continuumio/miniconda3
RUN apt-get update && apt-get install unzip -y
WORKDIR /deep-geometric-prior
COPY . .
RUN conda env create -f environment.yml
RUN echo "conda activate deep-geometric-prior" >> /root/.bashrc
# Install gdown for downloading data
RUN pip install gdown
RUN gdown https://drive.google.com/uc?id=17Elfc1TTRzIQJhaNu5m7SckBH_mdjYSe
RUN unzip deep_geometric_prior_data.zip
# Set an entrypoint so the containers can execute commands in the conda env from "docker run"
# "conda run -n <env-name>"" runs whatever follows as if the env was activated
# "--no-capture-output" allows stdout and stderr to get piped through transparently
# ENTRYPOINT [ "conda", "run", "--no-capture-output" "-n", "deep-geometric-prior",  "/bin/bash", "-c"]