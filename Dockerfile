FROM golang:1.7.1

# docker run -d -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME:/home/user -e DISPLAY=unix$DISPLAY --security-opt seccomp:unconfined --device /dev/dri --name vscode vscode

RUN apt-get update && apt-get install -y libasound2 libatk1.0-0 libcairo2 libcups2 libdatrie1 libdbus-1-3 libfontconfig1 libfreetype6 libgconf-2-4 \
 libgcrypt20 libgl1-mesa-dri libgl1-mesa-glx libgdk-pixbuf2.0-0 libglib2.0-0 libgtk2.0-0 libgpg-error0 libgraphite2-3 libnotify-bin libnss3 libnspr4 gconf2 gconf-service gvfs-bin xdg-utils git libgnome-keyring-dev libnotify4 \
 libpango-1.0-0 libpangocairo-1.0-0 libxcomposite1 libxcursor1 libxdmcp6 libxi6 libxrandr2 libxrender1 libxtst6 liblzma5 libxss1 zsh --no-install-recommends \
 && apt-get purge -y --auto-remove

ENV ATOM_VERSION 1.11.1

RUN curl -sSL https://github.com/atom/atom/releases/download/v${ATOM_VERSION}/atom-amd64.deb -o /tmp/atom-amd64.deb \
 && dpkg -i /tmp/atom-amd64.deb \
 && rm -rf /tmp/*.deb \
 && apt-get purge -y

ENV HOME /home/user
RUN useradd --create-home -s /usr/bin/zsh --home-dir $HOME user \
  && chown -R user:user $HOME

# ADD VSCode.zip /tmp/vs.zip
# RUN unzip /tmp/vs.zip -d /usr/src/ \
#   && rm -rf /tmp/vs.zip

# This is the insider build hence install path
ADD VSCode.deb /tmp/VSCode.deb
RUN dpkg -i /tmp/VSCode.deb && rm /tmp/VSCode.deb

WORKDIR $HOME

USER user

RUN PATH=/go/bin:/usr/local/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

CMD /usr/share/code-insiders/code-insiders
# CMD atom --foreground

# {
#     "go.buildOnSave": true,
#     "go.lintOnSave": true,
#     "go.vetOnSave": true,
#     "go.buildTags": "",
#     "go.buildFlags": [],
#     "go.lintTool": "golint",
#     "go.lintFlags": [],
#     "go.vetFlags": [],
#     "go.coverOnSave": false,
#     "go.useCodeSnippetsOnFunctionSuggest": false,
#     "go.formatOnSave": true,
#     "go.formatTool": "goreturns",
#     "go.gopath": "/go",
#     "go.goroot": "/usr/local/go",
#     "go.gocodeAutoBuild": false,
#     "terminal.integrated.shell.linux": "zsh"
# }
