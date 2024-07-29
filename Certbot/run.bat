@echo off

type C:\Path_To_Certbot\banner.txt
echo.
echo Openssl v1.1 혹은 v3.0 이상이 필요합니다.
echo Copyright 2024. Shilvister All rights reserved.
echo.
echo.

bcdedit > nul
if %errorlevel% == 1 goto UACerror

echo Base64 (*.pem) 인증서를 PKCS#12 (*.pfx) 포맷으로 변환합니다.
set /p password=비밀번호를 입력해주세요 : 
echo.

openssl pkcs12 -export -inkey "C:\Path_To_Certbot\privkey.pem" -in "C:\Path_To_Certbot\fullchain.pem" -out "C:\Path_To_Certbot\output.pfx" -passout pass:"%password%"
if %errorlevel% neq 0 goto SSLerror
echo.
echo pfx 인증서가 현재 디렉터리에 저장되었습니다. 
echo.
echo.

for /f "tokens=*" %%a in ('certutil -f -p "%password%" -importpfx "C:\Path_To_Certbot\output.pfx"') do (
    echo %%a
    if "%%a"=="CertUtil: The specified network password is not correct." goto PWerror
)
echo.
echo pfx 인증서가 성공적으로 설치되었습니다. 
echo.
echo.

set shell_cmd=openssl x509 -noout -in "C:\Path_To_Certbot\fullchain.pem" -fingerprint -sha1
for /f "tokens=2 delims='='" %%f in ('%shell_cmd%') do (set Fingerprint=%%f)
echo 인증서의 SHA-1 Fingerprint값은 %Fingerprint%입니다.
echo 인증서의 경로를 레지스트리에 등록합니다.
echo.
set Fingerprint=%Fingerprint::=%

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v SSLCertificateSHA1Hash /t REG_BINARY /d %Fingerprint%
if %errorlevel% neq 0 goto REGerror
echo.
echo.
echo 인증서 경로 등록이 완료되었습니다.
echo 인증서 관리자를 통해 인증서의 접근 권한을 수정하시기 바랍니다.
echo.
echo 프로그램을 종료합니다.
start C:\Windows\System32\certlm.msc

timeout /t 10
exit

:UACerror
echo 오류 : 관리자 권한으로 실행하십시오!
echo 프로그램을 종료합니다.
echo.
pause
exit

:SSLerror
echo 오류 : OpenSSL 실행 중 오류가 발생하였습니다.
echo 프로그램을 종료합니다.
echo.
pause
exit

:PWerror
echo 오류 : 잘못된 비밀번호입니다.
echo 프로그램을 종료합니다.
echo.
pause
exit

:REGerror
echo 오류: 레지스트리에 인증서 경로를 등록하지 못했습니다.
echo 프로그램을 종료합니다.
echo.
pause
exit
