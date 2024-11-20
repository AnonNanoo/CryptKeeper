

[string] $ProjectName = "CryptKeeper"
[string] $ProjectVersion = "0.0.0.1"
[string] $Tempfolder = [Environment]::GetFolderPath( 'LocalApplicationData' ) + "\CryptKeeper"



$colors = @{
    "red"      = "`e[31m"  # Red
    "green"    = "`e[32m"  # Green
    "yellow"   = "`e[33m"  # Yellow
    "blue"     = "`e[34m"  # Blue
    "magenta"  = "`e[35m"  # Magenta
    "cyan"     = "`e[36m"  # Cyan
    "white"    = "`e[37m"  # White
    "reset"    = "`e[0m"   # Reset color
}



function Main {
    Clear-Host

     # Prompt user for inputs
     Write-Host "Enter the path to the input file (file to be encrypted)" -ForegroundColor Yellow
     [string]$inputPath = Read-Host
     Write-Host "`nEnter the path to the output file (where the encrypted file will be saved)" -ForegroundColor Yellow
     [string]$outputPath = Read-Host
 
     Write-Host "`nEnter the password for encryption" -ForegroundColor Cyan
     [string]$password = Read-Host
 
    $inputExists = Test-Path $inputPath
    $outputExists = Test-Path $outputPath
    $passwordExists = $password.Length -ge 3

    if (-not $inputExists -or -not $outputExists -or -not $passwordExists) {
        if (-not $inputExists) {
            Write-Host "`nInput file does not exist.`n" -ForegroundColor Red
        }
        if (-not $outputExists) {
            Write-Host "`nOutput file does not exist.`n" -ForegroundColor Red
        }
        if (-not $passwordExists) {
            Write-Host "`nPassword must be at least 3 characters long.`n" -ForegroundColor Red
            
        }

        Write-Host "Press any key to return..." -ForegroundColor Yellow
        read-host

        $inputExists = $null
        $outputExists = $null
        $passwordExists = ""
        main
        return
    }

    # Read the input file
   

    Write-Host $inputPath -ForegroundColor Green
    Write-Host $outputPath -ForegroundColor Green
    Write-Host $password -ForegroundColor Green

    # Somehow generate an IV (Initialization Vector) -> convert to secure string -> key from that -> AES encryption object must be created....

  

    Write-host "Encryption complete."

}


function logo {
    # This function prints the logo and welcome message to the console.
    clear-host
    Write-Host "   ______                 __  __ __                         " 
    Start-Sleep -Seconds 0.3
    Write-Host "  / ____/______  ______  / /_/ //_/__  ___  ____  ___  _____" 
    Start-Sleep -Seconds 0.3
    Write-Host " / /   / ___/ / / / __ \/ __/ ,< / _ \/ _ \/ __ \/ _ \/ ___/" 
    Start-Sleep -Seconds 0.3
    Write-Host "/ /___/ /  / /_/ / /_/ / /_/ /| /  __/  __/ /_/ /  __/ /    " 
    Start-Sleep -Seconds 0.3
    Write-Host "\____/_/   \__, / .___/\__/_/ |_\___/\___/ .___/\___/_/     " 
    Start-Sleep -Seconds 0.3
    Write-Host "          /____/_/                      /_/                 "

    Write-Host "                                                ($ProjectVersion)"
    #Write-Host "===========================================================" -ForegroundColor blue
    [int] $i = 0
    do{
        $i++
        Start-Sleep -Milliseconds 5
        Write-Host "=" -NoNewline -ForegroundColor blue
    }until ($i -eq 60)
    Write-Host "`nWelcome to CryptKeeper!`n"
    Write-Host "Booting CryptKeeper" -NoNewline

    [int] $i = 0
    do {
        $i++
        Start-Sleep -Seconds 1
        Write-Host "." -NoNewline
    }until ($i -eq 3)
    Write-Host "`n"
}


function menu{
    do {
        log -logtype 1 -logMessage "Log: Menu opened"
        clear-host
        Write-Host "`n==========================================="
        Write-Host "| $ProjectName (ver.$ProjectVersion)                  |"
        Write-Host "|_________________________________________|"
        Write-Host "| (1) Encrypt now                         |"
        Write-Host "|                                         |"
        Write-Host "| (99) Exit                               |"
        Write-Host "|_________________________________________|`n"
        $menuinput = read-host "Please select an option"
        switch ( $menuinput ) {
            1 {
                log -logtype 1 -logMessage "Log: Sync started"
                PreSync
            }

            95 {
                Write-Host "READ BEFORE YOU ENTER`nYou are about to remove all information.`n`nIf you restart the script, you will be asked to reconfigure the settings and the script will automatically create the resource folders again." -ForegroundColor Red
                $u_sure = Read-Host "`nAre you sure? (y/n)"
                if ( $u_sure -eq "y" ) {
                    try {
                        Remove-Item -Path $Tempfolder -Recurse -Force
                    }
                    catch {
                        Write-Host "Error: Removing the Tempfolder failed. Going back to Menu`nYou try to remove the folder manually. Path: $Tempfolder" -ForegroundColor Red
                        Start-Sleep -Seconds 4
                        menu
                    }
                    Write-Host "`nAll Information removed. Exiting in 3 seconds..." -ForegroundColor Green
                    Start-Sleep -Seconds 3
                    exit
                }
                else {
                    Write-Host "`nAborted. Going back to Menu in 1 second..." -ForegroundColor Red
                    Start-Sleep -Seconds 1
                }
            }
            99 {
                Write-Host "Bye!"
                Start-Sleep -Seconds 1
                exit
            }
            default {
                log -logtype 1 -logMessage "Log: Invalid input in Menu"
                write-host "Invalid input. Try again"
                Write-host "To exit, enter 99" -ForegroundColor Red
                Start-Sleep -Milliseconds 1500
            }
        }
        $menuinput = 0
    }until (0 -eq 1)

}
logo

