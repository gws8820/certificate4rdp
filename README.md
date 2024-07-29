# Certificate4RDP
윈도우 원격 데스크톱 인증서 적용을 위한 프로그램입니다.

## Description
- Let's Encrypt 등에서 발급하는 pem 확장자의 인증서를 윈도우에서 사용하는 PKCS#12 포맷으로 변환합니다.
- 인증서 파일을 윈도우 저장소에 설치 후 레지스트리에 등록합니다.

## How-To?
1. Certbot 폴더 안에 공개 키 (fullchain.pem)과 개인 키 (privkey.pem)를 추가합니다.
2. C:\Path_To_Certbot를 Certbot 폴더의 경로로 변경합니다.
3. run.bat을 관리자 권한으로 실행합니다. (인증서 파일은 output.pfx로 저장됩니다.)
4. 윈도우 인증서 관리자가 실행되면, NETWORK SERVICE 사용자에게 읽기 권한을 부여합니다.
