﻿    <# 
    .DESCRIPTION
    .NOTES 
        Additional Notes, eg 
        Author		: Paul Broadwith (paul@pauby.com)
	    History		: 1.0 - 25/09/15 - Initial version
        Appears in -full
    .LINK 
        A hyper link, eg 
        http://www.pshscripts.blogspot.com 
        Becomes: "RELATED LINKS"  
        Appears in basic and -Full 
    .PARAMETER Start
    .PARAMETER HighlightDay
	.INPUTS
		Documentary text, eg: 
		Input type  [Universal.SolarSystem.Planetary.CommonSense] 
		Appears in -full 
	.OUTPUTS
		Documentary Text, eg: 
		Output type  [Universal.SolarSystem.Planetary.Wisdom] 
		Appears in -full 
    .EXAMPLE
		
		Show a default display of this month.
    .EXAMPLE

		Display a date range
#>

function Write-TodoInformation
{
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [AllowEmptyCollection()]
        [object[]]$Todo,

        [ValidateNotNullOrEmpty()]
        [hashtable]$Config = $poshTodoConfig
    )

    Write-Verbose "Counting completed todos."
    $todosCompleted = @(($Todo | where { $_.DoneDate -ne "" })).Count
    if ($todosCompleted -gt 0)
    {
        $infoText = "* $todosCompleted completed todos found."
        if ($Config.AutoArchive)
        {
            $infoText += " Completed todos will be automatically archived."
        }

        Write-Host $infoText -ForegroundColor $Config.InfoMsgsColour
    }
}

