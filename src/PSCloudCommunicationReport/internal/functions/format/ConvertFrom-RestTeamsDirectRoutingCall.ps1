function ConvertFrom-RestTeamsDirectRoutingCall {
	<#
	.SYNOPSIS
		Converts Microsoft 365 Usage report objects to look nice.

	.DESCRIPTION
		Converts Microsoft 365 Usage report objects to look nice.

	.PARAMETER InputObject
		The rest response representing a Microsoft 365 Usage report

	.EXAMPLE
		PS C:\> Invoke-RestRequest -Service graph -Path (communications/callRecords/getDirectRoutingCalls(fromDateTime={0},toDateTime={1}) -f $fromDateTimeString, $toDateTimeString) -Query $query -Method Get | ConvertFrom-RestTeamsDirectRoutingCall
		Retrieves the specified Microsoft 365 Usage report and converts it into something userfriendly
	#>
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true)]
        $InputObject
    )

    process {

        [PSCustomObject]@{
            PSTypeName                    = 'PSCloudCommunication.Report.DirectRoutingCall'
            Id                            = $InputObject.id
            CorrelationId                 = $InputObject.correlationId
            UserId                        = $InputObject.userId
            UserPrincipalName             = $InputObject.userPrincipalName
            UserDisplayName               = $InputObject.userDisplayName
            StartDateTime                 = $InputObject.startDateTime
            InviteDateTime                = $InputObject.inviteDateTime
            FailureDateTime               = $InputObject.failureDateTime
            EndDateTime                   = $InputObject.endDateTime
            Duration                      = $InputObject.duration
            CallType                      = $InputObject.callType
            SuccessfulCall                = $InputObject.successfulCall
            callerNumber                  = $InputObject.CallerNumber
            CalleeNumber                  = $InputObject.calleeNumber
            MediaPathLocation             = $InputObject.mediaPathLocation
            SignalingLocation             = $InputObject.signalingLocation
            FinalSipCode                  = $InputObject.finalSipCode
            CallEndSubReason              = $InputObject.callEndSubReason
            FinalSipCodePhrase            = $InputObject.finalSipCodePhrase
            TrunkFullyQualifiedDomainName = $InputObject.trunkFullyQualifiedDomainName
            MediaBypassEnabled            = $InputObject.mediaBypassEnabled
        }
    }
}