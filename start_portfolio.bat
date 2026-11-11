@echo off
cd /d "%~dp0"
echo Starting Built-in Windows Local Server...
start http://localhost:8000
powershell -NoProfile -ExecutionPolicy Bypass -Command "$listener = [System.Net.HttpListener]::new(); $listener.Prefixes.Add('http://localhost:8000/'); $listener.Start(); Write-Host 'Server running at http://localhost:8000/'; while ($listener.IsListening) { $context = $listener.GetContext(); $req = $context.Request; $res = $context.Response; $path = Join-Path (Get-Location) ($req.Url.LocalPath.TrimStart('/')); if ($req.Url.LocalPath -eq '/') { $path = Join-Path (Get-Location) 'index.html' }; if (Test-Path $path -PathType Leaf) { $bytes = [System.IO.File]::ReadAllBytes($path); $res.ContentLength64 = $bytes.Length; $res.OutputStream.Write($bytes, 0, $bytes.Length) } else { $res.StatusCode = 404 }; $res.OutputStream.Close() }"
