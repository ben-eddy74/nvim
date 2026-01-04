param(
  [switch]$Force
  )

$path = "~\github_nvim_sync.xml"

$run_sync = $false

if(Test-Path -Path $path)
{
  $lastrun = Import-Clixml -Path $path
  $run_sync = (New-TimeSpan -Start $lastrun -End (Get-Date)).TotalHours -gt 5
}
else
{
  Get-Date | Export-Clixml -Path $path
  $run_sync = $true
}

if($run_sync -or $Force.IsPresent)
{
  Write-Host "Syncing nvim config from GitHub"

  $CurrentLocation = Get-Location

  Set-Location ~\AppData\Local\nvim

  & git fetch
  & git pull

  Set-Location $CurrentLocation.Path

  Get-Date | Export-Clixml -Path $path
}
else
{
  Write-Host "Skipping for now"
}

