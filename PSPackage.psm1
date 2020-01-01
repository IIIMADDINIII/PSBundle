. (Join-Path $PSScriptRoot "./Get-Options.ps1")

function Build-Package([System.Collections.Hashtable]$Options) {
  $Options = Get-Options -Options $Options
}

Export-ModuleMember -Function Build-Package