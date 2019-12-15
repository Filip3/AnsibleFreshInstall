# How to connect to a Windows Host with Ansible

To be able to have a communication with your Windows Host you would need to setup a WoinRM communication. This is required because the way that Ansible communicates with the Windows Host is with the use of WinRM. And with the use of WinRM it runs powershell scripts on the Windows host machine.

## Download and run the Remoting PowerShell script for Ansible

As with most Windows setups, WinRM comes within them, but it is not turned on by default. Luckily there's a PowerShel script that you can run in PowerShell as an sdmin and turn on WinRM and all the necessary configuration for the communication between Ansible on WSL and the Windows Host.
This PowerShell script can be found on the following at [ConfigureRemoteForAnsible.ps1](<https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1>).

## Install Pywinrm

Because its dependencies are not delivered by default with the Ansible Engine, and there are necessary. We need to install ```pywinrm``` and its related libraries.

The simplest way is to run the command from your Terminal is

```bash
pip3 install pywinrm
```

Keep in mind if you don"t have ```pip``` you might need to use ```pip3```.

**Back to the main [README.md](./README.md) file.**
