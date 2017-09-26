function Set-Test {
    <#
    .SYNOPSIS
    Set-Test writes some content...

    .DESCRIPTION
    Wow really informative :D

    .PARAMETER Value
    The Value param needs to be a int.

    .EXAMPLE
    Set-Test -Value 4

    .NOTES
    General notes
    #>
    [OutputType([String])]
    [CmdletBinding()]
    Param(
        [int]$Value
    )

    if ($value -le 10 ) {
        return $Value
    }
    else {
        $message = "Didn't execute this line"
        return $message
    }
}
