<#
    .NOTES
    =============================================================================
    Author: j0shbl0ck https://github.com/j0shbl0ck
    Version: 1.0.0
    Date: 01.10.22
    Type: Public
    Source: https://support.mozilla.org/en-US/kb/silently-install-uninstall-firefox-enterprise
    Description: Uninstall Adobe Reader DC without restart.
    =============================================================================
#>

#Removes Adobe Reader DC by product code.
msiexec /x “{AC76BA86-7AD7-1033-7B44-AC0F074E4100}” /q