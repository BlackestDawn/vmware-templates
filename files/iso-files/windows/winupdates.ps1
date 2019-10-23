# Update windows
$Host.UI.RawUI.WindowTitle = "Windows update session...";

Import-Module PSWindowsUpdate;

Add-WUServiceManager -ServiceID 7971f918-a847-4430-9279-4a52d1efe18d -Confirm:$false;
Install-WindowsUpdate -AcceptAll -IgnoreReboot -Confirm:$false;

if( (Test-PendingReboot -SkipConfigurationManagerClientCheck).IsRebootPending ){
 $action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-NoProfile -command ". e:\winupdates.ps1"';
 $trigger =  New-ScheduledTaskTrigger -AtLogon;
 $task = Get-ScheduledTask -TaskName "bootstrap" -ErrorAction SilentlyContinue;
 if(-Not $task){
   Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "bootstrap" -Description "Run Bootstrap again on reboot";
 }
 Restart-Computer;
}

if (Get-ScheduledTask -TaskName "bootstrap")
{
 Unregister-ScheduledTask -TaskName "bootstrap" -Confirm:$false;
}

Write-Output "Ending Windows update session...";
& 'E:\enable-winrm.ps1';
