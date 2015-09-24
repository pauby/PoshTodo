﻿<# 
.DESCRIPTION
.NOTES 
    Additional Notes, eg 
    Author		: Paul Broadwith (paul@pauby.com)
	History		: 1.0 - 23/09/15 - Initial version
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

function Format-Todo
{
	[CmdletBinding()]
	Param (
			[Parameter(Mandatory,Position=0)]
			[ValidateNotNullOrEmpty()]
			[object[]]$Todo,
			
			[ValidateNotNullOrEmpty()]
			[scriptblock]$Format
	)	

    $Todo | where {$_.DoneDate -eq ""} | Sort-Object -Property @{e="Weight"; Descending=$true}, @{e="Line"; Descending=$False} |  Format-Table -Wrap -Property `
	@{ n='L  '; e={ $_.Line }; Alignment='left'; Width=3; },
	@{ n='Weight'; e={ "{0:N2}" -f $_.Weight }; Alignment='right'; Width=6; },
	@{ n='P'; e={ $_.Priority }; Width=1; },		
	@{ n='Age  '; e={ "{0}d" -f $_.Age }; Width=5; },
	@{ n='Due  '; e={ if ($_.DueIn -ne "") { "{0}d" -f $_.DueIn } }; Width=5; },
	@{ n='Context       '; e={ $_.Context -join "`n" }; Width=15; },
	@{ n='Project       '; e={ $_.Project -join "`n" }; Width=15; },
	@{ n='Task               '; e={ $_.Task } } | Out-String -Stream | Format-Colour

    $todosCompleted = @(($Todo | where { $_.DoneDate -ne "" })).Count
    if ($todosCompleted -gt 0)
    {
        Write-Host "* Todo file needs archived - $todosCompleted completed todos found." -ForegroundColor Magenta
    }

    Write-Host 
}