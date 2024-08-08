<%--2. JSTL と式言語を使用した JSP で、行事の表示システムを作成しましょう
JSTLと式言語を使って、日付に応じた行事を表示するシステムを実装してみましょう。

以下の条件を満たすように、残りの部分を埋めてみてください。

■前提について
・ファイル名は `calendar.jsp` とする
・受け取った日付に対応する行事を表示できる
・行事については事前に 20 個ほど調べて、JSP上で保持する
・行事の管理はマップ (java.util.Map) を利用する
・以下の STL のライブラリーを使用する
・Core
・i18n
・Functions
■日付と行事の表示について
・日付の横に「曜日」を表示する
・日付の下に、その日に関連した行事を表示する
・初期表示では、今日の日付を表示する
・日付を指定して送信するための入力フォームを持つ
・日付が指定された場合、その日付を表示する
■入力フォームについて
・POSTリクエストを利用して日付を送信することができる
・年と月と日を指定するための3つのテキストエリアを持つ
 --%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.ZoneId"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="ja_JP" />
<%!private static Map eventMap = new HashMap();
	static {
		eventMap.put("20240101", "お正月");
		eventMap.put("20240203", "節分");
		eventMap.put("20240214", "バレンタイン");
		eventMap.put("20240303", "ひな祭り");
		eventMap.put("20240314", "ホワイトデー");
		eventMap.put("20240401", "エイプリルフール");
		eventMap.put("20240512", "母の日");
		eventMap.put("20240616", "父の日");
		eventMap.put("20240707", "七夕");
		eventMap.put("20240715", "海の日");
		eventMap.put("20240811", "山の日");
		eventMap.put("20240811", "山の日");
		eventMap.put("20240916", "敬老の日");
		eventMap.put("20240922", "秋分の日");
		eventMap.put("20241014", "スポーツの日");
		eventMap.put("20241031", "ハロウィン");
		eventMap.put("20241103", "文化の日");
		eventMap.put("20241123", "勤労感謝の日");
		eventMap.put("20241225", "クリスマス");
		eventMap.put("20241231", "大晦日");
	}%>
	<%
 String year = (String)request.getParameter("year");
  String month = (String)request.getParameter("month");
  String day = (String)request.getParameter("day");
  LocalDate localDate = null;
  if (year == null || month == null || day == null) {
    localDate = LocalDate.now();
    year = String.valueOf(localDate.getYear());
    month = String.valueOf(localDate.getMonthValue());
    day = String.valueOf(localDate.getDayOfMonth());
  } else {
    localDate = LocalDate.of(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(day));
  }
  String[] dates = {year, month, day};
  pageContext.setAttribute("dates", dates);  
  pageContext.setAttribute("date", Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant()));
  String event = (String)eventMap.get(year + month + day);
  pageContext.setAttribute("event", event);
%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8">
<title>calendar</title>
<style>
ul {
  list-style: none;
}
</style>
</head>
<body>
  <form method="POST" action="/jsp/calendar.jsp">
    <ul>
      <li><input type="text" name="year" value="${param['year']}" /><label for="year">年</label><input type="text" name="month" value="${param['month']}" /><label for="month">月</label><input type="text" name="day" value="${param['day']}" /><label for="day">日</label></li>
      <li><input type="submit" value="送信" />
      <li><c:out value="${fn:join(dates, '/')}" /> (<fmt:formatDate value="${date}" pattern="E" />)</li>
      <li><c:out value="${event}" /></li>
    </ul>
  </form>
</body>
</html>

