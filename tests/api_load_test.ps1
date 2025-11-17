param(
    [string]$Url = "https://localhost/api/referees/",
    [int]$Times = 20
)

# Ruta explícita a curl.exe para evitar Invoke-WebRequest
$curl = "$env:SystemRoot\System32\curl.exe"

Write-Host "Iniciando test de balanceo..."
Write-Host "URL: $Url"
Write-Host ""

# Tabla hash para contar upstreams
$counts = @{}

for ($i = 1; $i -le $Times; $i++) {

    Write-Host "[$i] ---------------------------"

    # Ejecutar curl (-k = ignorar certificados no válidos)
    $result = & $curl -k -I $Url 2>$null

    # Filtrar headers relevantes
    $upstream = ($result | Select-String "X-Upstream-Server")
    $lb       = ($result | Select-String "X-Load-Balancer")

    if ($upstream) {
        $line = $upstream.Line.Trim()
        Write-Host $line

        # Extraer solo el valor después de "X-Upstream-Server:"
        $value = $line -replace "X-Upstream-Server:\s*", ""

        # Contar ocurrencia
        if ($counts.ContainsKey($value)) {
            $counts[$value]++
        } else {
            $counts[$value] = 1
        }
    }

    if ($lb) { Write-Host $lb.Line }

    Write-Host ""
}

Write-Host "===== RESUMEN DE UPSTREAMS ====="
foreach ($key in $counts.Keys) {
    Write-Host "$key  ->  $($counts[$key]) veces"
}
Write-Host "================================"
