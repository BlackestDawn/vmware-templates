# Setting permissions on SSH authorized_keys file

$sshFolder="$env:USERPROFILE\.ssh";
$acl = Get-Acl "$sshFolder";
$acl.SetAccessRuleProtection($true,$false);
$acl.SetOwner([System.Security.Principal.NTAccount] $env:USERNAME); #Set the current user as owner
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule($env:USERNAME,'FullControl','Allow');
$acl.AddAccessRule($rule);
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule('SYSTEM','FullControl','Allow'); #Set system account as also having access
$acl.AddAccessRule($rule);
Set-Acl "$sshFolder" $acl | Out-Null;