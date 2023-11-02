function ConvertFrom-RestPstnCall {
    <#
	.SYNOPSIS
		Converts Pstn Calls to look nice.

	.DESCRIPTION
		Converts Pstn Calls to look nice.

	.PARAMETER InputObject
		The rest response representing a Pstn Calls

	.EXAMPLE
	    PS C:\> Invoke-RestRequest -Service 'graph' -Path ('communications/callRecords/getPstnCalls(fromDateTime={0},toDateTime={1})' -f $fromDateTimeString, $toDateTimeString) -Query $query -Method Get | ConvertFrom-RestPstnCall
		Retrieves the specified Pstn Calls and converts it into something userfriendly
	#>
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true)]
        $InputObject
    )

    process {

        [PSCustomObject]@{
            PSTypeName         = 'PSCloudCommunication.Report.PstnCall'
            Id = $InputObject.id
            CallId = $InputObject.callId
            UserId = $InputObject.userId
            UserPrincipalName = $InputObject.userPrincipalName
            UserDisplayName = $InputObject.userDisplayName
            StartDateTime = $InputObject.startDateTime
            EndDateTime = $InputObject.endDateTime
            Duration = $InputObject.duration
            Charge = $InputObject.charge
            CallType = $InputObject.callType
            Currency = $InputObject.currency
            CalleeNumber = $InputObject.calleeNumber
            UsageCountryCode = $InputObject.usageCountryCode
            TenantCountryCode = $InputObject.tenantCountryCode
            ConnectionCharge = $InputObject.connectionCharge
            CallerNumber = $InputObject.callerNumber
            DestinationContext = $InputObject.destinationContext
            DestinationName = $InputObject.destinationName
            ConferenceId = $InputObject.conferenceId
            LicenseCapability = $InputObject.licenseCapability
            InventoryType = $InputObject.inventoryType
            Operator = $InputObject.operator
            CallDurationSource = $InputObject.callDurationSource
        }

    }
}