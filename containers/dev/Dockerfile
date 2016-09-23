FROM centos:7

RUN set -x \
    && yum -y install yum-plugin-fastestmirror \
    && echo "include_only=.jp" >>  /etc/yum/pluginconf.d/fastestmirror.conf \
    # Packages
    && yum -y update \
    # Repos
    && yum -y install \
        epel-release \
    && yum -y install \
        bzip2 \
        gcc-c++ \
        git \
        glibc-headers \
        libffi-devel \
        libxml2-devel \
        libxslt-devel \
        libyaml-devel \
        lua \
        lua-devel \
        make \
        mysql-devel \
        ncurses-devel \
        net-tools \
        nodejs \
        openssl-devel \
        patch \
        perl \
        perl-devel \
        perl-ExtUtils-CBuilder \
        perl-ExtUtils-Embed \
        perl-ExtUtils-ParseXS \
        python \
        python-devel \
        python34 \        
        python34-devel \
        readline \
        readline-devel \
        ruby-devel \
        sqlite-devel \
        sudo \
        tar \
        tcl-devel \
        tree \
        wget \
        zlib \
        zlib-devel \
        zsh 
RUN ln -s /usr/bin/python3.4 /usr/local/bin/python
# timezone
RUN echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
# user
RUN echo 'root:root' | chpasswd
RUN useradd -m developer
RUN echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN echo 'developer:developer' | chpasswd
RUN chsh -s /usr/bin/zsh developer
# vim
RUN git clone https://github.com/vim/vim.git /tmp/vim
WORKDIR /tmp/vim
RUN ./configure \
    --with-features=huge \
    --enable-multibyte \
    --enable-xim \
    --enable-fontset \
    --enable-perlinterp \
    --enable-python3interp \
    --with-python3-config-dir=/usr/lib64/python3.4/config-3.4m \
    --enable-rubyinterp \
    --enable-luainterp \
    --enable-fail-if-missing \
    --enable-pythoninterp \
    --with-python-config-dir=/usr/lib64/python2.7/config
RUN make
RUN make install
## Python(virtualenv)
WORKDIR /tmp
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN pip install virtualenv virtualenvwrapper
# Python (pyenv)
RUN git clone https://github.com/yyuu/pyenv.git /opt/pyenv
RUN ln -s /opt/pyenv/bin/pyenv /usr/local/bin/pyenv
RUN echo 'export PYENV_ROOT=/opt/pyenv' >> /etc/profile.d/pyenv.sh
RUN echo 'eval "$(pyenv init -)"' >> /etc/profile.d/pyenv.sh
RUN chmod +x /etc/profile.d/pyenv.sh
RUN source ~/.bashrc \
    && pyenv install 3.5.1 \
    && pyenv install 2.7.11
# Ruby(rbenv)
RUN git clone https://github.com/sstephenson/rbenv.git /opt/rbenv
RUN ln -s /opt/rbenv/bin/rbenv /usr/local/bin/rbenv
RUN echo 'export RBENV_ROOT=/opt/rbenv' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN chmod +x /etc/profile.d/rbenv.sh
RUN git clone https://github.com/sstephenson/ruby-build.git /opt/rbenv/plugins/ruby-build
RUN source ~/.bashrc \
    && CONFIGURE_OPTS="--disable-install-rdoc" MAKE_OPTS="-j4" rbenv install -v 2.3.1 \
    && rbenv rehash \
    && rbenv global 2.3.1
RUN sed -i -e '79i Defaults    env_keep += "PATH RBENV_ROOT"' /etc/sudoers
RUN sed -i -e 's/^Defaults *secure_path/# Defaults   secure_path/' /etc/sudoers
USER developer
WORKDIR /home/developer
# dotfiles
RUN git clone https://github.com/shin-m/dotfiles.git ~/dotfiles
RUN make -C ~/dotfiles deploy
# neobundle
RUN mkdir -p .vim/bundle
RUN git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
RUN cd ~/.vim/bundle/neobundle.vim/bin && ./neoinstall
# powerline-status
RUN pip install --user powerline-status
# oh-my-zsh
RUN git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
CMD ["/usr/bin/zsh"]
