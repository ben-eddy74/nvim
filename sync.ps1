$CurrentLocation = Get-Location

Set-Location ~\AppData\Local\nvim

& git fetch
& git pull

Set-Location $CurrentLocation.Path

