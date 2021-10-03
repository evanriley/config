FROM opensuse/tumbleweed
RUN zypper refresh
RUN zypper in git
RUN useradd -ms /bin/bash cirun
RUN gpasswd -a cirun  wheel
RUN echo 'cirun ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER cirun
RUN curl -sL https://raw.githubusercontent.com/evanriley/config/main/bin/install.sh
