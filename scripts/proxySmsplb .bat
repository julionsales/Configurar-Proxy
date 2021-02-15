$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Connections'
$data = (Get-ItemProperty -Path $key -Name DefaultConnectionSettings).DefaultConnectionSettings
$data[4] = 12
$data[8] = 05
Set-ItemProperty -Path $key -Name DefaultConnectionSettings -Value $data
set-itemproperty -path "hkcu:Software\Microsoft\Windows\CurrentVersion\Internet Settings" -name AutoConfigURL -value "http://pac.prodam/proxy/smsplb.pac" -type string