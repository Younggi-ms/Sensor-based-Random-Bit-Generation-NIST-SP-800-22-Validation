🔐 Sensor-based Random Bit Generation & NIST SP 800-22 Validation
1. 프로젝트 개요

본 프로젝트는 센서에서 획득한 원시 데이터(raw signal) 를 기반으로
비트열 난수(bitstream)를 생성하고,
해당 비트열이 암호학적 난수로서 적절한지 NIST SP 800-22 통계 테스트를 통해 검증하는 것을 목표로 하였습니다.

기존의 의사난수(PRNG)가 아닌,
물리적 환경 변화에 기반한 엔트로피 소스를 활용한 난수 생성 가능성을 실험적으로 분석하였습니다.

2. 연구 목적

- 센서 기반 데이터가 난수 엔트로피 소스로 활용 가능한지 검증
- 센서 종류 및 환경 변화에 따른 난수 품질 차이 분석
- 생성된 비트열을 NIST SP 800-22 테스트로 정량 평가
- 향후 암호 키 생성 가능성에 대한 기초 실험 수행
  

3. 실험 환경
 
 
 🔧 HardWare
- Arduino MEGA 2560
- BH1750 (조도 센서, I2C)
- LM35 (온도 센서, 아날로그 입력)

💻 소프트웨어
- Arduino IDE
- Windows PowerShell (.ps1)
- WSL Ubuntu 24.04
- NIST Statistical Test Suite (STS) v2.1.2

4. 시스템 구조
