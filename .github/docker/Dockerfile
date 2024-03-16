FROM opensuse/tumbleweed:latest
RUN zypper up
RUN zypper --non-interactive in git
RUN useradd -ms /bin/bash susey
RUN gpasswd -a susey wheel
RUN echo 'susey ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER susey
RUN curl -sL evanriley.dev/dotfiles | bash
RUN linux-deps
