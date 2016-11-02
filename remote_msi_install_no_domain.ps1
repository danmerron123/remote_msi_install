# Get servers from text file on Desktop
$servers = Get-Content "servers.txt"
# Get credentials needed to access these servers
$credentials = Get-Credential
$path = <PATH HERE>

foreach ($server in $servers){
write-host $server
Invoke-Command -ComputerName $server -credential $credentials -Authentication Negotiate  -ScriptBlock {
            mkdir "$path\update"
            cd $path\update
            Invoke-WebRequest "https://s3.amazonaws.com/ddagent-windows-stable/ddagent-cli.msi" -outfile "$path\update\ddagent.msi"
            sleep -s 10
            #Start-Process "msiexec.exe" -ArgumentList "/i $path\ddagent.msi /quiet /norestart" -Wait
}
}