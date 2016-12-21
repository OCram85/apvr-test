Function Invoke-AppVeyorTests() {
    [CmdletBinding()]
    Param()

    $testResultsFile = ".\TestsResults.xml"
    If (Test-Path -Path $testResultsFile) {
        Remove-Item -Path $testResultsFile -Force
    }
 
    $res = Invoke-Pester -Path ".\tests\*" -OutputFormat NUnitXml -OutputFile $testResultsFile -PassThru
    (New-Object 'System.Net.WebClient').UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", (Resolve-Path $testResultsFile))
    If ($res.FailedCount -gt 0) { 
        Throw "$($res.FailedCount) tests failed."
    }

}

Function Invoke-AppVeyorBuild() {
    [CmdletBinding()]
    Param()

    Get-ChildItem -Path ".\src\*" -Recurse | New-ZipFile -Path 'testbuild.zip'
}

function Invoke-AppVeyorAfterTest() {
    [CmdletBinding()]
    Param()
    $PSVersionTable
}

function Invoke-AppveyorFinish () {
    [CmdletBinding()]
    Param()
    Write-Host ("PSScriptRoot: {0}" -f $PSScriptRoot )
    Write-Host ("PSCmdlet: {0}" -f $PSCmdlet.MyInvocation.PSScriptRoot)
}
#Push-AppveyorArtifact <file_name>