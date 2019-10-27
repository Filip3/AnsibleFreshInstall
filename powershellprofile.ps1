$contentToAdd = "Import-Module posh-git`nImport-Module oh-my-posh`nSet-Theme Paradox`n"

if (!(Test-Path $profile))
{
   New-item -type file -force $profile 
}

$SEL = Select-String -Path $PROFILE -Pattern "Import-Module posh-git" -SimpleMatch -Quiet
If($SEL -ne $true)
{
   $contentToAdd | add-content $profile
}