# Docker & Linux 기초 미션

## 1. 프로젝트 개요

터미널 조작, Docker 운영, Git/GitHub 연동을 직접 수행하고 그 과정을 기술 문서로 기록하는 미션이다.
커스텀 Docker 이미지 제작, 포트 매핑, 볼륨 영속성 검증까지 CLI 기반으로 전 과정을 수행한다.

---

## 2. 실행 환경

| 항목 | 버전 / 값 |
|---|---|
| OS | macOS 26.3 |
| Shell | zsh |
| Terminal | iTerm2 / 기본 터미널 |
| Docker | 추후 기입 |
| Git | 2.33.0 |

---

## 3. 수행 체크리스트

- [ ] 터미널 기본 조작 (pwd, ls, mkdir, cp, mv, rm 등)
- [ ] 권한 변경 실습 (chmod — 파일 1개, 디렉토리 1개)
- [ ] Docker 설치 및 데몬 점검 (docker --version, docker info)
- [ ] hello-world 컨테이너 실행
- [ ] ubuntu 컨테이너 실행 및 내부 진입
- [ ] Dockerfile 작성 및 커스텀 이미지 빌드
- [ ] 포트 매핑 접속 성공 (curl 또는 브라우저)
- [ ] 바인드 마운트 반영 확인
- [ ] Docker 볼륨 영속성 검증 (컨테이너 삭제 전/후)
- [ ] Git 설정 확인 (git config --list)
- [ ] GitHub SSH 연동 완료

---

## 4. 검증 방법

| 항목 | 명령어 | 확인 내용 |
|---|---|---|
| Docker 설치 | `docker --version` | 버전 출력 확인 |
| 데몬 동작 | `docker info` | 오류 없이 정보 출력 |
| 이미지 목록 | `docker images` | 빌드한 이미지 존재 확인 |
| 컨테이너 목록 | `docker ps -a` | 실행/중지 컨테이너 확인 |
| 포트 매핑 | `curl http://localhost:8080` | 응답 확인 |
| 볼륨 영속성 | `docker exec` + `cat` | 컨테이너 삭제 후에도 데이터 유지 확인 |
| Git 설정 | `git config --list` | user.name, user.email 확인 |
| GitHub 연동 | `ssh -T git@github.com` | 인증 성공 메시지 확인 |

---

## 5. 트러블슈팅

### Case 1: GitHub HTTPS push 인증 실패

| 항목 | 내용 |
|---|---|
| 문제 | `git push` 시 `Authentication failed` 오류 발생 |
| 원인 가설 | macOS 키체인에 잘못된 크리덴셜이 캐싱되어 있거나 PAT 미입력 |
| 확인 | `git credential-osxkeychain erase` 후 재시도 → 동일 오류 |
| 해결 | SSH 키 발급 후 remote URL을 SSH 방식으로 변경 |

### Case 2: 추후 기입

| 항목 | 내용 |
|---|---|
| 문제 | |
| 원인 가설 | |
| 확인 | |
| 해결 | |

---

## 6. 터미널 조작 로그

### 기본 터미널 조작

```bash
# 추후 기입
```

### Docker 설치 및 점검

```bash
# 추후 기입
```

### 커스텀 이미지 빌드 및 실행

```bash
# 추후 기입
```

### 포트 매핑

```bash
# 추후 기입
```

### 볼륨 영속성 검증

```bash
# 추후 기입
```

### Git 설정 및 GitHub 연동

```bash
$ git config --list
# 추후 기입
```
