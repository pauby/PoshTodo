﻿<# 
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

function Backup-Todo
{
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [ValidateScript( { Test-Path $_ } )]
        [string]$Path,

        [Parameter(Mandatory)]
        [string]$BackupPath,

        [Parameter(Mandatory)]
        [ValidateRange(1, 999)]
        [int]$DaysToKeep,

        [switch]$Force
    )

    Write-Verbose "Checking that backup path $BackupPath exists."
    if (-not (Test-Path -Path $BackupPath))
    {
        Write-Verbose "Backup path $BackupPath does nto exist. Creating it."
        $error.clear()
        New-Item -Path $BackupPath -ItemType Directory -Force -Verbose:$VerbosePreference
        if (!$?)
        {
            Write-Verbose "Cannot create backup path $BackupPath`nExiting"
            Exit
        }

        Write-Verbose "Backup path $BackupPath created."
    }


    Write-Verbose "Backing up the current todo file $Path to $BackupPath"
    $backupFilename = (Get-Date -Format "yyyyMMdd_HHmmss_") + (Split-Path -Path $Path -Leaf)
    $backupPathname = Join-Path -Path $BackupPath -ChildPath $backupFilename
    $error.Clear()
    Write-Verbose "Copying file $Path to $backupPathname"
    Copy-Item -Path $Path -Destination $backupPathname -Force -Verbose:$VerbosePreference
    if (!$?)
    {
        Write-Verbose "Cannot create a backup of todo file $Path to $backupPathname`nExiting."
        Exit
    }

    # check all other todo files and rmove those older than DaysToKeep
}