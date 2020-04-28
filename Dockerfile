FROM continuumio/miniconda3:4.8.2

LABEL maintainer="gregpry.chevalley+docker@gmail.com"

ENV CONDA_DIR=/opt/conda
ENV CONDA_ENV_CURRENT=autoviz
ENV NOTEBOOKS=/opt/notebooks

RUN conda create -n ${CONDA_ENV_CURRENT} python=3.7 && \ 
    conda install -n ${CONDA_ENV_CURRENT} -y -c conda-forge boto3 ipywidgets jupyter_console matplotlib minio notebook pandas python-dateutil python-dotenv qtconsole qtpy scikit-learn requests scipy seaborn statsmodels tabulate widgetsnbextension xlrd xlwt xgboost && \
    conda clean -yt && \
    ${CONDA_DIR}/envs/${CONDA_ENV_CURRENT}/bin/pip install autoviz && \
    mkdir ${NOTEBOOKS}

EXPOSE 8888

VOLUME ["${NOTEBOOKS}"]

CMD ["/bin/bash", "-c", "${CONDA_DIR}/envs/${CONDA_ENV_CURRENT}/bin/jupyter notebook --notebook-dir=${NOTEBOOKS} --ip='*' --port=8888 --no-browser --allow-root" ]