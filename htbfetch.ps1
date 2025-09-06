# htbfetch.ps1
# Display system info like neofetch with HackTheBox logo

# ========== HTB ASCII Logo ==========
$htbLogo = @"
H   H   A   CCCCC  K   K     TTTTT  H   H  EEEEE       BBBBB   OOOOO  X   X
H   H  A A  C      K  K        T    H   H  E           B    B  O   O   X X 
HHHHH AAAAA C      KKK         T    HHHHH  EEEE        BBBBB   O   O    X  
H   H A   A C      K  K        T    H   H  E           B    B  O   O   X X 
H   H A   A CCCCC  K   K       T    H   H  EEEEE       BBBBB   OOOOO  X   X
"@




# ========== System Info ==========
$os      = (Get-CimInstance Win32_OperatingSystem).Caption
$version = (Get-CimInstance Win32_OperatingSystem).Version
$hostname = $env:COMPUTERNAME
$user    = "junxian428"
$cert    = "CJCA"
$cpu     = (Get-CimInstance Win32_Processor | Select-Object -First 1 -ExpandProperty Name).Trim()
$ramGB   = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2)
$gpu     = (Get-CimInstance Win32_VideoController | Select-Object -First 1 -ExpandProperty Name).Trim()

# Screen Resolution
$resolutions = (Get-CimInstance Win32_VideoController | 
    ForEach-Object { "$($_.CurrentHorizontalResolution)x$($_.CurrentVerticalResolution)" } |
    Where-Object { $_ -notmatch "x$" } | Select-Object -Unique) -join ", "

# Uptime
$uptime = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
$uptimeSpan = (Get-Date) - $uptime
$uptimeText = "{0}d {1}h {2}m" -f $uptimeSpan.Days, $uptimeSpan.Hours, $uptimeSpan.Minutes

# ========== Output ==========
Write-Host ""
Write-Host $htbLogo -ForegroundColor Green
Write-Host ("User:         {0}" -f $user) -ForegroundColor Cyan
Write-Host ("Certification:{0}" -f $cert) -ForegroundColor Cyan
Write-Host ("Hostname:     {0}" -f $hostname) -ForegroundColor Cyan
Write-Host ("OS:           {0} ({1})" -f $os, $version) -ForegroundColor Cyan
Write-Host ("CPU:          {0}" -f $cpu) -ForegroundColor Cyan
Write-Host ("RAM:          {0} GB" -f $ramGB) -ForegroundColor Cyan
Write-Host ("GPU:          {0}" -f $gpu) -ForegroundColor Cyan
Write-Host ("Resolution:   {0}" -f $resolutions) -ForegroundColor Cyan
Write-Host ("Uptime:       {0}" -f $uptimeText) -ForegroundColor Cyan
Write-Host ""
