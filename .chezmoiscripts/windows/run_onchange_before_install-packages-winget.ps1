$Modules = @(
  "PSWindowsUpdate"
)
$Packages = @(
    "7zip.7zip"
    "Armin2208.WindowsAutoNightMode"
    "Balena.Etcher"
    "Bitwarden.Bitwarden"
    "Bitwarden.CLI"
    "Discord.Discord"
    "ElectronicArts.EADesktop"
    "EpicGames.EpicGamesLauncher"
    "Git.Git"
    "GitHub.GitHubDesktop"
    "GOG.Galaxy"
    "Google.Chrome"
    "HandBrake.HandBrake"
    "HumbleBundle.HumbleApp"
    "ItchIo.Itch"
    "Microsoft.DevHome"
    "Microsoft.Office"
    "Microsoft.PowerToys"
    "Microsoft.Teams"
    "Microsoft.VisualStudioCode"
    "Microsoft.WindowsTerminal"
    "Microsoft.WSL"
    "Nvidia.Broadcast"
    "Nvidia.GeForceExperience"
    "Nvidia.PhysX"
    "PathofBuildingCommunity.PathofBuildingCommunity"
    "topgrade-rs.topgrade"
    "twpayne.chezmoi"
    "Ubisoft.Connect"
    "Valve.Steam"
    "WinDirStat.WinDirStat"
    "WiresharkFoundation.Wireshark"
    "Surfshark.Surfshark"
    "Community.PathofBuildingCommunity"
    "Inkscape.Inkscape"
    "GIMP.GIMP"
    "Bitsum.ProcessLasso"
    "Flydigi.FlydigiSpaceStation"
    "LizardByte.Sunshine"
    "Deskflow.Deskflow"
    "WinDirStat.WinDirStat"
    "StartIsBack.StartAllBack"
    "CharlesMilette.TranslucentTB"
    "MartiCliment.UniGetUI"
    "Tailscale.Tailscale"
    "FxSound.FxSound"
    
)

$Base = @{
    '$schema'       = "https://aka.ms/winget-packages.schema.2.0.json"
    "Sources"       = @(
        @{
            "Packages"      = @(
                foreach ($Package in $Packages) {
                    @{
                        PackageIdentifier = $Package
                    }
                }
            )
            "SourceDetails" = @{
                "Argument"   = "https://cdn.winget.microsoft.com/cache"
                "Identifier" = "Microsoft.Winget.Source_8wekyb3d8bbwe"
                "Name"       = "winget"
                "Type"       = "Microsoft.PreIndexed.Package"
            }
        }
    )
    "WinGetVersion" = "1.7.11261"
}

# Install winget packages
$TempFile = $(Get-Item ([System.IO.Path]::GetTempFilename())).FullName # https://github.com/PowerShell/PowerShell/issues/14100#issuecomment-1236428024
Set-Content -Path $TempFile -Value $($Base | ConvertTo-Json -Depth 6)
winget import --accept-package-agreements --accept-source-agreements -i $TempFile
Remove-Item -Path $TempFile -Force

# Install Powershell Modules
Set-PSResourceRepository -Name PSGallery -Trusted | Out-Null
$Modules | ForEach-Object {
  Install-PSResource -Name $_
}
