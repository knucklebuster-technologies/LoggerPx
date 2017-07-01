
function New-Logger {
    [CmdletBinding()]
    Param (
        [bool] $Console = $true,
        [string] $Path = [string]::Empty
    )
    [PSLogger]::New($Console, $Path)
}