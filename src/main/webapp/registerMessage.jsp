<%--セッションを利用して、フォームの内容を保存するJSPを作成してみましょう。 --%>
<%--
・「メッセージ」をGETリクエストとして送信することができるformを持つ
・「メッセージ」をリクエストパラメーターとして受け取ると、セッションにメッセージを保存できる
・セッションに「メッセージ」が保存されている場合、入力フォームに保存されているメッセージを表示する
・セッションの有効期限は3分とする
・セッションを手動で破棄することができるリンクを持つ --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
//セッションの有効期限設定
session.setMaxInactiveInterval(180);

String logout = (String) request.getParameter("logout");
String message = null;

if (logout != null && logout.equals("true")) {
	//セッションの破棄処理
	session.invalidate();
} else {
	//GETパラメータから「メッセージ」を取り出す
	message = (String) request.getParameter("message");
	if (message != null) {
		//取得した「メッセージ」、セッションに保存
		session.setAttribute("message", message);
	} else {
		//「メッセージ」が送信されていなかったので、セッションからメッセージを取得
		message = (String) session.getAttribute("message");
	}
}
//メッセージがnullの場合、空の文字列を代入
if (message == null)
	message = "";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>registerMassage</title>
<style>
ul {
	list-style: none;
}
</style>
</head>
<body>
	<form method="GET" action="/jsp/registerMessage.jsp">
		<ul>
			<li><label for="message">メッセージ</label><input type="text"
				name="message" value="<%=message%>" /></li>
			<li><input type="submit" value="登録" /> <a
				href="/jsp/registerMessage.jsp?logout=true">ログアウト</a></li>
		</ul>
	</form>
</body>
</html>