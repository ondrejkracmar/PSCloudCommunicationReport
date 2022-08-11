function Get-PSORTeamsDirectRoutingCall {
    <#
        .SYNOPSIS
        Retrieves direct routing calls between a specified start and end date.

        .DESCRIPTION
        Uses Teams cloud communications Graph API call to retrieve direct routing usage data.
        Requires an Azure application registration with CallRecords.Read.PstnCalls permissions and Graph API access token.

        .OUTPUTS

        .PARAMETER StartDate
        The start date to search for records in YYYY-MM-DD format.

        .PARAMETER EndDate
        The end date to search for records in YYYY-MM-DD format.

        .PARAMETER Days
        The previous number of days to search for records.

        .PARAMETER AccessToken
        An access token for authorization to make Graph API requests.
        Recommended to save this value to a variable for resuse.

        .EXAMPLE
        Get-TeamsDirectRoutingCalls -StartDate 2020-03-01 -EndDate 2020-03-31 -AccessToken $accessToken

        This example retrieves direct routing usage records between 2020-03-01 and 2020-03-31 use an access token
        saved to the variable $accessToken.

        .EXAMPLE
        Get-TeamsDirectRoutingCalls -Days 7 -AccessToken $accessToken

        This example retrieves direct routing usage records for the previous 7 days using an access token saved
        to the variable $accessToken.

        .LINK
        https://docs.microsoft.com/en-us/graph/api/callrecords-callrecord-getdirectroutingcalls

        .NOTES
        The max duration between the StartDate and EndDate is 90 days.
    #>

    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory,
            ParameterSetName = "DateRange",
            HelpMessage = "Start date to search for call records in YYYY-MM-DD format"
        )]
        [string]
        $StartDate,

        [Parameter(
            Mandatory,
            ParameterSetName = "DateRange",
            HelpMessage = "End date to search for call records in YYYY-MM-DD format"
        )]
        [string]
        $EndDate,

        [Parameter(
            Mandatory,
            ParameterSetName = "NumberDays",
            HelpMessage = "The number of days previous to today to search for call records"
        )]
        [ValidateRange(1, 90)]
        [int]
        $Days
    )
    begin {
        
        try {
            $url = Join-UriPath -Uri (Get-GraphApiUriPath) -ChildPath "communications/callRecords"
            $authorizationToken = Receive-PSORAuthorizationToken
            $usageReportFolder = Join-Path -Path (Join-Path -Path $ModuleRoot -ChildPath "internal") -ChildPath 'ortemplate'
            $usageReportFile = Join-Path -Path $usageReportFolder -ChildPath 'Office365Report_Communication_v1.json'
            if (Test-PSFPowerShell -PSMinVersion '7.0.0') {
                $communicationReport = Get-Content -Path $usageReportFile | ConvertFrom-Json -AsHashtable
            }
            else {
                $communicationReport = Get-Content -Path $usageReportFile | ConvertFrom-Json | ConvertTo-HashTable
            }
            $typeName = '{0}.{1}.{2}' -f $Env:ModuleName, 'DirectRoutingCall', $Name
        } 
        catch {
            Stop-PSFFunction -String 'StringAssemblyError' -StringValues $url -ErrorRecord $_
        }
    }
    
    process {
        $headers = @{
            "Authorization" = $AccessToken
        }
        if ($PSCmdlet.ParameterSetName -eq "DateRange") {
            $requestUri = "https://graph.microsoft.com/beta/communications/callRecords/getDirectRoutingCalls(fromDateTime=$StartDate,toDateTime=$EndDate)"
        }
        elseif ($PSCmdlet.ParameterSetName -eq "NumberDays") {
            $today = [datetime]::Today
            $toDateTime = $today.AddDays(1)
            $toDateTimeString = Get-Date -Date $toDateTime -Format yyyy-MM-dd
            $fromDateTime = $today.AddDays( - ($Days - 1))
            $fromDateTimeString = Get-Date -Date $fromDateTime -Format yyyy-MM-dd

            $requestUri = "https://graph.microsoft.com/beta/communications/callRecords/getDirectRoutingCalls(fromDateTime=$fromDateTimeString,toDateTime=$toDateTimeString)"
        }

        while (-not ([string]::IsNullOrEmpty($requestUri))) {
            try {
                $requestResponse = Invoke-RestMethod -Method GET -Uri $requestUri -Headers $headers -ErrorAction STOP
            }
            catch {
                $_
            }

            $requestResponse.value

            if ($requestResponse.'@odata.NextLink') {
                $requestUri = $requestResponse.'@odata.NextLink'
            }
            else {
                $requestUri = $null
            }
        }   
    }
    end {

    }
}