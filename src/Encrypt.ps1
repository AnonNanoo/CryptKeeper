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
    
    # Prompt user for inputs
    [string]$inputPath = Read-Host "Enter the path to the input file (file to be encrypted)"
    [string]$outputPath = Read-Host "Enter the path to the output file (where encrypted file will be saved)"
    [string]$password = Read-Host "Enter the password for encryption"

    # Check if the input file exists
    if (-not (Test-Path $inputPath)) {
        Write-Output "Input file does not exist."
        return
    }

    # Somehow generate an IV (Initialization Vector) -> convert to secure string -> key from that -> AES encryption object must be created....

  

    Write-Output "Encryption complete."

}
main
