<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>カスタムテーマ・ログイン</title>
    <link rel="stylesheet" href="${url.resourcesPath}/css/style.css">
</head>
<body>
    <div class="login-card">
        <div class="login-title">カスタムテーマ</div>
        <form method="post" action="${url.loginAction}">
            <div class="form-group">
                <label class="form-label" for="username">ユーザ名</label>
                <input class="form-input" id="username" name="username" type="text" autofocus required value="${(login.username!'')}">
            </div>
            <div class="form-group">
                <label class="form-label" for="password">パスワード</label>
                <input class="form-input" id="password" name="password" type="password" placeholder="パスワードを入力" required>
            </div>
            <#if realm.resetPasswordAllowed>
                <a class="forgot-link" href="${url.loginResetCredentialsUrl}">パスワードを忘れた方はコチラ</a>
            </#if>
            <button class="login-btn" type="submit">ログイン</button>
        </form>
    </div>
</body>
</html>
