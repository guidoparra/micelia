@echo off
REM Abre la web del reino Fungi con un servidor local (necesario para el globo 3D con capas).
REM Cerrar esta ventana apaga el servidor.
cd /d "%~dp0"
start "" cmd /c "timeout /t 2 >nul & start http://localhost:8000/index.html"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$py = (Get-ChildItem 'C:\Program Files\QGIS*\apps\Python*\python.exe' -ErrorAction SilentlyContinue | Select-Object -First 1).FullName; if (-not $py) { $c = Get-Command py -ErrorAction SilentlyContinue; if ($c) { $py = $c.Source } }; if (-not $py) { Write-Host 'No encontre Python. Instala QGIS o Python.'; Read-Host 'Enter para salir'; exit }; Write-Host 'Servidor en http://localhost:8000 - cerra esta ventana para apagarlo'; & $py -m http.server 8000"
