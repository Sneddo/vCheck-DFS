# Start of Settings
# End of Settings

# Find all member servers in DFS-R RG
$DFSMember = $script:RGs | Select-Object -ExpandProperty Members | Sort-Object -Unique

$Services = @("DFS", "DFSR")

$issues = @()

foreach ($Server in $DFSMember)
{
	# Start with the basics, can you ping the server
	if (-not (Test-connection -ComputerName $Server -Count 1 -Quiet))
	{
		$issues += @{"Server" = $Server; "Issue"="Server is not pingable"}
	}

	# Check DFS Services are running
	$ServiceStatus = Get-Service -ComputerName CSODFS1 | Where { ($Services -contains $_.Name) -and $_.Status -ne "Running"}
	foreach ($svc in $ServiceStatus)
	{
		$issues += @{"Server" = $Server; "Issue"=("Service is not running: {0}" -f $svc.DisplayName)}
	}
	
	# Check diskspace
	
	# Eventlogs
	
	# Sharing violations?
}

$issues 

$Title = "Health issues for DFS Member servers"
$Header =  "Health issues for DFS Member servers"
$Comments = ""
$Display = "Table"
$Author = "John Sneddon"
$PluginVersion = 1.0
$PluginCategory = "DFS"