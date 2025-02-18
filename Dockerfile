FROM ubuntu:20.04
LABEL author="kurisu"
LABEL maintainer="makise_kurisuu@outlook.jp"

RUN apt-get update && \
    apt-get -y install gnupg2 openjdk-8-jdk zip unzip && \
    apt-get -y install xfonts-cyrillic xfonts-100dpi xfonts-75dpi xfonts-base xfonts-scalable && \
    apt-get -y install wget fonts-liberation libasound2 libatk-bridge2.0-0 libatk1.0-0 && \
    apt-get -y install xvfb gtk2-engines-pixbuf libatspi2.0-0 libcurl3-gnutls libcurl3-nss && \
    apt-get -y install imagemagick x11-apps libcurl4 libgbm1 libgtk-3-0 libnspr4 libu2f-udev && \
    apt-get -y install libnss3 libxcomposite1 libxdamage1 libxkbcommon0 libxrandr2 xdg-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN Xvfb -ac :99 -screen 0 1280x1024x16 & export DISPLAY=:99
# Install chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome*.deb || apt-get -f install -y && \
    rm -f google-chrome*.deb
# Install chromedriver
RUN wget https://chromedriver.storage.googleapis.com/113.0.5672.63/chromedriver_linux64.zip && \
    unzip chromedriver_linux64.zip && mkdir -p /driver && \
    mv chromedriver /driver/ && chmod +x /driver/chromedriver && \
    rm -rf chromedriver_*
