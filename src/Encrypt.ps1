
# Variables
[int] $menuinput # User input for menu selection
[string] $syncoptions # Sync options

# Project related variables
[string] $ProjectName = "CryptKeeper"
[string] $ProjectVersion = "0.0.0.1"
[string] $Tempfolder = [Environment]::GetFolderPath( 'LocalApplicationData' ) + "\CryptKeeper"

# Source and destination paths for file synchronization
[string] $inputPath = ""
[string] $outputPath = ""

# Password for encryption
[string]$password = ""

# File paths for settings and logs
[string] $settingsFilePath = "$Tempfolder\Settings.dll"
[string] $ErrorLogFilePath = "$Tempfolder\ErrorLog.log"
[string] $logFilePath = "$Tempfolder\FileSync.log"
[string] $logMessage
[int] $corrupted

function encrypt {
    Clear-Host

     # Prompt user for inputs
     Write-Host "Enter the path to the input file (file to be encrypted)" -ForegroundColor Yellow
     $inputPath = Read-Host
     Write-Host "`nEnter the path to the output file (where the encrypted file will be saved)" -ForegroundColor Yellow
     $outputPath = Read-Host
 
     Write-Host "`nEnter the password for encryption" -ForegroundColor Cyan
     $password = Read-Host
 
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

        $inputExists = ""
        $outputExists = ""
        $passwordExists = ""
        encrypt
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
    [double] $time = 0.15
    clear-host
    Write-Host "   ______                 __  __ __                         " 
    Start-Sleep -Seconds $time
    Write-Host "  / ____/______  ______  / /_/ //_/__  ___  ____  ___  _____" 
    Start-Sleep -Seconds $time
    Write-Host " / /   / ___/ / / / __ \/ __/ ,< / _ \/ _ \/ __ \/ _ \/ ___/" 
    Start-Sleep -Seconds $time
    Write-Host "/ /___/ /  / /_/ / /_/ / /_/ /| /  __/  __/ /_/ /  __/ /    " 
    Start-Sleep -Seconds $time
    Write-Host "\____/_/   \__, / .___/\__/_/ |_\___/\___/ .___/\___/_/     " 
    Start-Sleep -Seconds $time
    Write-Host "          /____/_/                      /_/                 "
    Start-Sleep -Seconds $time
    Write-Host "                                                  ($ProjectVersion)"
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
        clear-host
        Write-Host "`n==========================================="
        Write-Host "| $ProjectName (ver.$ProjectVersion)               |"
        Write-Host "|_________________________________________|"
        Write-Host "| (1) Encrypt now                         |"
        Write-Host "| (2) Open Log                            |"
        Write-Host "| (3) Sourcecode                          |"
        Write-Host "|                                         |"
        Write-Host "| (99) Exit                               |"
        Write-Host "|_________________________________________|`n"
        $menuinput = read-host "Please select an option"
        switch ( $menuinput ) {
            1 {
                
            }
            2{
                printLog
            }
            3{
                printSourceCode
            }
            99 {
                Write-Host "Bye!"
                Start-Sleep -Seconds 1
                exit
            }
            default {
                Write-host "Invalid input. Try again"
                Write-host "To exit, enter 99" -ForegroundColor Red
                Start-Sleep -Milliseconds 1500
            }
        }
        $menuinput = 0
    }until (0 -eq 1)

}

function printSourceCode {
    clear-host
    Write-Host "Source code for CryptKeeper" -ForegroundColor Yellow
    Write-Host "=============================" -ForegroundColor Yellow
    Write-Host "`n"
    Write-Host "https://github.com/AnonNanoo/CryptKeeper/src/Encrypt.ps1"
    Write-Host "`n"
    Write-Host "Press any key to return to the menu..." -ForegroundColor Yellow
    read-host
    menu
}


function log {
    # This function logs messages to the log file or error log file based on the given log type.
    param(
        [int]$logtype,
        [string]$logMessage
    )
    try {
        if ( (test-path -path $logFilePath ) -and $logtype -eq 1 ) {    # 1 is for normal log
            [string] $timestamp = Get-Date -Format  "dd-MM-yyyy HH:mm.sss" 
            $logMessage = $logMessage + " at $timestamp"
            $logMessage | Out-File -FilePath $logFilePath -Append -Encoding utf8
        }
        elseif ((test-path -path $ErrorLogFilepath ) -and $logtype -eq 2) {   # 2 is for error log
            [string] $timestamp = Get-Date -Format  "dd-MM-yyyy HH:mm.sss"
            $logMessage = $logMessage + " at $timestamp"
            $logMessage | Out-File -FilePath $ErrorLogFilePath -Append -Encoding utf8
        }
    }
    catch {
        return
    }
}


logo
menu


