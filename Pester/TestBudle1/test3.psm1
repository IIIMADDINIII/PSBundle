$global:RunOrder.add("test3")
$global:ArgsFromTest3.add($args[0])
$global:ArgsFromTest3.add($args[1].test.data)
function test3{
}