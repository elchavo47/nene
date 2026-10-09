# GitHub 100 MB'tan buyuk dosya kabul etmez. Bu betik buyuk dosyalari parcalara boler; GitHub'daki is onlari geri birlestirir.
$lim = 90MB; $chunk = 45MB
Get-ChildItem -Recurse -File | Where-Object { $_.Length -gt $lim -and $_.FullName -notmatch '\\\.git\\' } | ForEach-Object {
  $f = $_.FullName; $in = [IO.File]::OpenRead($f); $buf = New-Object byte[] $chunk; $i = 0
  while (($n = $in.Read($buf, 0, $buf.Length)) -gt 0) { $out = [IO.File]::Create(("{0}.part{1:D3}" -f $f, $i)); $out.Write($buf, 0, $n); $out.Close(); $i++ }
  $in.Close(); Remove-Item $f; Write-Host "bolundu: $f ($i parca)"
}
Write-Host "Hazir. Simdi git komutlarini calistir."
