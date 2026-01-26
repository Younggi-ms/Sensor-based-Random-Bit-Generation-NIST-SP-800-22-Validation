🔐 Sensor-based Random Bit Generation & NIST SP 800-22 Validation
====================================================================
# 프로젝트 개요

본 프로젝트는 센서에서 획득한 원시 데이터(raw signal) 를 기반으로
비트열 난수(bitstream)를 생성하고,
해당 비트열이 암호학적 난수로서 적절한지 NIST SP 800-22 통계 테스트를 통해 검증하는 것을 목표로 하였습니다.

기존의 의사난수(PRNG)가 아닌,
물리적 환경 변화에 기반한 엔트로피 소스를 활용한 난수 생성 가능성을 실험적으로 분석하였습니다.

## 연구 목적

- 센서 기반 데이터가 난수 엔트로피 소스로 활용 가능한지 검증
- 센서 종류 및 환경 변화에 따른 난수 품질 차이 분석
- 생성된 비트열을 NIST SP 800-22 테스트로 정량 평가
- 향후 암호 키 생성 가능성에 대한 기초 실험 수행
  

## 실험 환경
 
 
 🔧 HardWare
- Arduino MEGA 2560
- BH1750 (조도 센서, I2C)
- LM35 (온도 센서, 아날로그 입력)

💻 소프트웨어
- Arduino IDE
- Windows PowerShell (.ps1)
- WSL Ubuntu 24.04
- NIST Statistical Test Suite (STS) v2.1.2

## 시스템 구조
<img width="1046" height="701" alt="Image" src="https://github.com/user-attachments/assets/087a0824-cd3c-46e2-9a42-b9239c5be9d3" />
센서 데이터 → 비트 추출 → PC 저장 → NIST 검증의 단일 파이프라인 구성

센서 간 혼합(entropy mixing) 없이 개별 분석 수행

## 비트 생성 방법

📌 조도 센서 (BH1750)
- 연속 조도 측정값을 XOR 방식으로 차분
- LSB(최하위 비트) 추출
- 출력 형식: L: 0, L: 1
<img width="281" height="51" alt="Image" src="https://github.com/user-attachments/assets/48f09819-56fb-4546-a568-5b121308943f" />

📌 온도 센서 (LM35)
- ADC 값 변화 기반 XOR 차분
- LSB 추출
- 출력 형식: T:0, T:1
<img width="281" height="51" alt="Image" src="https://github.com/user-attachments/assets/91f420f5-b7ec-4b82-bbf7-63782cdbc209" />


## 데이터 수집
- PowerShell 스크립트를 이용해 센서별 비트열 분리 저장
- 결과 파일
> - light_bits.txt
> - temp_bits.txt
- ASCII 비트열을 .bits 파일로 변환하여 STS 입력

## NIST SP 800-22 테스트

✔ 수행 테스트 (총 7종)
- Frequency Test
- Block Frequency Test
- Runs Test
- Longest Run of Ones Test
- Discrete Fourier Transform Test
- Approximate Entropy Test
- Serial Test


✔ 설정
- Bitstream 길이: 약 1,100,000 bits
- Number of bitstreams: 10
- Input format: ASCII

## 프로젝트 결론
### 실험 결과 요약
- 센서별 비트열에서 테스트별 P-value 분포 차이 확인
- 일부 테스트에서 실패 발생 →
센서 데이터 특성상 저주파 편향 및 상관성 영향으로 판단
- 동일 조건에서 센서 종류에 따라 난수 품질이 달라짐을 확인

### 분석 및 한계
- 센서 데이터는 환경 변화에 민감하여 엔트로피 변동성이 큼
- 단순 LSB 추출 방식은 상관성 제거에 한계 존재
- 후처리(whitening) 없이 바로 테스트한 점이 한계

### 향후 개선 방향
- Von Neumann Corrector 등 후처리 기법 적용
- 샘플링 주기 및 환경 조건별 비교 실험
- 난수 키 생성 전용 파이프라인 설계
- 센서 기반 난수의 암호 키 활용 가능성 추가 검증

### 프로젝트 의의
- 실제 센서 데이터를 기반으로 한 물리적 난수 생성 실험
- NIST SP 800-22 전 과정 직접 구축 및 수행
- 임베디드–PC–리눅스–암호 통계 검증을 실험하는 프로젝트
