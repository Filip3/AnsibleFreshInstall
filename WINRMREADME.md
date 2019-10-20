# How to connect to a Windows Host with Ansible

TO be able to have communication with your Windows Host you would need a proper WINRM communication. This is required because the way that Ansible communicates with the Windows Host is with the use of WINRM. And with the use of WINRM it runs powershell scripts to the host machine.

## Download and run the Remoting ps script for Ansible

With most Windows setups, WinRM comes within them, but it is not turned on by default. Luckily there's a PowerShel script that zou can run in PowerShell in Admin mode and turn on WinRM.
This PowerShell script can be found on the following link:
[ConfigureRemoteForAnsible.ps1](<https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1>)

## Install Pywinrm

Because its dependencies are not delivered by default with the Ansible Engine, and there are necessary. We need to install pywinrm and its related libraries.

The simplest way is to run the command from your Terminal is

```bash
pip3 install pywinrm
```

Keep in mind if zou don"t have ```pip``` you might need to use ```pip3```.
