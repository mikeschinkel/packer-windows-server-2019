# Packer/Vagrant for Windows Server 2019

This repo assumes you will be running on a macOS computer. 

If not, it should still generally work but we may need to tweak some bits since it was not build not tested on Windows or Linux. 

## How to Use
1. Clone this repo.
2. [Install VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Packer](https://learn.hashicorp.com/tutorials/packer/get-started-install-cli).
3. Run `make` _(this will take around an hour.)_
4. [Install Vagrant](https://www.vagrantup.com/downloads).
5. Copy `./box-local-sample.json` to  `./box-local.json` 
6. Edit `./box-local.json` per the `@notes` contained within. 
7. Run `vagrant up`
8. Remote Desktop to `127.0.0.1:3389` 
   1. Username/password are `Administator` / `vagrant`
9. Find the SQL Server Developer installer in `C:\Windows\Temp\Software\`
   1. Here is a [how-to article](https://jimsalasek.com/2019/12/03/installing-sql-server-2019-developer-edition/) if you need it.
10. You should now be done!

## Next Steps
Since this is very much an _"alpha"_ release there are likely to be problems. 

Issues are accepted.  Pull Requests are appreciated.


## Makefile options
Our `Makefile` has three (3) options besides just running the default a.k.a. everything.  Each option is dependent on the output of the previous option:

| Command| Description|
|--------|-----------|
| `make install` | Installs barebones Windows VM and creates an OVF file |
| `make configure` | Configures the Windows VM and creates an OVA file |
| `make convert` | Converts the Windows VM into a BOX file for use with Vagrant |

## Understanding Packer
This project uses [Packer](https://packer.io) to do the following:

1. **Installs** Windows Server 2019 into a VirtualBox VM using [Windows Unattended Installation](https://www.windowscentral.com/how-create-unattended-media-do-automated-installation-windows-10) which leverages an [`autounattend.xml` _"answer"_ file](https://win10.guru/simple-deployment-with-autounattend-xml-answer-file/) for an initial Windows setup. This step generates a VirtualBox OVF and is what running `make install` will do.
2. **Configures** the previously installed Windows Server 2019 VM using VirtualBox and by running Powershell scripts which you can find in the `/scripts` directory of this repo. They are also copied by this task to the `C:\Windows\Temp\Scripts` directory of the VM. This step generates a VirtualBox OVA and is what running `make configure` will do.
3. **Converts** the previously generated VirtualBox OVA into a [Vagrant BOX format](https://www.vagrantup.com/docs/boxes/format) which is basically a tar/zipped file containing the OVA and some metadata. This step is what running `make convert` will do.
   

## Understanding Vagrant
Vagrant runs a `Vagrantfile` which is a semi-declarative script written in Ruby syntax that specifies the Vagrant Box to run — which it gets from [_Understanding Packer_](#understanding-packer) _> **Converts**_ — as well as any other local configuration a user needs.  

The Vagrant app reads the Vagrantfile and remote-controls VirtualBox to automate the task of getting a virtual machine up and running to use for local development. It typically handles setting up networking and mounts a directory within the VM to allow access to the directory from which Vagrant is started. For our box we named that directory `C:\Host`.

### Vagrant Commands
Vagrant has many commands, but the ones we are most likely to need frequently are as follows. _(Note that Vagrant reads the `Vagrantfile` in the current directory to decide what exactly the commands you invoke should do):_

| Command| Description|
|--------|-----------|
| `vagrant up` | Starts the Vagrant box specified in the `Vagrantfile`.<br>This should take around 1-2 minutes. |
| `vagrant halt` | Saves the current state of the currently running Vagrant box as specified in the `Vagrantfile` and stops it running. |
| <nobr>`vagrant destroy`</nobr> | Deletes the state of your Vagrant box specified in the `Vagrantfile`. For example if you had installed software, changed configuration or creates databases, the next time you run `vagrant up` you will get a new pristine copy of  the Vagrant box specified in  the current `Vagrantfile`. IOW, all your changes will be lost. **THIS IS WHY YOU SHOULD CONSIDER YOUR** Vagrant box to be **_impermanent_** |
| `vagrant ssh` | Allows you to SSH directly to a CMD prompt within the VM.<br> **THIS PROBABLY DOES NOT WORK YET**. |
| <nobr>`vagrant powershell`</nobr> | Like `vagrant ssh` this allows you to open a terminal into your VM that is running Powershell. _This **may not** be working not be working yet_. |


## TODOs

This is the current list of TODOs that I can envision would be beneficial for our use of this Vagrant box though I am sure we will add numerous more:

1. Figure out how to turn Network Discovery on by default, in `autounattend.xml`.
2. Set up SSH to work as a `communicator` and ensure `vagrant ssh` works.
3. See if we can get `smb_password` from macOS keychain.
4. Add [Chocolately](https://chocolatey.org/) to `configure` step.
5. Determine if there are also benefits to using [Boxstarter](https://boxstarter.org/).
   - If so, install and use Boxstarter during `configure` step.
6. Identify and eradicate all errors in the build logs.
8. Determine if we can install Windows updates via `autounattend.xml`.
7. Consolidate the many `<SynchronousCommand>` entries in `<FirstLogonCommands>` of `autounattend.xml` into a single Powershell script. 
9. Remove need for the volume license key from `autounattend.xml`.
   - _Build gets stuck because WinRM won't connect without it._ Need to find out why.

