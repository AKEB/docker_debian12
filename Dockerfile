FROM debian:12.5-slim

ENV TZ=UTC
WORKDIR /app
USER root

RUN apt-get clean && apt-get dist-upgrade -y \
	&& apt-get update -y --allow-insecure-repositories \
	&& apt-get install -y --allow-unauthenticated \
	curl \
	lsb-release \
	ca-certificates \
	apt-transport-https \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -sSLo /usr/share/keyrings/sury-php-archive-keyring.gpg \
    https://packages.sury.org/php/apt.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/sury-php-archive-keyring.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" \
    > /etc/apt/sources.list.d/sury-php.list

RUN apt-get update -y --allow-insecure-repositories \
	&& apt-get install -y --allow-unauthenticated \
	iputils-ping \
	wget \
	nano \
	git \
	sqlite3 \
	iproute2 \
	dnsutils \
	software-properties-common \
	procps \
	mc \
	&& rm -rf /var/lib/apt/lists/*

RUN touch /run_on_start.sh && chmod +x /run_on_start.sh

CMD ["/bin/bash"]
