# dotfiles

[chezmoi](https://www.chezmoi.io/) 管理。macOS と WSL の差分をテンプレートで吸収する。

chezmoi のソースは `home/` 以下（リポジトリ直下の `.chezmoiroot` で指定）。
`nix/` と `flake.nix` は chezmoi の管理外で、まだ適用していない。

## 新しいマシンでの導入

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply Andyyyy64/dotfiles
```

`chezmoi apply` のあと、macOS では `home/run_onchange_after_10-darwin-setup.sh.tmpl` が走り、
herdr の導入・Claude Code 連携・zed CLI のリンク・LaunchAgent の登録まで済む。

## 中身

| パス | 内容 |
|---|---|
| `home/dot_zshrc` | zsh 設定。oh-my-zsh、pyenv、nodebrew ほか |
| `home/private_dot_config/zed/` | Zed のパネル配置・キーマップ |
| `home/private_dot_config/herdr/` | herdr のキーマップ（WezTerm の C-x スキームを移植）と日本語入力設定 |
| `home/private_dot_config/wezterm/` | WezTerm 設定 |
| `home/dot_claude/private_settings.json` | Claude Code の権限モード・フック |
| `home/dot_local/bin/herdr-zed-sync` | herdr のフォーカスに Zed のプロジェクトを追従させる常駐スクリプト |

## Zed + herdr の構成について

Zed をエディタ、herdr を Claude Code の実行基盤として使う。
Zed の内蔵ターミナルで herdr に attach し、herdr のペインを切り替えると
Zed のプロジェクトも追従する。

キーが1つ効くのに **2つのファイルが協調している**点に注意。

```
キーを押す
  → home/private_dot_config/zed/keymap.json.tmpl   Zed が何を横取りし、どのバイトを送るか
  → home/private_dot_config/herdr/config.toml.tmpl herdr が受け取ったバイトをどの動作に割り当てるか
```

例えば `cmd+n` で space を移動するには、Zed 側で `ESC N` に翻訳し、herdr 側で
`next_workspace = ["alt+shift+n"]` として受ける。片方だけでは動かない。

端末のバイト列で表現できないキーは使えない。`ctrl+tab` は `Tab`(0x09) と、
`ctrl+shift+n` は `ctrl+n`(0x0E) と区別がつかない。herdr の `config check` は
通ってしまうので、設定できたように見えて一生届かない。

## プラットフォーム対応状況

| | macOS | WSL / Linux |
|---|---|---|
| zsh | ✅ | ✅ |
| WezTerm | ✅ | 未確認 |
| Zed + herdr | ✅ | **未対応**（テンプレートの分岐だけ用意済み） |

WSL 側は darwin 分岐の外側だけが適用される。
Cmd キーが無いので、キーバインドは Linux 用に割り直す必要がある。

## 日常の使い方

```sh
chezmoi edit ~/.config/zed/keymap.json   # ソースを編集して apply
chezmoi re-add                            # 実機側で直したものをソースへ取り込む
chezmoi diff                              # 差分確認
chezmoi apply                             # 反映
```

herdr の設定だけ変えたときは `herdr config check` → `herdr server reload-config` で
Zed を再起動せずに反映できる。Zed のキーマップを変えたときは Zed の再起動が要る。

## シークレット

このリポジトリに秘密情報は置かない。`~/.zshrc` は存在チェック付きで
`~/.codex/secrets/*.env` を読む形にしてあるので、そのファイルを配置しない限り
他マシンでも壊れない。

> 過去に `zsh/.zshenv` へ API キーを平文でコミットしていた（2024-04-12 `3741c87` 以降）。
> ファイルは削除したが **git 履歴には残っている**。キーの失効が必須。
