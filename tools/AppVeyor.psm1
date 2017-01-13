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
        #Get-ChildItem -Path ".\src\*" -Recurse | New-ZipFile -Path 'testbuild.zip'
        7z a myapp.zip ("{0}\src\*" -f $env:APPVEYOR_BUILD_FOLDER)
        Push-AppveyorArtifact myapp.zip
}

Function Invoke-AppVeyorPSGallery() {
    [CmdletBinding()]
    Param()

    If ($env:APPVEYOR_REPO_BRANCH -eq 'master') {
        Expand-Archive -Path '.\myapp.zip' -DestinationPath 'C:\Users\appveyor\Documents\WindowsPowerShell\Modules\apvr-test\' -Verbose
        Import-Module -Name 'apvr-test' -Verbose
        Publish-Module -Name 'apvr-test' -NuGetApiKey $env:NuGetToken -Verbose 
    }
}
