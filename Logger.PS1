
class PSLogger {
    [string] hidden $FilePath
    [bool]   hidden $Console

    PSLogger([bool] $console, [string] $filePath) {
        $this.Console = $console
        $this.FilePath = $filePath

        if ($($this.FilePath -ne [string]::Empty) -and $($(Test-Path -Path $this.FilePath) -eq $false)) {
            New-Item -ItemType File -Path $this.FilePath -Force | Out-Null
        }
    }

    [string] hidden BuildString([string] $LogLevel, [string] $Message) {
        return "$(Get-Date)|$LogLevel|$Message"
    }

    [void] Info([string] $Message) {
        $lm = $this.BuildString("INFO", $Message)
        if ($this.Console) {
            Write-Host -Object $lm -ForegroundColor Green
        }

        if ($this.FilePath -ne [string]::Empty) {
            Add-Content -Path $this.FilePath -Value $lm 
        }
    }
}