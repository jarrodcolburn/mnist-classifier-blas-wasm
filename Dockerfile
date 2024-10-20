FROM continuumio/miniconda3
RUN conda install -y lfortran -c conda-forge 
RUN git clone https://github.com/emscripten-core/emsdk.git && \
  cd emsdk && \
  ./emsdk install latest && \
  ./emsdk activate latest && \
  echo "EMSDK_QUIET=1 source $PWD/emsdk_env.sh" >> ~/.bashrc
