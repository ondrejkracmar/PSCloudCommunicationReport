function ConvertFrom-RestTeamsDirectRoutingCall {
    <#
	.SYNOPSIS
		Converts Teams Direct Routing Call to look nice.
	
	.DESCRIPTION
		Converts Teams Direct Routing Call to look nice.
	
	.PARAMETER InputObject
		The rest response representing a Teams Direct Routing Call
	
	.EXAMPLE
		PS C:\>  Invoke-RestRequest -Service graph -Path (communications/callRecords/getDirectRoutingCalls(fromDateTime={0},toDateTime={1}) -f $fromDateTimeString, $toDateTimeString) -Query $query -Method Get  | ConvertFrom-RestPstnCall
		Retrieves the specified Teams Direct Routing Call and converts it into something userfriendly
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