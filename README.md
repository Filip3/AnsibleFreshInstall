# Fresh Install

This repository is providing a half automated way to manage your local Windows/WSL environment. Before you do you would need to enable some configuration on your local machine.

*Keep in mind that most steps will require elevated rights.*

## Windows Programs

```powershell
PS> Set-ExecutionPolicy Bypass -Scope Process -Force
```
We need to also enable the Virtual Machine Platform optional component on Windows. 
```powershell
PS> dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

## Install Windows Terminal

There are 3 options to install Windows Terminal:

- From the Windows Store
  - [Windows Terminal](<https://www.microsoft.com/de-de/p/windows-terminal-preview/9n0dx20hk701?activetab=pivot:overviewtab>)
- From GitHub
  - [Windows Terminal](<https://github.com/microsoft/terminal>)
- Using Chocolatey
  - [Windows Terminal](https://chocolatey.org/packages/microsoft-windows-terminal/)

Or you can leave it to the task included in the common role, which would install Windows Terminal for you.

After installing it you can setup a shortcut that would always run your Terminal in Administrator Rights.

- Right click on Desktop and create a new Shortcut
- In Location input: ```cmd  C:\Windows\system32\cmd.exe /c start /b wt```
- As Name input: Windows Terminal
- And as a final step, right click into properties -> Advanced and check the option to "Run as Administrator"

## Windows Subsystem for Linux

This feature can be installed from the Ansible roles. But since this is a local setup using WSL itself. We would have to do it from before, so we can use it to run the ansible playbook.
```powershell
PS> Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
# Restart machine
# A distro version can be chosen from the list provided my msft.
PS> Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile Ubuntu.appx -UseBasicParsing
PS> Add-AppxPackage .\Ubuntu.appx
PS> ~\AppData\Local\Microsoft\WindowsApps\Ubuntu.exe
```
After installing the distro version you can configure WSL 2 as a default version.

*At the moment WSL 2 doesn't provide a easy way to communicate with the windows host, and Ansible cannot be executed without temporary workarounds.*
```bash
wsl --set-default-version 2
```

### Install Ansible and add additional packages within WSL

Install packages and update the distro with the following commands:

```bash
$> sudo apt-get update
$> sudo apt-get upgrade
$> sudo apt-get install socat
$> sudo apt-get install git
$> sudo apt-get install zulu-11
$> sudo apt-get install software-properties-common
$> sudo apt-add-repository -y --update ppa:ansible/ansible
$> sudo apt install ansible
```

### Disable Password for sudo

Using `visudo` to disable password request when running `sudo` commands.

```bash
$> sudo visudo

# ...
#includedir /etc/sudoers.d

# USER_NAME ALL=(ALL) NOPASSWD: ALL
user_name ALL=(ALL) NOPASSWD: ALL
#example: filip ALL=(ALL) NOPASSWD: ALL
```

### Set Root Point

The actual root for all disk drives points to `/mnt/DRIVE_CHAR/` e.g. `/mnt/c/`. This can be altered since Win 1903 by adding a `wsl.conf` to the `/etc/` folder with the following content:

To edit the .conf file, run the following command in your WSL.

```bash
$> sudo vim /etc/wsl.conf
```

```conf
[automount]

root = /

options = "metadata"
```

This configuration would help later in the paths that it will point to `/e/folder/on/e/` instead of `/mnt/e/folder/on/e/`. *This is also important when mounting files and folders to an docker container!*

## Ansible

### Enabling WINRM Remoting

To be able to execute Ansible on your local environment, you would need to setup WINRM.
More details on it can be found [here](./WINRMREADME.md).

### Running the Ansible Playbook

For our installations we will run two playbooks against both, WSL and Windows host.

#### Ansible Windows Playbook

After setting up WSL and Ansible, you can run the following command to execute the Ansible playbook.

```bash
ansible-playbook freshinstall.yml -i hosts/inventory.yml
```

#### Ansible WSL Linux Playbook

To be able to execute the Linux playbook you would need to check your Linux hosts file. If it contains the following:

``` bash
127.0.1.1   wsl.local
127.0.0.1   windows.local
```

Execute the following

```bash
sudo vim /etc/hosts
```

And if necessary edit the hosts file.

After that you can execute the following playbook:

```bash
ansible-playbook freshinstallwsl.yml -i inventory.yml
```

## Enhancing your command line or PS or bash experience with Cascadia Fonts

While we are installing [Font Forge]([<https://fontforge.github.io/en-US/>]) with the ansible playbook, for now we need to manually download [Cascadia Code Font]([<https://github.com/microsoft/cascadia-code>]) and enhance it with glyphs. So we can have to complete font experience.

Since we already have Font Forge, you just need to download [Cascadia Code Font from Releases]([<https://github.com/microsoft/cascadia-code/releases/>]).
After downloading the font, run the following command, where the font (.ttf) has been downloaded, so it can add the glyphs.

```bash
fontforge -script font-patcher /mtn/c/Users/{Insert Here User}/Downloads/Cascadia.ttf -c
```
