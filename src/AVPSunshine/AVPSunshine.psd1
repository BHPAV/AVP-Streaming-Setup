@{
    RootModule = 'AVPSunshine.psm1'
    ModuleVersion = '0.1.0'
    GUID = '12345678-1234-5678-1234-567812345678'
    Author = 'AVP Streaming Setup'
    CompanyName = ''
    Copyright = '(c) 2024'
    Description = 'PowerShell module to install and manage Sunshine for AVP Streaming Setup.'
    PowerShellVersion = '5.1'
    FunctionsToExport = @('Install-AVPSunshine','Enable-AVPSunshineFirewall','Start-AVPSunshineService')
    CmdletsToExport   = @()
    VariablesToExport = '*'
    AliasesToExport   = @()
} 