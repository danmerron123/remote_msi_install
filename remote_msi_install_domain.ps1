$WebClient = New-Object System.Net.WebClient
$path = <PATH HERE>
$servers_v1 = get-ADComputer -Filter { Name -like "*"} | foreach { $_.Name }
foreach ($server in $servers) {
write-host ""
write-host "####################"
 $server 
    If (Test-Connection -count 2 -quiet $Server) { 
        Invoke-Command -Authentication Negotiate -computername $server -scriptblock {
            mkdir "$path\update"
            cd $path\update
            Invoke-WebRequest "https://s3.amazonaws.com/ddagent-windows-stable/ddagent-cli.msi" -outfile "$path\update\ddagent.msi"
            sleep -s 10
            #Start-Process "msiexec.exe" -ArgumentList "/i $path\update\ddagent.msi /quiet /norestart" -Wait
    }
}
}