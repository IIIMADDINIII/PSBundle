. (Join-Path $PSScriptRoot "./Get-Options.ps1")
. (Join-Path $PSScriptRoot "./Get-PowershellAST.ps1")

function Build-Package([System.Collections.Hashtable]$Options) {
  $Options = Get-Options -Options $Options
  $AST = Get-PowerShellAST -File $Options.EntryFile
}

Export-ModuleMember -Function Build-Package