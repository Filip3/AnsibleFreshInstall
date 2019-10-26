# Fresh Install

This repository is providing a half automated way to manage your local enviornment. Before you do so you would need to enable some confiugration on your local machine.

## Windows Programs

```powershell
PS> Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

## Install Windows Terminal

There are 2 options to install Windows Terminal:

- From the Windows Store
  - [Windows Terminal](<https://www.microsoft.com/de-de/p/windows-terminal-preview/9n0dx20hk701?activetab=pivot:overviewtab>)
- From GitHub
  - [Windows Terminal](<https://github.com/microsoft/terminal>)

After installing it you can setup a shortcut that would always run you Terminal in Administrator Rights.

- Right click on Desktop and create a new Shortcut
- In Location input: ```cmd  C:\Windows\system32\cmd.exe /c start /b wt```
- As Name input: Windows Terminal
- And as a final step, right click into properties -> Advanced and check the option to "Run as Administrator"

## Windows Subsystem for Linux

```powershell
PS> Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
# Restart machine
PS> Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile Ubuntu.appx -UseBasicParsing
PS> Add-AppxPackage .\Ubuntu.appx
PS> ~\AppData\Local\Microsoft\WindowsApps\Ubuntu.exe
```

### Install packages withing WSL

Install the following packages:

```bash
$> sudo apt-get update $$ sudo apt-get upgrade
$> sudo apt-get update && \
    sudo apt-get install \
        socat \
        git \
        zulu-11 \
        software-properties-common
$> sudo apt-add-repository -y --update ppa:ansible/ansible && \
    sudo apt install -y \
        ansible
```

### Disable Password for sudo

Using `visudo` to disable password request when running `sudo` commands.

```bash
$> sudo visudo

# ...
#includedir /etc/sudoers.d

# USER_NAME ALL=(ALL) NOPASSWD: ALL
user_name ALL=(ALL) NOPASSWD: ALL
```

### Set Root Point

The actual root for all disk drives points to `/mnt/DRIVE_CHAR/` e.g. `/mnt/c/`. This can be altered since Win 1903 by adding a `wsl.conf` to the `/etc/` folder with the following content:

```conf
[automount]

root = /

options = "metadata"
```

I will use this configuration, so later on paths it will point to `/e/folder/on/e/` instead of `/mnt/e/folder/on/e/`. *This is also important when mounting files and folders to an docker container!*

## Running the Ansible Playbook

After setting up WSL and most necessary and convinent step you can run the following command

```bash
ansible-playbook freshinstall.yml -i inventory.yml
```
