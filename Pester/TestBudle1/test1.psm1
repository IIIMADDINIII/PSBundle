$global:RunOrder.add("test1")
Import-Module -Name (Join-Path $PSScriptRoot "./test7.psm1")
function test1{
}
Export-ModuleMember -Function test1