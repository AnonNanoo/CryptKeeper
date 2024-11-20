

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
    log -logtype 1 -logMessage "Log: Logo printed to console"
    clear-host
    write-host " 
   ______                 __  __ __                         
  / ____/______  ______  / /_/ //_/__  ___  ____  ___  _____
 / /   / ___/ / / / __ \/ __/ ,< / _ \/ _ \/ __ \/ _ \/ ___/
/ /___/ /  / /_/ / /_/ / /_/ /| /  __/  __/ /_/ /  __/ /    
\____/_/   \__, / .___/\__/_/ |_\___/\___/ .___/\___/_/     
          /____/_/                      /_/                                                                                                          
                                                  ($ProjectVersion)
===========================================================" -ForegroundColor blue
    Write-Host "`nWelcome to CryptKeeper!`n"
    Write-Host "Booting CryptKeeper" -NoNewline
    [int] $i = 0
    do {
        $i++
        Start-Sleep -Seconds 0.5
        Write-Host "." -NoNewline
    }until ($i -eq 3)
    Write-Host "`n"
}


function menu{

}
logo

