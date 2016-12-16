$testResultsFile = ".\TestsResults.xml"
If (Test-Path -Path $testResultsFile) {
    Remove-Item -Path $testResultsFile -Force
}
 
$res = Invoke-Pester -Path ".\tests\*" -OutputFormat NUnitXml -OutputFile $testResultsFile -PassThru
(New-Object 'System.Net.WebClient').UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", (Resolve-Path $testResultsFile))
If ($res.FailedCount -gt 0) { 
    Throw "$($res.FailedCount) tests failed."
}
