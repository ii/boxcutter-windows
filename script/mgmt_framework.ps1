if ($PSVersionTable.PSVersion.Major -le 4)
{
    if( -Not $env:MGMT_FRAMEWORK5_URL){
        $env:MGMT_FRAMEWORK5_URL = "https://download.microsoft.com/download/2/C/6/2C6E1B4A-EBE5-48A6-B225-2D2058A9CEFB/Win8.1AndW2K12R2-KB3134758-x64.msu" }

    if( -Not $env:MGMT_FRAMEWORK5_FILE){
        $env:MGMT_FRAMEWORK5_FILE = "C:\" + [io.path]::GetFileNameWithoutExtension(
            $env:MGMT_FRAMEWORK5_URL)
    }

    if( -Not $env:MGMT_FRAMEWORK5_SHA){
        $env:MGMT_FRAMEWORK5_SHA = "7e8778610bfe23d9eea8bea1d396a399455d7bda"
    }

    invoke-webrequest $env:MGMT_FRAMWORK5_URL -outfile $env:MGMT_FRAMWORK5_FILE

    start-process wusa -ArgumentList $env:MGMT_FRAMWORK5_FILE, "/quiet", "/norestart" -wait
    # if(test-path $env:MGMT_FRAMWORK5_FILE){remove-item $env:MGMT_FRAMWORK5_FILE}
}
