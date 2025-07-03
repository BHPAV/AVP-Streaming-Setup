<#
.SYNOPSIS
    Module for installing and managing Sunshine service for AVP Streaming Setup.

.DESCRIPTION
    Provides cmdlets to install Sunshine, open firewall rules, and start the service.

.NOTES
    Author: AVP Streaming Setup
    License: MIT
#>

function Install-AVPSunshine {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory = $false)]
        [string]$InstallerUrl = 'https://github.com/LizardByte/Sunshine/releases/latest/download/SunshineSetup.exe',

        [Parameter(Mandatory = $false)]
        [string]$DownloadPath = "$env:TEMP\SunshineSetup.exe"
    )

    if ($PSCmdlet.ShouldProcess("Sunshine", "Install")) {
        Write-Verbose "Downloading Sunshine installer from $InstallerUrl to $DownloadPath"
        Invoke-WebRequest -Uri $InstallerUrl -OutFile $DownloadPath -UseBasicParsing

        Write-Verbose "Running installer..."
        Start-Process -FilePath $DownloadPath -ArgumentList '/SILENT' -Wait
    }
}

function Enable-AVPSunshineFirewall {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [int[]]$Ports = @(47984, 47989, 47990),
        [string]$RuleName = 'AVPSunshine'
    )

    foreach ($port in $Ports) {
        if ($PSCmdlet.ShouldProcess("Firewall", "Open port $port")) {
            New-NetFirewallRule -DisplayName "$RuleName-$port" -Direction Inbound -Action Allow -Protocol TCP -LocalPort $port -Profile Any -ErrorAction SilentlyContinue | Out-Null
        }
    }
}

function Start-AVPSunshineService {
    [CmdletBinding()]
    param(
        [string]$ServiceName = 'Sunshine'
    )

    if (Get-Service -Name $ServiceName -ErrorAction SilentlyContinue) {
        Start-Service -Name $ServiceName
    } else {
        Write-Warning "Service $ServiceName not found."
    }
}

Export-ModuleMember -Function Install-AVPSunshine, Enable-AVPSunshineFirewall, Start-AVPSunshineService 