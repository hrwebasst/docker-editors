# docker-editors
vscode, atom, etc docker editors

## vscode settings

You'll want to edit the user settings with the settings.json content

## Running

### VSCode

```bash
docker run -d -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME:/home/user --security-opt seccomp:unconfined -u $UID -e DISPLAY=unix$DISPLAY --device /dev/dri --name vscode motu/vscode
```

### Atom

```bash
docker run -d -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME:/home/user --security-opt seccomp:unconfined -u $UID -e DISPLAY=unix$DISPLAY --device /dev/dri --name atom motu/vscode atom --foreground
```

## aliases

I recommend a shell alias like so:

```bash
alias vscode="docker start vscode"
alias atom="docker start atom"
```

Then you can just type atom or vscode on your main machine to start either docker
