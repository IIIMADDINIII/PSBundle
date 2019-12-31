$global:RunOrder.add("test2")
function imp{
  $Script:test7 = Import-Module -Name (Join-Path $PSScriptRoot "./test7.psm1") -Scope Local -AsCustomObject
}
imp
function test2{
}