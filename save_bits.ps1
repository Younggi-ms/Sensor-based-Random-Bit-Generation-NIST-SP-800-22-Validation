# -----------------------------
# 설정
# -----------------------------
$port = "COM4"            # MEGA 포트
$baud = 115200
$light_file = "C:\Users\User\Desktop\light_bits.txt"
$temp_file  = "C:\Users\User\Desktop\temp_bits.txt"

# -----------------------------
# 시리얼 포트 설정
# -----------------------------
$sp = New-Object System.IO.Ports.SerialPort $port, $baud, "None", 8, 1
$sp.ReadTimeout = 500     # 읽기 타임아웃

try {
    $sp.Open()
    Write-Host "Serial Port Opened: $port"

    $fs_light = [System.IO.StreamWriter] $light_file
    $fs_temp  = [System.IO.StreamWriter] $temp_file

    Write-Host "Recording bits..."

    while ($true) {
        try {
            $line = $sp.ReadLine().Trim()

            # L:0 또는 L:1
            if ($line.StartsWith("L:")) {
                $bit = $line.Substring(2,1)
                if ($bit -eq "0" -or $bit -eq "1") {
                    $fs_light.Write($bit)
                }
            }

            # T:0 또는 T:1
            elseif ($line.StartsWith("T:")) {
                $bit = $line.Substring(2,1)
                if ($bit -eq "0" -or $bit -eq "1") {
                    $fs_temp.Write($bit)
                }
            }
        }
        catch {
            # ReadTimeout → 무시
        }
    }

}
finally {
    Write-Host "Closing files and serial port..."
    if ($fs_light) { $fs_light.Close() }
    if ($fs_temp)  { $fs_temp.Close()  }
    if ($sp.IsOpen) { $sp.Close() }
}
