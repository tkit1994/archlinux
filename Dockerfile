FROM archlinux/base:latest
USER root
RUN sed -i '/China/!{n;/Server/s/^/#/};t;n' /etc/pacman.d/mirrorlist &&\
    pacman-key --init && \
    pacman -Syy &&\
    echo '[archlinuxcn]' >> /etc/pacman.conf &&\
    echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch' >> /etc/pacman.conf && \
    pacman -Syy &&\
    pacman -S --noconfirm archlinuxcn-keyring  && \
    pacman -S --noconfirm base-devel neovim cmake git zsh vim oh-my-zsh-git yay vi vim pkgfile fontconfig xorg-mkfontscale clang


RUN useradd -ms /usr/bin/zsh tkit -G wheel && echo "tkit:123456" | chpasswd && sed -i 's/^#\s*\(%wheel\s*ALL=(ALL)\s*NOPASSWD:\s*ALL\)/\1/' /etc/sudoers

USER tkit
WORKDIR /home/tkit

RUN curl -sLf https://spacevim.org/cn/install.sh | bash

RUN cp /usr/share/oh-my-zsh/zshrc ~/.zshrc
CMD [ "zsh" ]

