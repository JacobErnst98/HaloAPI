function Remove-HaloAction {
    <#
        .SYNOPSIS
           Removes an action from the Halo API.
        .DESCRIPTION
            Deletes a specific action from Halo.
        .OUTPUTS
            A powershell object containing the response.
    #>
    [cmdletbinding( SupportsShouldProcess = $True, ConfirmImpact = "High" )]
    [OutputType([Object])]
    Param(
        # The Action ID
        [Parameter( Mandatory = $True )]
        [int64]$ActionID,
        # The Ticket ID
        [Parameter( Mandatory = $True )]
        [int64]$TicketID
    )
    try {
        $ObjectToDelete = Get-HaloAction -ActionID $ActionID -TicketID $TicketID
        if ($ObjectToDelete) {
            if ($PSCmdlet.ShouldProcess("Action '$($ObjectToDelete.id)' by '$($ObjectToDelete.who)'", "Delete")) {
                $Resource = "api/actions/$($ActionID)?ticket_id=$($TicketID)"
                $ActionResults = New-HaloDELETERequest -Resource $Resource
                Return $ActionResults
            }
        } else {
            Throw "Action was not found in Halo to delete."
        }
    } catch {
        Write-Error "Failed to delete action from the Halo API. You'll see more detail if using '-Verbose'"
        Write-Verbose "$_"
    }
            
}