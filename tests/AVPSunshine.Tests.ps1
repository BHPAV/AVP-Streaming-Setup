Describe 'AVPSunshine module validation' {
    BeforeAll {
        # Ensure the module path is relative to repository structure
        $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\src\AVPSunshine'
        Import-Module $modulePath -Force
    }

    Context 'Sunshine service' {
        It 'Sunshine service should exist' {
            Get-Service -Name 'Sunshine' -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
        }

        It 'Sunshine service startup type should be Automatic' {
            (Get-Service -Name 'Sunshine' -ErrorAction SilentlyContinue).StartType | Should -Be 'Automatic'
        }
    }

    Context 'Firewall configuration' {
        $ports = 47984, 47989, 47990
        foreach ($port in $ports) {
            It "Firewall rule for port $port should exist" {
                Get-NetFirewallRule -DisplayName "AVPSunshine-$port" -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
            }
        }
    }
} 