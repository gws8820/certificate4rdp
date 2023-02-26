# certificate4rdp
윈도우 원격 데스크톱 인증서 적용을 위한 프로그램입니다.
Let's Encrypt 등에서 발급하는 pem 확장자의 인증서를 윈도우에서 사용하는 PKCS#12 포맷으로 변환하고, 인증서 저장소에 설치 후 레지스트리에 등록합니다.

"privkey.pem"은 개인 키 파일 경로,
"fullchain.pem"은 인증서 파일 경로,
"PASSWORD"는 pfx 인증서에 사용할 비밀번호,
"KEY.pfx"는 새로 만들어진 인증서 파일 경로입니다.
