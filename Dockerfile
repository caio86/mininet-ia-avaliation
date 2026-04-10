FROM iwaseyusuke/mininet:latest

WORKDIR /workspace

COPY ./botnet_topo.py .

CMD ["python3", "botnet_topo"]
