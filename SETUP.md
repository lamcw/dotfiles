# Setup for Coder Development Environment

## Quick Start

1. Install and configure zsh
    ```console
    $ sudo apt install zsh
    $ sudo chsh -s /bin/zsh $(whoami)
    ```
1. Configure gpg agent forwarding

    In devbox, add the following to `/etc/ssh/sshd_config`
    ```conf
    StreamLocalBindUnlink yes
    ```
    then run
    ```console
    $ sudo system restart sshd
    ```
    to restart sshd.

    Then in local laptop, add this option to ssh config `~/.ssh/config`
    ```
    Host coder.my-ws
    RemoteForward <socket_on_remote_box>  <extra_socket_on_local_box>
    ```

    `socket_on_remote_box`: `gpgconf --list-dir agent-socket`
    `extra_socket_on_local_box`: `gpgconf --list-dir agent-extra-socket`
1. Install `aws`
    ```console
    $ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    ```
