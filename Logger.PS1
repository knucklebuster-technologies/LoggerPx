
class PSLogger {
    [string] hidden $FilePath
    [bool]   hidden $Console

    PSLogger([bool] $console, [string] $filePath) {
        $this.Console = $console
        $this.FilePath = $filePath

        if (($this.FilePath -ne [string]::Empty) -and (-not (Test-Path -Path $this.FilePath))) {
            New-Item -ItemType File -Path $this.FilePath -Force | Out-Null
        }
    }

    [string] hidden BuildString([string] $logLevel, [string] $message) {
        return "$(Get-Date)|$logLevel|$message"
    }

    [void] hidden WriteLog([string] $logMessage, [System.ConsoleColor] $color) {
        if ($this.Console) {
            Write-Host -Object $logMessage -ForegroundColor $color
        }

        if (($this.FilePath -ne [String]::Empty) -and (Test-Path -Path $this.FilePath)) {
            Add-Content -Value $logMessage -Path $this.FilePath -Force
        }
    }

    [void] Info([string] $message) {
        $lm = $this.BuildString("INFO", $message)
        $this.WriteLog($lm, [System.ConsoleColor]::Green)
    }

    [void] Warn([string] $message) {
        $lm = $this.BuildString("WARN", $message)
        $this.WriteLog($lm, [System.ConsoleColor]::Yellow)
    }

    [void] Error([string] $message) {
        $lm = $this.BuildString("ERROR", $message)
        $this.WriteLog($lm, [System.ConsoleColor]::Red)
    }
}