FROM opensuse/leap:15.0
RUN zypper update -y
RUN zypper --non-interactive install git curl sudo shadow
RUN groupadd wheel
RUN useradd --create-home --shell /bin/bash cirun
RUN gpasswd -a cirun wheel
RUN echo 'cirun ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER cirun
RUN curl -sL evanriley.dev/dotfiles | bash
RUN $HOME/bin/linux-deps
LABEL org.opencontainers.image.source="https://github.com/evanriley/config"
