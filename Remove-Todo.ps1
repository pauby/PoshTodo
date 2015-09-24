﻿    <# 
    .DESCRIPTION
    .NOTES 
        Additional Notes, eg 
        Author		: Paul Broadwith (paul@pauby.com)
	    History		: 1.0 - 24/09/15 - Initial version
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

function Remove-Todo
{
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [ValidateRange(1,65535)]
        [int[]]$LineNums,

        [ValidateNotNullOrEmpty()]
        [string]$Path = $poshTodoConfig['todoTaskFile']
    )

    Write-Verbose "Importing all todos from $Path"
    $sourceTodos = Import-Todo -Path $Path
    if ($sourceTodos -eq $null)
    {
        Write-Verbose "Could not read todos from $Path"
        Exit
    }

    Write-Verbose "Read $($sourceTodos.Count) todos."
    Write-Verbose "Creating a new todo list skipping over the one to be removed."
    $destTodos = $sourceTodos | where-object { $LineNums -notcontains $_.Line }
    Write-Verbose "After removing the todos we now have $($destTodos.Count)."

    Write-Verbose "New todo list is now $($destTodos.Count) lines long (original list was $($sourceTodos.Count) lines long)."
    
    Export-Todo -TodoObject $destTodos -Path $Path -Verbose:$VerbosePreference
}