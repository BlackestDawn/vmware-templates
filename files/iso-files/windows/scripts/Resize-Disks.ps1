# Script to resize all disks/partitions after extending them in VMware

$diskTab = @{}

foreach($disk in (Get-CimInstance -ComputerName $compName -ClassName Win32_DiskDrive)){
  foreach($partition in (Get-CimAssociatedInstance -InputObject $disk -ResultClassName Win32_DiskPartition)){
      Get-CimAssociatedInstance -InputObject $partition -ResultClassName Win32_LogicalDisk | ForEach-Object{
          $diskTab.Add($disk.index,$($_.DeviceID -replace ':',''))
      }
  }
}

foreach($line in $diskTab.keys) {
  Update-Disk -Number $line;

  $size = (Get-PartitionSupportedSize -DriveLetter $diskTab.$line);
  Resize-Partition -DriveLetter $diskTab.$line -Size $size.SizeMax -ErrorAction SilentlyContinue;
}