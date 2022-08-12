function Get-PSCCPstnCall {
    <#
        .SYNOPSIS
        Retrieves PSTN calls between a specified start and end date.

        .DESCRIPTION
        Uses Teams cloud communications Graph API call to retrieve PSTN usage data.
        Requires an Azure application registration with CallRecords.Read.PstnCalls permissions and Graph API access token.

        .PARAMETER StartDate
        The start date to search for records.

        .PARAMETER EndDate
        The end date to search for records.

        .PARAMETER Days
        The previous number of days to search for records.

        .PARAMETER PageSize
        Value of returned result set contains multiple pages of data.

        .EXAMPLE
        Get-PSCCPstnCall -StartDate 2020-03-01 -EndDate 2020-03-31

        This example retrieves PSTN usage records between 2020-03-01 and 2020-03-31 use an access token
        saved to the variable $accessToken.

        .EXAMPLE
        Get-PSCCPstnCall -Days 7 -AccessToken $accessToken

        This example retrieves PSTN usage records for the previous 7 days using an access token saved
        to the variable $accessToken.
    #>
    [OutputType('PSCloudCommunication.Report.PstnCall')]
    [CmdletBinding(DefaultParameterSetName = 'DateRange')]
    param (
        [Parameter(Mandatory = $True, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'DateRange')]
        [DateTime]
        $StartDate,
        [Parameter(Mandatory = $True, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'DateRange')]
        [DateTime]
        $EndDate,
        [Parameter(Mandatory = $True, ParameterSetName = 'NumberDays')]
        [ValidateRange(1, 90)]
        [int]
        $Days,
        [Parameter(Mandatory = $false, ParameterSetName = 'DateRange')]
        [Parameter(Mandatory = $false, ParameterSetName = 'NumberDays')]
        [ValidateNotNullOrEmpty()]
        [ValidateRange(1, 999)]
        [int]
        $PageSize = 100
    )

    begin {
        Assert-RestConnection -Service 'graph' -Cmdlet $PSCmdlet
        $query = @{
            '$select' = ((Get-PSFConfig -Module $script:ModuleName -Name Settings.GraphApiQuery.Select.PstnCalls).Value -join ',')
            '$count'  = 'true'
            '$top'    = $PageSize
        }
    }
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'DateRange' {
                $fromDateTimeString = Get-Date -Date $StartDate -Format yyyy-MM-dd
                $toDateTimeString = Get-Date -Date $EndDate -Format yyyy-MM-dd
            }
            'NumberDays' {
                $today = [datetime]::Today
                $toDateTime = $today.AddDays(1)
                $toDateTimeString = Get-Date -Date $toDateTime -Format yyyy-MM-dd
                $fromDateTime = $today.AddDays( - ($Days - 1))
                $fromDateTimeString = Get-Date -Date $fromDateTime -Format yyyy-MM-dd
                    
            }
        }
        Invoke-RestRequest -Service 'graph' -Path ('communications/callRecords/getPstnCalls(fromDateTime={0},toDateTime={1})' -f $fromDateTimeString, $toDateTimeString) -Query $query -Method Get | ConvertFrom-RestPstnCall
    }
    end {}
}