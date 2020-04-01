<#------------------------------------------------------ 
	PowerShell Script 
	update: 1-Apr-20
	(c) 2020 Jan Unger 
	* Backup -> zip
------------------------------------------------------#>
Clear-Host # cls

#---------------------------------------
$thema  = "Ordnerpaket-Notiz" # anpassen
#---------------------------------------

# löschen
if(test-path ../"${thema}.zip"){rm ../"${thema}.zip" -force -recurse}
# zip
Compress-Archive ./ -Update -dest ../"${thema}.zip"
