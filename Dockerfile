FROM archlinux:latest
USER root
RUN sed -i '/China/!{n;/Server/s/^/#/};t;n' /etc/pacman.d/mirrorlist &&\
    echo '[archlinuxcn]' >> /etc/pacman.conf &&\
    echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch' >> /etc/pacman.conf && \
    pacman -Syu --noconfirm &&\
    pacman -S --noconfirm archlinuxcn-keyring  && \
    pacman -S --noconfirm base-devel cmake git zsh oh-my-zsh-git yay vim pkgfile fontconfig xorg-mkfontscale&& \
    pacman -S --noconfirm wget && \
    pacman -Scc --noconfirm


RUN useradd -ms /usr/bin/zsh tkit -G wheel && echo "tkit:123456" | chpasswd && sed -i 's/^#\s*\(%wheel\s*ALL=(ALL)\s*NOPASSWD:\s*ALL\)/\1/' /etc/sudoers

USER tkit
WORKDIR /home/tkit

RUN curl -sLf https://spacevim.org/cn/install.sh | bash

RUN cp /usr/share/oh-my-zsh/zshrc ~/.zshrc && \
     sed -i '1i ZSH_DISABLE_COMPFIX=true' ~/.zshrc
CMD [ "/usr/bin/zsh" ]

