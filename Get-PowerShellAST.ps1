function Get-PowerShellAST([Parameter(Mandatory=$true,ParameterSetName="Content")][String]$Content, [Parameter(Mandatory=$true,ParameterSetName="File")][String]$File) {
  if ($Null -ne $File) {
    return [System.Management.Automation.Language.Parser]::ParseFile($File, [ref]$Null, [ref]$Null)
  }
  if ($Null -ne $Content) {
    return [System.Management.Automation.Language.Parser]::ParseInput($Content, [Ref]$Null, [Ref]$Null)
  }
  throw "There sould be a File or Content Parameter"
}