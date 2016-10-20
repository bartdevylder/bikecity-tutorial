FROM andrewosh/binder-base

MAINTAINER Bart De Vylder <bartdevylder@gmail.com>

# Install nbgrader
RUN pip install git+git://github.com/jupyter/nbgrader.git

# Install nbgrader extensions
RUN jupyter notebook --generate-config
RUN nbgrader extension install --user
RUN nbgrader extension activate

# Setup the exchange directory
USER root
RUN mkdir -p /srv/nbgrader/exchange
RUN chmod ugo+rw /srv/nbgrader/exchange
USER main

# Add the notebook config and formgrade extension
ADD jupyter_notebook_config.json /home/main/.jupyter/jupyter_notebook_config.json
ADD formgrade_extension.py /home/main/anaconda2/lib/python2.7/site-packages/formgrade_extension.py
ADD notebookauth.py /home/main/anaconda2/lib/python2.7/site-packages/notebookauth.py
