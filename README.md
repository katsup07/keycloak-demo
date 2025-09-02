# 🔒 Keycloakデモ環境

- このリポジトリは、Keycloak認証サーバー、ユーザーデータを保管するPostgreSQLデータベース、Reactクライアント、Spring Bootサーバーを含む、Keycloakを用いた認証フローを示すデモ環境を提供する。

## 🌟 特徴
- **Keycloak**: 認証・認可サーバー
- **PostgreSQL**: Keycloak用データベース
- **Reactクライアント**: フロントエンドアプリ
- **Spring Bootサーバー**: バックエンドアプリ

## 🛠️ セットアップ手順

### 📋 前提条件
- Docker と Docker Compose をインストール済み
- Node.js と npm をインストール済み
- Java (JDK) をインストール済み

### ⚙️ 依存関係のインストール

各コンポーネントの依存関係は個別にインストールします。以下を各フォルダで実行してください。

- client (React)
```bash
cd client
npm install
```

- server-ts (TypeScript サーバー)
```bash
cd server-ts
npm install
```

- server (Java / Gradle)
このリポジトリは Gradle を使用します。`./gradlew`（Gradle ラッパー）が含まれていればラッパーを使ってビルド/実行してください。ラッパーが無い場合はローカルに Gradle がインストールされていればラッパーを生成できます（例: 8.14.3）：

```bash
cd server
# ラッパーを生成（ローカルの gradle が必要）
gradle wrapper --gradle-version=8.14.3

# ラッパーを使った確認・起動
./gradlew --version
./gradlew bootRun
```

ラッパー関連ファイル（`gradlew`, `gradlew.bat`, `gradle/wrapper/gradle-wrapper.jar`, `gradle/wrapper/gradle-wrapper.properties`）はコントリビューターが簡単に同じ手順で動かせるよう、可能であればリポジトリに含めてください。

### 🚀 クイックスタート

以下の順序でコマンドを実行してデモ環境を起動：

1. **インフラストラクチャの起動**
   ```bash
   make infra
   ```
   Keycloak と PostgreSQL コンテナを起動する。

2. **Javaサーバーの起動**
   ```bash
   make javaServer
   ```
   Java ベースのバックエンドサーバーをポート `8081` で起動する。

3. **TypeScriptサーバーの起動**
   ```bash
   make tsServer
   ```
   TypeScript ベースのバックエンドサーバーをポート `8082` で起動する。

4. **クライアントの起動**
   ```bash
   make client
   ```
   React フロントエンドアプリケーションをポート `3000` で起動する。

起動完了後、ブラウザで [http://localhost:3000](http://localhost:3000) にアクセスしてデモを開始できる。

## 🔧 コマンド一覧

#### 🏗️ インフラ起動
Keycloak と PostgreSQL コンテナを起動
```bash
 make infra
```

#### ☕ Java サーバー起動
Java ベースのバックエンドサーバーを起動
```bash
 make javaServer
```

#### 🛠 TypeScript サーバー起動
TypeScript ベースのバックエンドサーバーを起動
```bash
 make tsServer
```

#### ⚛️ クライアント起動
React クライアントを起動
```bash
 make client
```

#### 📜 ログ表示
インフラコンテナのログを表示
```bash
 make logs
```

#### 🛑 サービス停止
すべての実行中サービスを停止
```bash
 make stop
```

#### 🧹 クリーンアップ
すべてのコンテナとログをクリーンアップ
```bash
 make clean
```

#### 📦 DBバックアップ
PostgreSQL データベースのバックアップを作成
```bash
 make backup-db
```
バックアップは `infra/db-backups/` ディレクトリに保存される。

## 🌐 アクセス
- **Keycloak**: [http://localhost:8080](http://localhost:8080)
- **Reactクライアント**: [http://localhost:3000](http://localhost:3000)
- **Spring Bootサーバー**: [http://localhost:8081](http://localhost:8081)

## 📂 ログディレクトリ
React クライアントと Spring Boot サーバーのログは `logs/` ディレクトリに保存される。

## 📝 Notes
- `infra` コマンドでインフラを起動
- クライアントとサーバーは別々のターミナルで実行し、デバッグを容易にする

## 🔁 Keycloak Console → Terraform の整合 (Console → Code)

このリポジトリには、Keycloak コンソール上の既存リソースを Terraform の状態に取り込むための補助スクリプトと手順が含まれています。以下は作業手順の概要と安全上の注意です。

重要: まず `infra/terraform/terraform.tfstate` をバックアップしてください。

手順（要 Keycloak 管理者アカウント、Keycloak が起動していること）:

1. Keycloak 上のリソース UUID を取得
   ```bash
   ./infra/keycloak-migration/get-keycloak-ids.sh
   ```

2. 自動インポート（realm と主要クライアント）
   ```bash
   # リポジトリルートから実行
   infra/terraform/import-existing-keycloak-resources.sh
   ```
   このスクリプトは以下を行います：Terraform の初期化、`keycloak_realm` と主要クライアントの `terraform import`。

3. 追加インポート（プロトコルマッパー、ロールなど）
   - いくつかのリソース（protocol mappers 等）は Provider の import 形式が特殊です。
   - 役割（roles）は `infra/terraform/imported-roles.tf` を作成してから `terraform import` できます。

主要な生成／追加ファイル（このセッションで追加）:
- `infra/terraform/import-existing-keycloak-resources.sh` — realm とクライアントをまとめて import するヘルパー
- `infra/terraform/imported-roles.tf` — 既存の realm role を Terraform に取り込むための最小リソースブロック
- `infra/terraform/newly-generated-resources/imported-roles.tf` — 同内容の補助コピー

注意事項とヒント:
- Provider が `keycloak_openid_client_default_scopes` や `keycloak_openid_client_optional_scopes` の import をサポートしていないため、これらは手動で再作成するか、Terraform 側で apply する必要があります（自動 import は不可）。
- `composite_roles` のように Keycloak コンソールが ID を返す属性については、`lifecycle { ignore_changes = [composite_roles] }` を追加してノイズを避けることを推奨します。
- クライアントシークレット等の秘密は VCS に入れないでください。`TF_VAR_*` 環境変数か安全なシークレットストアを使用してください。
- 変更を適用する前に必ず `terraform plan` を確認してください。

基本的な検証コマンド:
```bash
# state が正しく取り込まれたことを確認
terraform -chdir=infra/terraform state list

# 実差分を確認
terraform -chdir=infra/terraform plan
```

この手順を README に残しておくことで、他の開発者が同じ Console→Code ワークフローで既存 Keycloak リソースを安全に Terraform に取り込めます。
