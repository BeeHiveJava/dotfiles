#!/usr/bin/env pwsh

$InformationPreference = "Continue"
$ErrorActionPreference = "Stop"

Function Invoke-AddToPath($Path, $Scope = "User") {
    If ([Environment]::GetEnvironmentVariable("Path", "$Scope") -notlike "*$Path*") {
        [Environment]::SetEnvironmentVariable("Path", "$([Environment]::GetEnvironmentVariable("Path", "$Scope"));$Path", "$Scope")
    }
}

Function Invoke-RefreshPath() {
    $env:Path =
        [Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
        [Environment]::GetEnvironmentVariable("Path", "User")
}

Function Test-CommandExists($Command, $ExitOnError = $false) {
    $Exists = [boolean] $(Get-Command "$Command" -ErrorAction "SilentlyContinue")

    If ($ExitOnError -And -Not $Exists) {
        Write-Error "> command '$Command' is not found"
        Exit
    }

    Return $Exists
}

Function Invoke-SelfElevateScript() {
    If (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        If ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
            $CommandLine = "-NoExit -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
            Start-Process -Wait -FilePath "pwsh.exe" -Verb Runas -ArgumentList $CommandLine
            Exit
        }
    }
}
