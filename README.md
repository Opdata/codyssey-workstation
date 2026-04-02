## 1. 프로젝트 개요

누구나 동일한 방식으로 실행/배포/디버그할 수 있는 환경을 구성하기 위해 워크스테이션을 구축한다.</br>
이 과정에서 CLI, Docker, Git/GitHub를 사용한다.
이 미션은 터미널로 디렉토리 권한 정리 / Docker를 설치, 실행, 운영/관리 한다.</br>
커스텀 Docker 이미지 제작, 포트 매핑, 볼륨 영속성 검증까지 CLI 기반으로 전 과정을 수행한다.</br>
이 경험은 이후 리눅스 트러블슈팅, CI/CD 파이프라인, 클라우드 배포/운영 등으로 자연스럽게 확장된다.</br>

---

## 2. 실행 환경

| 항목     | 버전 / 값            |
| -------- | -------------------- |
| OS       | macOS 26.3           |
| Shell    | zsh                  |
| Terminal | 기본 터미널          |
| Docker   | 9.3.1, build c2be9cc |
| Git      | 2.33.0               |

---

## 3. 터미널 조작 로그

```zsh
# pwd, ls -al, mkdir, cp, mv, rm, cat, touch 등
$ pwd # 현재 작업 중인 디렉토리의 절대 경로를 출력
/Users/jun/Documents/GitHub/codyssey-work/workstation

$ ls -al # 목록 확인(숨김 파일, 디렉토리 포함)
total 16
drwxr-xr-x  4 jun  staff   128  4 26 10:38 .
drwxr-xr-x  3 jun  staff    96  4 26 10:37 ..
drwxr-xr-x  3 jun  staff    96  4 26 10:38 .git
-rw-r--r--  1 jun  staff  1354  4 26 10:38 .gitignore
-rw-r--r--  1 jun  staff  4096  4 26 10:38 README.md

$ mkdir test # test 디렉토리 생성
$ ls -al
total 16
drwxr-xr-x  4 jun  staff   128  4 26 10:38 .
drwxr-xr-x  3 jun  staff    96  4 26 10:37 ..
drwxr-xr-x  3 jun  staff    96  4 26 10:38 .git
-rw-r--r--  1 jun  staff  1354  4 26 10:38 .gitignore
-rw-r--r--  1 jun  staff  4096  4 26 10:38 README.md
-rw-r--r--  1 jun  staff     0  4 26 10:38 test

$ cp test test2 # test 디렉토리를 test2로 복사
$ ls -al
total 16
drwxr-xr-x  4 jun  staff   128  4 26 10:38 .
drwxr-xr-x  3 jun  staff    96  4 26 10:37 ..
drwxr-xr-x  3 jun  staff    96  4 26 10:38 .git
-rw-r--r--  1 jun  staff  1354  4 26 10:38 .gitignore
-rw-r--r--  1 jun  staff     0  4 26 10:38 README.md
-rw-r--r--  1 jun  staff     0  4 26 10:38 test
-rw-r--r--  1 jun  staff     0  4 26 10:38 test2

$ mv test test3 # test 디렉토리의 이름을 test3로 변경
$ ls -al
total 16
drwxr-xr-x  4 jun  staff   128  4 26 10:38 .
drwxr-xr-x  3 jun  staff    96  4 26 10:37 ..
drwxr-xr-x  3 jun  staff    96  4 26 10:38 .git
-rw-r--r--  1 jun  staff  1354  4 26 10:38 .gitignore
-rw-r--r--  1 jun  staff     0  4 26 10:38 README.md
-rw-r--r--  1 jun  staff     0  4 26 10:38 test2
-rw-r--r--  1 jun  staff     0  4 26 10:38 test3

$ mv test2 mvtestDir # test2 디렉토리를 mvtestDir로 이동
$ ls -al mvtestDir
drwxr-xr-x  3 jun  staff   96  4월  2 13:39 .
drwxrw-r--@ 9 jun  staff  288  4월  2 13:39 ..
drwxr-xr-x  2 jun  staff   64  4월  2 13:38 test2

$ rm -r mvtestDir # mvtestDir 디렉토리 삭제
$ ls -al
drwxrw-r--@  8 jun  staff    256  4월  2 13:41 .
drwxr-xr-x   3 jun  staff     96  4월  1 20:18 ..
drwxr-xr-x@ 15 jun  staff    480  4월  1 21:25 .git
-rw-r--r--@  1 jun  staff     28  4월  1 20:18 .gitignore
-rw-r--r--@  1 jun  staff   8893  4월  2 13:40 README.md

$ cat README.md # README.md 파일 내용 출력
## 1. 프로젝트 개요
...
....

$ touch test.txt # test.txt 빈 파일 생성
$ ls -al
-rw-r--r--   1 jun  staff      0  4월  2 13:45 test.txt
```

### 터미널 조작 커맨드 설명

| 커맨드   | 설명                                                          | 예시1           | 예시2                |
| -------- | ------------------------------------------------------------- | --------------- | -------------------- |
| `pwd`    | 현재 작업 중인 디렉토리의 절대 경로를 출력                    | `pwd`           |                      |
| `ls -la` | 현재 디렉토리 목록 출력 (-l: 자세한 정보, -a: 숨김 파일 포함) | `ls -la`        | `ls -la /tmp`        |
| `mkdir`  | 새로운 디렉토리를 생성                                        | `mkdir test`    | `mkdir -p a/b/c`     |
| `cp`     | 파일 또는 디렉토리를 복사                                     | `cp test test2` | `cp test /tmp/test2` |
| `mv`     | 파일 또는 디렉토리를 이동하거나 이름을 변경                   | `mv test test3` | `mv test /tmp/test3` |
| `rm`     | 파일 또는 디렉토리를 삭제                                     | `rm test2`      | `rm -r testdir`      |
| `cat`    | 파일의 내용을 출력                                            | `cat README.md` | `cat /etc/hosts`     |
| `touch`  | 빈 파일을 생성하거나 파일의 타임스탬프를 업데이트             | `touch test`    | `touch a.txt b.txt`  |

---

## 4. 권한 실습 및 증거

```zsh
# 변경 전
drwxr-xr-x@  8 jun  staff   256  4월  1 21:43 workstation

# workstation 디렉토리 권한을 744로 변경
$ chmod 744 workstation
drwxr--r--@  8 jun  staff   256  4월  1 21:43 workstation

# workstation 디렉토리 그룹 쓰기 권한 변경
$ chmod g+w workstation
$ ls -al
drwxrw-r--@  8 jun  staff   256  4월  1 21:43 workstation
```

---

## 5. Docker 설치 및 기본 점검

```zsh
# Apple Silicon
curl -o Docker.dmg "https://desktop.docker.com/mac/main/arm64/Docker.dmg"

# Intel
curl -o Docker.dmg "https://desktop.docker.com/mac/main/amd64/Docker.dmg"

# 마운트 & 카피
hdiutil attach Docker.dmg
cp -R /Volumes/Docker/Docker.app /Applications
hdiutil detach /Volumes/Docker

# Docker 버전 확인
$ docker --version
Docker version 29.3.1, build c2be9cc

# Docker 전체 시스템 정보(커널 버전, 컨테이너 수 등등)
$ docker info
Client:
 Version:    29.3.1
 Context:    desktop-linux
 Debug Mode: false
 Plugins:
  agent: Docker AI Agent Runner (Docker Inc.)
    Version:  v1.34.0
    Path:     /Users/jun/.docker/cli-plugins/docker-agent
  ai: Docker AI Agent - Ask Gordon (Docker Inc.)
    Version:  v1.20.1
    Path:     /Users/jun/.docker/cli-plugins/docker-ai
  buildx: Docker Buildx (Docker Inc.)
  ....
```

---

## 6. Docker 운영 명령 (logs / stats)

```zsh
# 추후 기입
```

---

## 7. 컨테이너 실행 실습

### hello-world

```zsh
# 추후 기입
```

### ubuntu 컨테이너 진입

```zsh
# 추후 기입
```

### attach vs exec 차이

<!-- 추후 기입: 컨테이너 종료/유지 차이 관찰 결과 -->

---

## 8. Dockerfile 기반 커스텀 이미지

**선택한 베이스 이미지:** 추후 기입

**커스텀 포인트 및 목적:**

| 커스텀 항목 | 목적 |
| ----------- | ---- |
| 추후 기입   |      |

```zsh
# 빌드/실행 명령 및 결과
# 추후 기입
```

---

## 9. 포트 매핑

```zsh
# 추후 기입
```

<!-- 브라우저 접속 화면 또는 curl 응답 스크린샷 첨부 -->

---

## 10. 바인드 마운트 (호스트 변경 전/후 비교)

```zsh
# 추후 기입
```

---

## 11. Docker 볼륨 영속성 검증 (컨테이너 삭제 전/후)

```zsh
# 추후 기입
```

---

## 12. Git 설정 및 GitHub 연동

```zsh
$ git config --list
# 추후 기입
```

<!-- GitHub 연동 증거 스크린샷 첨부 -->

---

## 13. 검증 방법

| 항목          | 명령어                                 | 확인 내용                             |
| ------------- | -------------------------------------- | ------------------------------------- |
| Docker 설치   | `docker --version`                     | 버전 출력 확인                        |
| 데몬 동작     | `docker info`                          | 오류 없이 정보 출력                   |
| 이미지 목록   | `docker images`                        | 빌드한 이미지 존재 확인               |
| 컨테이너 목록 | `docker ps -a`                         | 실행/중지 컨테이너 확인               |
| 컨테이너 로그 | `docker logs <name>`                   | 컨테이너 출력 로그 확인               |
| 리소스 사용   | `docker stats`                         | CPU/메모리 사용량 확인                |
| 포트 매핑     | `curl http://localhost:8080`           | 응답 확인                             |
| 바인드 마운트 | 호스트 파일 수정 후 컨테이너 내부 확인 | 변경사항 실시간 반영 확인             |
| 볼륨 영속성   | `docker exec` + `cat`                  | 컨테이너 삭제 후에도 데이터 유지 확인 |
| Git 설정      | `git config --list`                    | user.name, user.email 확인            |
| GitHub 연동   | `ssh -T git@github.com`                | 인증 성공 메시지 확인                 |

---

## 14. 수행 체크리스트

- [ ] 터미널 기본 조작 (pwd, ls -la, mkdir, cp, mv, rm, cat, touch)
- [ ] 권한 변경 실습 (chmod — 파일 1개, 디렉토리 1개, 변경 전/후 비교)
- [ ] Docker 설치 및 데몬 점검 (docker --version, docker info)
- [ ] hello-world 컨테이너 실행
- [ ] ubuntu 컨테이너 실행 및 내부 진입 (ls, echo 수행)
- [ ] attach vs exec 차이 관찰 및 정리
- [ ] Docker 운영 명령 수행 (docker logs, docker stats)
- [ ] Dockerfile 작성 및 커스텀 이미지 빌드 (베이스 이미지 선택 + 커스텀 포인트 목적 기술)
- [ ] 포트 매핑 접속 성공 (curl 또는 브라우저 스크린샷)
- [ ] 바인드 마운트 반영 확인 (호스트 변경 전/후 비교)
- [ ] Docker 볼륨 영속성 검증 (컨테이너 삭제 전/후)
- [ ] Git 설정 확인 (git config --list)
- [ ] GitHub SSH 연동 완료 및 증거 첨부

---

## 15. 트러블슈팅

### Case 1: 추후 기입

| 항목      | 내용 |
| --------- | ---- |
| 문제      |      |
| 원인 가설 |      |
| 확인      |      |
| 해결      |      |

### Case 2: 추후 기입

| 항목      | 내용 |
| --------- | ---- |
| 문제      |      |
| 원인 가설 |      |
| 확인      |      |
| 해결      |      |
