﻿<# 
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

function Export-Todo
{
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory, ParameterSetName="Objects")]
        [ValidateNotNullOrEmpty()]
        [object[]]$TodoObject,

        [Parameter(Mandatory, ParameterSetName="Strings")]
        [string[]]$TodoString,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Path,

        [switch]$Append
    )

    if (-not $Append)
    {
        Write-Verbose "Deleting todo file $Path"
        Remove-Item -Path $Path -Force
        Write-Verbose "File $Path deleted."
    }

    Write-Verbose "Appending todo to the todo file at $Path"

    $toBeWritten = @()
    if ($TodoObject)
    {
        Write-Verbose "We have todo objects to export."

        foreach ($todo in $TodoObject)
        {
            Write-Verbose "Converting todo object to a string so we can write it to the todo file."
            $toBeWritten += ConvertTo-TodoString $todo
        }
    }
    else
    {
        Write-Verbose "We have todo strings to export."
        $toBeWritten = $TodoString
    }

    try
    {
        $toBeWritten | Add-Content -Path $Path -Encoding UTF8 -Force -ErrorAction SilentlyContinue
    }
    catch
    {
        Write-Warning "Could not write new todo to the todo file at $Path."
        Exit
    }
}
