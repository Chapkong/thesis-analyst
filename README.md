# 논문 분석기 (Paper Analyzer)

PDF 논문을 업로드하면 **제목·저자·연도·문서유형**을 정리하고, **연구대상 · 연구질문과 가설 · 연구 데이터 · 연구방법론 · 주요결과 및 시사점** 5개 항목을 개조식(○/-)으로 뽑아서 HTML/Word 결과물로 만들어주는 로컬 웹앱입니다. 논문에 연구모형·핵심 개념도가 있으면 그림도 함께 추출해 결과물 끝에 포함합니다 (이 경우 결과물이 A4 1장을 넘어갈 수 있습니다). 그림이 없는 논문은 기존처럼 A4 1장에 맞춰 폰트가 자동으로 축소됩니다.

브라우저에서 PDF를 드래그&드롭하면 원문 판독 → 항목 추출 → 원문 대조 검증 → 조판 4단계를 거쳐 결과가 나옵니다. 여러 파일을 한 번에 올리면 순서대로 처리되고, 결과는 논문마다 따로 생성됩니다.

---

## 필요한 것

- Python 3.10 이상 ([python.org](https://www.python.org/downloads/)에서 설치, 설치 시 "Add Python to PATH" 체크)
- Anthropic API 키 ([console.anthropic.com](https://console.anthropic.com/settings/keys)에서 발급, 사용한 만큼 과금됩니다)

## 설치 및 실행

1. 이 저장소를 다운로드(Code → Download ZIP) 또는 `git clone`
2. `run.bat`을 더블클릭 (최초 1회만 콘솔 창이 뜹니다)
3. 바탕화면에 "논문 분석기" 바로가기가 자동으로 생성됩니다 (다음부터는 이 아이콘으로 실행, 콘솔 창 없이 바로 실행됩니다)
4. 최초 1회, API 키를 붙여넣으라는 안내가 뜨면 입력 (이후에는 자동 저장되어 다시 묻지 않습니다)
5. 잠시 후 브라우저가 자동으로 열리고, 화면 우측 하단 시스템 트레이에 아이콘이 생깁니다 (`http://127.0.0.1:5000`)
6. PDF를 드래그&드롭하면 분석이 시작됩니다

종료할 때는 트레이 아이콘을 우클릭 → "종료"를 누르면 됩니다.

## 폴더 구조

```
paper-analyzer/
├── run.bat                  # 더블클릭 실행 스크립트
├── create_shortcut.ps1       # 바탕화면 바로가기 자동 생성 (run.bat이 호출)
├── assets/app.ico             # 바로가기 아이콘
├── CLAUDE.md                 # Claude Code로 직접 쓸 때의 파이프라인 지시서
├── .claude/agents/            # 4단계 서브에이전트 프롬프트 (pdf-reader/extractor/verifier/formatter)
├── templates/                 # 결과 HTML 템플릿
├── scripts/extract_figure.py    # 핵심그림 페이지를 이미지로 추출 (formatter가 호출)
├── webapp/
│   ├── app.py                 # Flask 서버 (업로드 → Claude API 파이프라인 → 결과 생성)
│   ├── tray_app.py             # 시스템 트레이 아이콘 + 서버 실행 (바로가기가 호출)
│   ├── setup_check.py          # 최초 실행 시 API 키 입력 마법사
│   ├── static/index.html        # 업로드 화면
│   └── requirements.txt
├── inbox/                     # 업로드된 PDF가 저장되는 곳
└── results/                    # 결과 HTML/Word가 저장되는 곳
```

## Claude Code에서 직접 쓰고 싶다면

`run.bat` 없이, 이 폴더에서 Claude Code를 열고 `.claude/agents/`의 4개 서브에이전트로 대화형으로 분석시킬 수도 있습니다. `CLAUDE.md`에 파이프라인이 정의되어 있습니다.

## 주의사항

- API 키는 각자 발급받아 각자의 `.env`에 저장됩니다. 절대 다른 사람과 공유하거나 공개 저장소에 커밋하지 마세요.
- 사용량만큼 Anthropic 계정에 과금됩니다.
- 로컬 전용 개발 서버입니다. 인터넷에 공개된 서버로 배포하는 용도로는 만들어지지 않았습니다.
