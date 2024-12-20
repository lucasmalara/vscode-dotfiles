function Install-Extension {
    param (
        [ValidateNotNullOrEmpty()][string]$extensionId,
        $profileName = $null
    )

    $install = ""
    if ($null -ne $profileName) {
        $install += "code --profile $profileName -and "
    }
    $install += "code --install-extension $extensionId"
    Invoke-Expression $install
}

function Install-GroupedExtensions {
    param (
        [ValidateNotNullOrEmpty()][Array]$groupedExtensions, 
        $profileName = $null
    )
    
    foreach($id in $groupedExtensions) {
        Install-Extension $id $profileName
    }
}

function Install-GroupOfGroupedExtensions {
    param (
        [ValidateNotNullOrEmpty()][Array]$groupOfGroupedExtensions, 
        $profileName = $null
    )

    foreach($groupedExtensions in $groupOfGroupedExtensions) {
        Install-GroupedExtensions $groupedExtensions $profileName
    }
}
Export-ModuleMember -Function Install-Extension,
    Install-GroupedExtensions, 
    Install-GroupOfGroupedExtensions