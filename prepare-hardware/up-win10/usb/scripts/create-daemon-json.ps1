Write-Host "Stopping docker service"
Stop-Service docker

Write-Host "Add configuration to daemon.json"
$daemonJson = "$env:ProgramData\docker\config\daemon.json"
$config = @{}
if (Test-Path $daemonJson) {
  $config = (Get-Content $daemonJson) -join "`n" | ConvertFrom-Json
}
$config = $config | Add-Member(@{ experimental = $true }) -Force -PassThru
$config = $config | Add-Member(@{ labels = @( 'os=windows', 'arch=amd64' ) ] }) -Force -PassThru
$config = $config | Add-Member(@{ group = 'docker' }) -Force -PassThru
$config | ConvertTo-Json | Set-Content $daemonJson -Encoding Ascii

Write-Host "Starting docker service"
Start-Service docker
