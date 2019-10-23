# base setup
$ErrorActionPreference = "Inquire";
Set-ExecutionPolicy Unrestricted;

$Host.UI.RawUI.WindowTitle = "Minimum base installation...";
# Remove bootstrapper-task
#if (Get-ScheduledTask -TaskName "bootstrap")
#{
# Unregister-ScheduledTask -TaskName "bootstrap" -Confirm:$false
#}

# Make sure NuGet is installed and above a specific version
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Confirm:$false;

# Install Chocolatey for easier installation of software, and used by Ansible
$env:chocolateyUseWindowsCompression = 'false';
Invoke-WebRequest -Uri 'https://chocolatey.org/install.ps1' -UseBasicParsing | Invoke-Expression;

# make sure we have PowerShell 5
if ($PSVersionTable.PSVersion.Major -le 4)
{
  Write-Output "Installing Newer Version of PowerShell";
  choco install powershell -y;
}
else
{
  Write-Output "Not installing PowerShell as it is 5+";
}

# Install VMware tools, not just drivers
C:\ProgramData\chocolatey\choco.exe install -y kb2999226;
C:\ProgramData\chocolatey\choco.exe install -y vmware-tools;

# Some other useful tools
Install-Module -Name PSWindowsUpdate -Force -Confirm:$false;
Install-Module -Name PendingReboot -Force -Confirm:$false;

# Disable UAC and some remoting things
Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0
#Set-Item WSMan:\localhost\Client\TrustedHosts -Value <hostname>

# Handing over to remoting
Write-Output "Minimum base installed, handing over to update routine";

& 'E:\winupdates.ps1';
