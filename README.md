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
