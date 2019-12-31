$Global:RunOrder = [Collections.ArrayList]@()
$Global:ArgsFromTest3 = [Collections.ArrayList]@()
Import-Module -Name (Join-Path $PSScriptRoot "./test1.psm1")
$null = Import-`Module -Name (Join-Path $PSScriptRoot "./test2.psm1") -AsCustomObject -PassThru
function import {  
  $null = Import-Module -Name (Join-Path $PSScriptRoot "./test3.psm1") -PassThru -ArgumentList "testString", @{test = @{data = 7 } }
  (Join-Path $PSScriptRoot "./test4.psm1"), (Join-Path $PSScriptRoot "./test5.psm1") | Import-Module
  $script:test6 = Import-Module -Name (Join-Path $PSScriptRoot "./test6.psm1") -Scope Local -AsCustomObject
}
import
Import-Module -Name (Join-Path $PSScriptRoot "./test3.psm1") -ArgumentList "testString2"
. (Join-Path $PSScriptRoot "./test8.ps1")

$Commands = (Get-Command).Name

if (!$Commands.Contains("test1")) {
  throw "The Expected Command test1 was not found"
}
if (!$Commands.Contains("test2")) {
  throw "The Expected Command test2 was not found"
}
if (!$Commands.Contains("test3")) {
  throw "The Expected Command test3 was not found"
}
if (!$Commands.Contains("test4")) {
  throw "The Expected Command test4 was not found"
}
if (!$Commands.Contains("test5")) {
  throw "The Expected Command test5 was not found"
}
if ($Commands.Contains("test6")) {
  throw "The Unexpected Command test6 was found"
}
if ($test6.test6 -isnot [System.Management.Automation.PSScriptMethod]) {
  throw "The Function test6 could not be Found on the CustomObject"
}
if ($Commands.Contains("test7")) {
  throw "The Unexpected Command test7 was found"
}
if (($null -eq $args[0]) -or ($args[0] -eq 0)) {
  if (($Global:ArgsFromTest3 -join ";") -ne "testString;7") {
    throw ("The Arguments of test3 were Wrong: " + (($Global:ArgsFromTest3 -join ";")))
  }
  if (($Global:RunOrder -join ";") -ne "test1;test7;test2;test3;test4;test5;test6;test8") {
    throw ("The Runorder of the Modules was Wrong: " + (($Global:RunOrder -join ";")))
  }
} else {
  if (($Global:RunOrder -join ";") -ne "test8") {
    throw ("The Runorder of the Modules was Wrong: " + (($Global:RunOrder -join ";")))
  }
}
