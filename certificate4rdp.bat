@echo off
echo  _____              _    _   __  _               _            ___ ______ ______ ______          __        ___     __  
echo /  __ \            ^| ^|  (_) / _^|(_)             ^| ^|          /   ^|^| ___ \^|  _  \^| ___ \        /  ^|      /   ^|   /  ^| 
echo ^| /  \/  ___  _ __ ^| ^|_  _ ^| ^|_  _   ___   __ _ ^| ^|_   ___  / /^| ^|^| ^|_/ /^| ^| ^| ^|^| ^|_/ / __   __`^| ^|     / /^| ^|   `^| ^| 
echo ^| ^|     / _ \^| '__^|^| __^|^| ^|^|  _^|^| ^| / __^| / _` ^|^| __^| / _ \/ /_^| ^|^|    / ^| ^| ^| ^|^|  __/  \ \ / / ^| ^|    / /_^| ^|    ^| ^| 
echo ^| \__/\^|  __/^| ^|   ^| ^|_ ^| ^|^| ^|  ^| ^|^| (__ ^| (_^| ^|^| ^|_ ^|  __/\___  ^|^| ^|\ \ ^| ^|/ / ^| ^|      \ V / _^| ^|_ _ \___  ^| _ _^| ^|_
echo  \____/ \___^|^|_^|    \__^|^|_^|^|_^|  ^|_^| \___^| \__,_^| \__^| \___^|    ^|_/\_^| \_^|^|___/  \_^|       \_/  \___/(_)    ^|_/(_)\___/
echo.
echo.
echo * 관리자 권한으로 실행하십시오.
echo * Openssl v1.1 혹은 v3.0 이상이 필요합니다.
echo.
echo Copyright 2023. Shilvister All rights reserved.
echo.
echo.
echo.
echo 개인 키와 인증서를 PKCS#12 포맷으로 변환합니다. pfx 파일에 사용할 비밀번호를 입력해주세요.
echo.
openssl pkcs12 -export -inkey "privkey.pem" -in "fullchain.pem" -out KEY.pfx"

echo.
echo.
echo Creating KEY.pfx ... Done!
echo 인증서가 <Directory>에 저장되었습니다. 
echo.
echo.
echo.
certutil -f -p "PASSWORD" -importpfx "KEY.pfx"
echo.
echo.
echo.
set shell_cmd=openssl x509 -noout -in "fullchain.pem" -fingerprint -sha1
for /f "tokens=2 delims='='" %%f in ('%shell_cmd%') do (set Fingerprint=%%f)
echo 인증서의 SHA-1 Fingerprint값은 %Fingerprint%입니다.
echo 인증서의 경로를 레지스트리에 등록합니다.
echo.
set Fingerprint=%Fingerprint::=%
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v SSLCertificateSHA1Hash /t REG_BINARY /d %Fingerprint%
echo.
echo.
echo 인증서 경로 등록이 완료되었습니다.
echo 프로그램을 종료합니다.
echo.
timeout /t 10
