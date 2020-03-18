# Скрипт: "Nicinfo"
# Версия: 1.0
# Описание: Выводит поочередно сетевые настройки адаптеров из списка компьютеров, указанных в файле computers.txt
# Для успешной работы скрипта необходимо создать на рабочем столе файл computers.txt и указать там имена хостов (не IP-адреса!!!). 
$user = $env:username
$file = "C:\Documents and Settings\$user\Desktop\computers.txt"
$computers = get-content $file
function ping_computers {
ForEach ($pc in $computers)
{
    if (test-connection -ComputerName $pc -Count 1 -quiet) 
    {
        get_nic_info
    }
    else 
    {
        write-host ""
        write-host "$pc не пингуется. Получение сетевых настроек адаптера невозможно :(" -ForegroundColor Red
        write-host ""
    }
}
}
function get_nic_info {
get-wmiObject -Computer $pc Win32_NetworkAdapterConfiguration -Filter "IPEnabled='$True'" -EA 0 | ForEach {
    write-host ""
    write-host "===Сетевые настройки $pc===" -ForegroundColor Green
    write-host ""
    $NicHash =  @{
    Computername = $_.DNSHostName
    DNSDomain = $_.DNSDomain
    IPAddress = $_.IpAddress
    SubnetMask = $_.IPSubnet
    DefaultGateway = $_.DefaultIPGateway
    DNSServer = $_.DNSServerSearchOrder
    DHCPEnabled = $_.DHCPEnabled
    MACAddress  = $_.MACAddress
    WINSPrimary = $_.WINSPrimaryServer
    WINSSecondary = $_.WINSSecondaryServer
    NICName = $_.ServiceName
    NICDescription = $_.Description
    }
    $NicInfo = new-object PSObject -Property $NicHash
    $NicInfo.PSTypeNames.Insert(0,"NicInfo.Information")
    $NicInfo
    }
}
ping_computers 

