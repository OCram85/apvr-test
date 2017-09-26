function Get-Test {
    <#
    .SYNOPSIS
    Get-Test return some content for testing.

    .DESCRIPTION
    This represents a awesome description

    .PARAMETER Value
    Describes the Value param

    .EXAMPLE
    Get-Test -Value 'Foooobar!!!'

    .NOTES
    Hope this works.

    #>
    [OutputType([String])]
    [CmdletBinding()]
    Param (
        [String]$Value
    )
    return $Value
}
