$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
$sut = $sut -replace "^\d{2}_",''
$srcfile  = "{0}\{1}\{2}" -f (Get-Item -Path $here).Parent.FullName, 'src', $sut
. $srcfile

Describe "Get-Something" {
    Context "Basic Logic Tests" {
        It "Test 1: Should work" {
            Get-Something | Should Be "Get some text"
        }

        It "Test2: Should fail" {
            Get-Something | Should Not Be $False
        }
    }
}