Import-Module $PSScriptRoot\installer-setup.psm1 -Verbose

$extensions = 
    Get-Content "$PSScriptRoot\..\extensions.json" | ConvertFrom-Json

$profiles = 
     Get-Content "$PSScriptRoot\..\profiles.json" | ConvertFrom-Json

foreach($util in $extensions.utils) {
    if($util -is [Array]) {
        Install-GroupedExtensions $util
    } else {
        Install-Extension $util
    }
}

foreach($profile in $profiles) {
    Switch ($profile) {
        "LaTeX" {
            Install-GroupedExtensions $extensions.latex $profile;
            Break
        }
        "laravel" {
            Install-GroupOfGroupedExtensions @(
                $extensions.laravel,
                $extensions.php,
                $extensions.html_xml,
                $extensions.html_css
            ) $profile;
            Break
        }
        "php" {
            Install-GroupOfGroupedExtensions @(
                $extensions.php,
                $extensions.html_xml,
                $extensions.html_css
            ) $profile;
            Break
        }
        "python" {
            Install-GroupedExtensions $extensions.python $profile;
            Break
        }
        "zig" {
            Install-GroupedExtensions $extensions.zig $profile;
            Break
        }
    }
}