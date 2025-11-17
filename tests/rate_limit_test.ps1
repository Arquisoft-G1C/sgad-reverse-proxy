param(
    [string]$Url = "https://localhost/api/referees/",
    [int]$Times = 200
)

$curl = "$env:SystemRoot\System32\curl.exe"

Write-Host "Iniciando test de rate limit..."
Write-Host "URL: $Url"
Write-Host "Peticiones: $Times"
Write-Host ""

# Contadores
$ok = 0
$limited = 0
$other = 0

for ($i = 1; $i -le $Times; $i++) {

    # Ejecutar curl y extraer solo el código HTTP
    $output = & $curl -k -X GET -s -D - $Url 2>$null

    $status = ($output | Select-String "HTTP/" | ForEach-Object { $_.Line }).Trim()

    Write-Host "[$i] $status"

    if ($status -match "200") { $ok++ }
    elseif ($status -match "429") { $limited++ }
    else { $other++ }
}

Write-Host ""
Write-Host "========== RESUMEN =========="
Write-Host "200 OK                : $ok"
Write-Host "429 Too Many Requests : $limited"
Write-Host "Otros códigos         : $other"
Write-Host "============================="
