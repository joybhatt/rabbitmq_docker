FROM frodenas/ubuntu
MAINTAINER Joy Bhattacharjee <joyahan01@gmail.com>

# Install RabbitMQ 3.6.5-1
RUN DEBIAN_FRONTEND=noninteractive && \
    cd /tmp && \
    apt-get update && \
    apt-get install erlang-nox -y && \
    apt-get install socat -y && \
    wget https://www.rabbitmq.com/releases/rabbitmq-server/v3.6.5/rabbitmq-server_3.6.5-1_all.deb && \
    dpkg -i rabbitmq-server_3.6.5-1_all.deb && \
    rabbitmq-plugins enable rabbitmq_management && \
    service rabbitmq-server stop && \
    apt-get install --yes runit && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
# Add scripts
ADD scripts /scripts
RUN chmod +x /scripts/*.sh
RUN touch /.firstrun

# Command to run
ENTRYPOINT ["/scripts/run.sh"]
CMD [""]

# Expose listen port
EXPOSE 5672
EXPOSE 15672

# Expose our log volumes
VOLUME ["/data"]
