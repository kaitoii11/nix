# dotfiles (Home Manager)

複数の Linux VM（Ubuntu など）のユーザー環境を Home Manager + flakes で宣言的に管理するリポジトリ。

## 構成

```
.
├── flake.nix                 # 入口。ホストごとの homeConfigurations を定義
├── home/
│   ├── common.nix            # 全 VM 共通
│   ├── dev.nix               # 開発/クラスタ操作ロール
│   ├── programs/             # git / zsh / tmux などのモジュール
│   └── files/                # 既存 dotfiles をそのまま置く場所
├── hosts/                    # ホスト固有の差分
├── scripts/inventory.sh      # 既存 VM の棚卸し
└── .github/workflows/        # CI と flake.lock 自動更新
```

## 初回セットアップ（各 VM）

```sh
# 1. Nix をインストール（flakes 有効）
curl -fsSL https://install.determinate.systems/nix | sh -s -- install

# 2. 適用（既存ファイルは *.backup に退避）
nix run home-manager -- switch -b backup --flake github:<you>/dotfiles#kaito@$(hostname)
```

2 回目以降:

```sh
git -C ~/dotfiles pull
home-manager switch --flake ~/dotfiles
```

## ホストの追加

1. `hosts/<hostname>.nix` を作成
2. `flake.nix` の `homeConfigurations` に `"kaito@<hostname>"` を追加
3. `.github/workflows/check.yml` の matrix に追加

## 既存 VM からの移行

```sh
./scripts/inventory.sh            # ./inventory/<hostname>/ に出力
```

- `apt-manual.txt` / `top-commands.txt` を見て nixpkgs の名前に対応付け、`home.packages` に追加
- `dotfiles/` の中身を `home/files/` に移し、`home.file` / `xdg.configFile` で参照
- 慣れてきたら `programs.*` モジュールに置き換える

## 注意

- `~/.ssh`、`~/.kube/config`、`~/.aws`、トークン類はコミットしない。必要なら sops-nix / agenix を導入する
- `home.stateVersion` は初回の値から変更しない
- ロールバック: `home-manager generations` で世代を確認し、該当世代の `activate` を実行
