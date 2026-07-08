from pathlib import Path

ENV_PATH = Path(__file__).resolve().parent / ".env"


def main():
    if ENV_PATH.exists():
        return

    print("=" * 50)
    print(" 논문 분석기 최초 설정")
    print("=" * 50)
    print("Anthropic API 키가 필요합니다 (최초 1회만 입력하면 됩니다).")
    print("발급: https://console.anthropic.com/settings/keys")
    print()
    key = input("API 키를 붙여넣고 Enter: ").strip()

    if not key:
        print()
        print("키가 입력되지 않았습니다. run.bat을 다시 실행해주세요.")
        raise SystemExit(1)

    ENV_PATH.write_text(
        f"ANTHROPIC_API_KEY={key}\nCLAUDE_MODEL=claude-opus-4-8\n",
        encoding="utf-8",
    )
    print()
    print("저장 완료. 잠시 후 브라우저가 자동으로 열립니다.")


if __name__ == "__main__":
    main()
