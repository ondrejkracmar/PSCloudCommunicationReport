﻿@{
	# Script module or binary module file associated with this manifest
	RootModule        = 'PSCloudCommunicationReport.psm1'
	
	# Version number of this module.
	ModuleVersion     = '1.0.0.1'
	
	# ID used to uniquely identify this module
	GUID              = 'a069a4e9-1b68-4a04-b2a4-fc56095ebcb6'
	
	# Author of this module
	Author            = 'KracmarOndrej'
	
	# Company or vendor of this module
	CompanyName       = 'MyCompany'
	
	# Copyright statement for this module
	Copyright         = 'Copyright (c) 2022 KracmarOndrej'
	
	# Description of the functionality provided by this module
	Description       = 'Working with the cloud communications API in Microsoft Graph'
	
	# Minimum version of the Windows PowerShell engine required by this module
	PowerShellVersion = '5.0'
	
	# Modules that must be imported into the global environment prior to importing
	# this module
	RequiredModules   = @('PSFramework','RestConnect')
	
	# Assemblies that must be loaded prior to importing this module
	# RequiredAssemblies = @('bin\PSCloudCommunicationReport.dll')
	
	# Type files (.ps1xml) to be loaded when importing this module
	# TypesToProcess = @('xml\PSCloudCommunicationReport.Types.ps1xml')
	
	# Format files (.ps1xml) to be loaded when importing this module
	# FormatsToProcess = @('xml\PSCloudCommunicationReport.Format.ps1xml')
	
	# Functions to export from this module
	FunctionsToExport = @(
		'Connect-PSCloudCommunicationReport',
		'Get-PSCCDirectRoutingCall',
		'Get-PSCCPstnCall'
	)
	
	# Cmdlets to export from this module
	CmdletsToExport   = ''
	
	# Variables to export from this module
	VariablesToExport = ''
	
	# Aliases to export from this module
	AliasesToExport   = ''
	
	# List of all modules packaged with this module
	ModuleList        = @()
	
	# List of all files packaged with this module
	FileList          = @()
	
	# Private data to pass to the module specified in ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
	PrivateData       = @{
		
		#Support for PowerShellGet galleries.
		PSData = @{
			
			# Tags applied to this module. These help with module discovery in online galleries.
			Tags = @('rest', 'Azure','CLoud','Communication','PSTN','Meeting','Call')
			
			# A URL to the license for this module.
			# LicenseUri = ''
			
			# A URL to the main website for this project.
			# ProjectUri = ''
			
			# A URL to an icon representing this module.
			# IconUri = ''
			
			# ReleaseNotes of this module
			# ReleaseNotes = ''
			ExternalModuleDependencies = @("PSFramework",  "RestConnect")
		} # End of PSData hashtable
		
	} # End of PrivateData hashtable
}