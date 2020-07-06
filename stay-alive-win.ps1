#
#https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.sendkeys?view=netcore-3.1
# h/t https://stackoverflow.com/questions/6298941/how-do-i-find-the-cpu-and-ram-usage-using-powershell/60016244#60016244

$myshell = New-Object -com "Wscript.Shell"

$totalRam = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).Sum

while (1) {
    Start-Sleep -Seconds 10
    $myshell.sendkeys(".")
    #Start-Sleep -Seconds 2
    #$myshell.sendkeys("{BS}")

    $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $cpuTime = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue
    $availMem = (Get-Counter '\Memory\Available MBytes').CounterSamples.CookedValue
    $date + ' > CPU: ' + $cpuTime.ToString("#,0.000") + '%, Avail. Mem.: ' + $availMem.ToString("N0") + 'MB (' + (104857600 * $availMem / $totalRam).ToString("#,0.0") + '%)'

}
