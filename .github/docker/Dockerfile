FROM opensuse/tumbleweed:latest
RUN zypper up
RUN zypper --non-interactive in git curl sudo shadow
RUN groupadd wheel
RUN useradd --create-home --shell /bin/bash cirun
RUN gpasswd -a cirun wheel
RUN echo 'cirun ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER cirun
RUN curl -sL evanriley.dev/dotfiles | bash
RUN $HOME/bin/linux-deps
