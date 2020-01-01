function Get-Options([System.Collections.Hashtable]$Options) {
  # Definition of the Default Options
  function GetDefaultOptions() {
    return @{
      EntryFile = [String](Join-Path (Get-Location) "./main.ps1")
    }
  }
  
  # Helper to print the Option Key Path
  function NewCurrentPath([string]$CurrentPath, [String]$Key) {
    if (($Null -eq $CurrentPath) -or ($CurrentPath.Length -eq 0)) {
      return $Key
    }
    return $CurrentPath + "." + $Key
  }

  # Overrides all Options in $Default with data from $Override Recursivly
  function RecursiveMerge($Default, $Override, [String[]]$CurrentPath) {
    if ($Null -eq $Override) { return $Default }
    if ($Override -isnot $Default.GetType()) { throw "The type of The Option $CurrentPath has to be $($Default.GetType())" }
    if ($Default -isnot [System.Collections.Hashtable]) { return $Override }
    $Result = @{}
    foreach ($Key in $Default.Keys) {
      $Result[$Key] = RecursiveMerge -Default $Default[$Key] -Override $Override[$Key] -CurrentPath (NewCurrentPath -CurrentPath $CurrentPath -Key $Key)
    }
    return $Result
  }

  # Helper Funktion to test the Validity of the Result Options
  function PassCheck([String]$Message, [scriptblock]$Test) {
    $Result = $false
    try {
      $Result = $Test.Invoke()
    } finally {
      if (!$Result) {
        throw $Message
      }
    }
  }
  
  # Calculate the Merge from Default Options and the supplied $Options
  $Result = RecursiveMerge -Default (GetDefaultOptions) -Override $Options
  PassCheck -Message "EntryFile Not Found" -Test { Test-Path -Path $Result.EntryFile -PathType Leaf }
  return $Result
}