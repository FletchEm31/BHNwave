<#
    Generate-Secret.ps1  --  Local, offline, cryptographically-secure secret generator
    --------------------------------------------------------------------------------
    Uses .NET's RandomNumberGenerator (a CSPRNG) -- the same class of randomness
    used for real cryptographic keys. Runs entirely on your machine. No network.

    USAGE (from PowerShell):
        .\Generate-Secret.ps1                  # default: 25-byte hex string
        .\Generate-Secret.ps1 -Bytes 32        # 32-byte (256-bit) hex string
        .\Generate-Secret.ps1 -Count 5         # generate 5 of them
        .\Generate-Secret.ps1 -Words 6         # 6-word passphrase instead of hex
        .\Generate-Secret.ps1 -Words 6 -Count 3

    If you get an execution-policy error, run this once in the same window:
        Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
#>

param(
    [int]$Bytes = 25,     # length of each hex string in bytes (25 = 200 bits)
    [int]$Count = 1,      # how many to generate
    [int]$Words = 0       # if > 0, generate a word-based passphrase of this many words instead of hex
)

# --- cryptographically secure random bytes ---
function Get-SecureBytes([int]$n) {
    $buffer = New-Object 'System.Byte[]' $n
    $rng = [System.Security.Cryptography.RandomNumberGenerator]::Create()
    try   { $rng.GetBytes($buffer) }
    finally { $rng.Dispose() }
    return $buffer
}

# --- hex string mode ---
function New-HexString([int]$n) {
    $bytes = Get-SecureBytes $n
    return ($bytes | ForEach-Object { $_.ToString('x2') }) -join ''
}

# --- word passphrase mode (uses a built-in small wordlist) ---
$wordlist = @(
    'anchor','bishop','cobalt','damson','ember','falcon','granite','harbor','indigo','jasper',
    'kestrel','lantern','marble','nectar','onyx','pewter','quartz','raven','saffron','tundra',
    'umber','velvet','willow','xenon','yarrow','zephyr','amber','basalt','cedar','dapple',
    'echo','fjord','gable','heron','ivory','juniper','kelp','lichen','mistral','nimbus',
    'opal','plume','quill','ridge','sable','thorn','umbra','vesper','warden','yonder',
    'azure','briar','cinder','dusk','ferro','glint','hollow','iris','kite','larch',
    'meadow','north','orchard','pine','quay','river','spruce','talon','vine','wren'
)
function New-Passphrase([int]$wordCount) {
    $picked = for ($i = 0; $i -lt $wordCount; $i++) {
        # unbiased index into the wordlist using 4 secure bytes
        $b = Get-SecureBytes 4
        $val = [BitConverter]::ToUInt32($b, 0)
        $wordlist[$val % $wordlist.Count]
    }
    return ($picked -join '-')
}

Write-Host ""
if ($Words -gt 0) {
    Write-Host "=== $Count word passphrase(s), $Words words each ===" -ForegroundColor Cyan
    for ($i = 0; $i -lt $Count; $i++) { Write-Host (New-Passphrase $Words) -ForegroundColor Green }
} else {
    $bits = $Bytes * 8
    Write-Host "=== $Count hex string(s), $Bytes bytes ($bits bits) each ===" -ForegroundColor Cyan
    for ($i = 0; $i -lt $Count; $i++) { Write-Host (New-HexString $Bytes) -ForegroundColor Green }
}
Write-Host ""
Write-Host "Generated locally with .NET CSPRNG. Nothing left this machine." -ForegroundColor DarkGray
