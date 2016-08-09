if( $PSVersionTable.PSVersion.Major -le 4 -and -Not  (Get-Hotfix KB3134758))
{
    if( -Not $env:MGMT_FRAMEWORK5_URL){
        $env:MGMT_FRAMEWORK5_URL = "https://download.microsoft.com/download/2/C/6/2C6E1B4A-EBE5-48A6-B225-2D2058A9CEFB/Win8.1AndW2K12R2-KB3134758-x64.msu" }
    if( -Not $env:MGMT_FRAMEWORK5_FILE){
        $env:MGMT_FRAMEWORK5_FILE = "C:\" + [io.path]::GetFileName($env:MGMT_FRAMEWORK5_URL)
    }
    if( -Not $env:MGMT_FRAMEWORK5_CHECKSUM_TYPE){
        $env:MGMT_FRAMEWORK5_CHECKSUM_TYPE = "SHA1"
    }
    if( -Not $env:MGMT_FRAMEWORK5_CHECKSUM){
        $env:MGMT_FRAMEWORK5_CHECKSUM = "7e8778610bfe23d9eea8bea1d396a399455d7bda"
    }
    if( -Not (test-path $env:MGMT_FRAMEWORK5_FILE)){
        invoke-webrequest $env:MGMT_FRAMEWORK5_URL -outfile $env:MGMT_FRAMEWORK5_FILE
    }
    $checksum = ( Get-FileHash -Algorithm $env:MGMT_FRAMEWORK5_CHECKSUM_TYPE $env:MGMT_FRAMEWORK5_FILE ).hash
    if ($checksum -eq $env:MGMT_FRAMEWORK5_CHECKSUM) {
        start-process wusa -ArgumentList $env:MGMT_FRAMEWORK5_FILE, "/quiet", "/norestart" -wait
    }
    else {
        Write-Host "Checksum doesn't match!"
        exit 1
    }
    if(test-path $env:MGMT_FRAMEWORK5_FILE){remove-item $env:MGMT_FRAMEWORK5_FILE}
}
