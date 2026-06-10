## 核心全景：JSP + EL + JSTL 協作機制

在傳統的 Java Web 開發中，這三者是黃金三角：

1. **JSP (JavaServer Pages)**：負責提供 HTML 骨架，允許在頁面中嵌入 Java 程式碼（早期做法）。
2. **EL (Expression Language)**：負責從作用域中「取值」，取代 JSP 中繁瑣的 `<%= %>` Java 運算式。
3. **JSTL (JSP Standard Tag Library)**：負責「邏輯控制」（如迴圈、條件判斷）與「資料處理」（如格式化），取代 JSP 中的 `<% %>` Java 腳本邏輯。

**現代最佳實踐**：在 JSP 頁面中應盡量避免寫任何 Java 程式碼，全面改用 EL 取值 + JSTL 控制邏輯。

---

## 第一部分：JSP (JavaServer Pages) 核心知識點

JSP 的本質就是一個 Servlet。當伺服器（如 Tomcat）第一次接收到對某個 JSP 頁面的請求時，會將該 JSP 檔案「翻譯」並「編譯」成一個 Java 類別（Servlet）。

### 1. JSP 的生命週期 (Lifecycle)

JSP 的生命週期包含以下五個主要階段：

1. **翻譯階段 (Translation)**：Tomcat 將 `.jsp` 檔案解析並翻譯成一個 `.java` 檔案（這是一個繼承了 `HttpJspBase` 的 Servlet 類別）。
2. **編譯階段 (Compilation)**：將上述的 `.java` 檔案編譯成位元組碼 `.class` 檔案。
3. **載入與實例化 (Loading & Instantiation)**：載入 `.class` 檔案，並創建該 Servlet 的實例。
4. **初始化 (Initialization - `jspInit()`)**：呼叫 `_jspInit()` 方法，進行初始化（在整個 Servlet 生命週期中只執行一次）。
5. **請求處理 (Request Processing - `_jspService()`)**：每次有客戶端請求該 JSP 時，都會建立新的執行緒並呼叫 `_jspService(HttpServletRequest, HttpServletResponse)` 方法來處理請求並生成 HTML 響應。
6. **銷毀 (Destruction - `jspDestroy()`)**：當 Web 應用程式卸載或伺服器關閉時，呼叫 `_jspDestroy()` 方法釋放資源。

### 2. JSP 的四大作用域 (Scopes)

作用域決定了變數/物件在應用程式中的「存活時間」與「可見範圍」。依範圍由小到大排列：

| 作用域名稱      | 對應的 JSP 隱含物件 | 存活時間與有效範圍                                                                                                                                               | 常見應用場景                                                                               |
| :-------------- | :------------------ | :--------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------- |
| **Page**        | `pageContext`       | 當前頁面有效。當頁面執行完畢並響應給客戶端後，資料即被銷毀。若發生 forward 轉發，資料也會遺失。 | 單一頁面內的暫時性變數傳遞、自訂標籤的資料處理。                      |
| **Request**     | `request`           | 單次 HTTP 請求內有效。可透過伺服器端的 `request.getRequestDispatcher().forward()` 在多個 Servlet/JSP 間傳遞。         | MVC 架構中，Controller (Servlet) 將查詢到的資料交由 View (JSP) 呈現。 |
| **Session**     | `session`           | 單一使用者的會話期間有效。從打開瀏覽器訪問到關閉瀏覽器，或 Session 逾時（預設通常為 30 分鐘）為止。                   | 使用者登入狀態、購物車內容。                                          |
| **Application** | `application`       | 整個 Web 應用程式運行期間有效。伺服器啟動時建立，關閉時銷毀，所有使用者共享。                                         | 線上總人數統計、全站共用的系統設定參數。                              |

*(註：若在使用 EL 取值時沒有指定作用域，尋找順序為：Page -> Request -> Session -> Application。)*

### 3. JSP 的九大隱含物件 (Implicit Objects)

JSP 引擎在呼叫 `_jspService` 時，會自動建立 9 個物件，開發者可以直接在 `<% %>` 中使用，無需 `new`。

1. **`request` (HttpServletRequest)**：封裝客戶端請求資訊（參數、標頭等）。
2. **`response` (HttpServletResponse)**：封裝伺服器對客戶端的響應。
3. **`pageContext` (PageContext)**：JSP 頁面的上下文，可以獲取其他 8 個隱含物件，並可操作四大作用域的屬性。
4. **`session` (HttpSession)**：與客戶端的會話物件（若 directive `session="false"` 則無法使用）。
5. **`application` (ServletContext)**：代表整個 Web 應用程式的環境。
6. **`config` (ServletConfig)**：該 JSP (Servlet) 的設定資訊。
7. **`out` (JspWriter)**：用於向客戶端輸出資料的字元輸出流。
8. **`page` (Object)**：代表當前 JSP 頁面的 Servlet 實例（相當於 Java 中的 `this`）。
9. **`exception` (Throwable)**：封裝 JSP 拋出的例外錯誤（僅在指令 `<%@ page isErrorPage="true" %>` 時可用）。

### 4. JSP 的三大指令 (Directives)

指令用於設定整個 JSP 頁面的全域屬性，語法為 `<%@ directive attribute="value" %>`。

* **`page` 指令**：設定頁面屬性。
    * `import="java.util.*"`：匯入 Java 套件。
    * `contentType="text/html; charset=UTF-8"`：設定回應內容類型與編碼。
    * `pageEncoding="UTF-8"`：設定 JSP 檔案本身的儲存編碼。
    * `errorPage="error.jsp"`：指定當前頁面發生例外時要跳轉的錯誤頁面。
    * `isErrorPage="true"`：宣告此頁面為錯誤處理頁面，從而可以使用 `exception` 物件。
* **`include` 指令**：靜態包含。`<%@ include file="header.jsp" %>`。在翻譯階段將目標檔案的程式碼原封不動地貼過來，合併成一個 Servlet 執行。效能高。
* **`taglib` 指令**：匯入自訂標籤庫或 JSTL。`<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>`。

### 5. JSP 動作標籤 (Action Tags)

與指令不同，動作標籤是在請求處理階段執行的。

* `<jsp:include page="file.jsp" />`：動態包含。兩支 JSP 分別編譯成不同的 Servlet，在執行時才將結果合併。適合包含動態內容。
* `<jsp:forward page="file.jsp" />`：伺服器端內部轉發（URL 不變）。
* `<jsp:param name="key" value="val" />`：通常配合 include 或 forward 傳遞參數。
* `jsp:useBean`, `jsp:setProperty`, `jsp:getProperty`：(早期用法) 用於操作 JavaBean，現已多被 EL 搭配 JSTL 取代。

---

## 第二部分：EL (Expression Language) 表達式語言

EL 的出現是為了簡化 JSP 頁面中的資料讀取，讓前端頁面更乾淨。 
語法：`${ 運算式 }`

### 1. EL 的核心功能與尋找機制

* **獲取資料**：EL 主要是用來讀取四大作用域中的屬性值（Attribute），無法讀取區域變數。
* **尋找順序**：`${user.name}` 會依序在 `pageContext` -> `request` -> `session` -> `application` 尋找名為 "user" 的物件。一旦找到就立即返回並呼叫 `getName()` 方法；若全部找不到，會回傳空字串 `""` (不會拋出 NullPointerException)。

### 2. EL 的運算子

* **屬性導覽 (Property Navigation)**：`.` 或 `[]`。
    * `${user.name}` (底層呼叫 `user.getName()`)
    * `${map["key-name"]}` (當 key 包含特殊字元時使用中括號)
    * `${list[0]}` (獲取陣列或 List 的元素)
* **算術/邏輯/關係運算子**：支援 `+`, `-`, `*`, `/`, `%`, `==` (或 `eq`), `!=` (或 `ne`), `<`, `>`, `&&` (或 `and`), `||` (或 `or`), `!` (或 `not`) 等。
* **❗ 空值判斷運算子 `empty`**：`${empty user}`。這非常常用！當 user 為 `null`、空字串 `""`、空陣列、或空的 Collection (List/Map) 時，皆會回傳 `true`。

### 3. EL 的 11 大隱含物件

注意：EL 的隱含物件與 JSP 的隱含物件不同（只有 `pageContext` 是兩者共通的）。

1. **作用域限定物件**：`pageScope`, `requestScope`, `sessionScope`, `applicationScope`。
    * *用途*：強制指定從某個作用域取值，如 `${sessionScope.user}`，避免被較小作用域的同名變數覆蓋。
2. **請求參數物件**：
    * `param`：獲取單一參數，如 `${param.username}` 等同於 `request.getParameter("username")`。
    * `paramValues`：獲取同名多值參數（如 checkbox），回傳陣列，如 `${paramValues.hobby[0]}`。
3. **標頭資訊物件**：`header`, `headerValues`。
4. **Cookie 物件**：`cookie`。
    * *用途*：`${cookie.JSESSIONID.value}` 可獲取指定 Cookie 的值。
5. **初始化參數物件**：`initParam` (獲取 `web.xml` 中的 `<context-param>`)。
6. **`pageContext`**：這是 EL 中唯一非 Map 型態的隱含物件，它就是 JSP 的 `pageContext`。
    * *經典應用*：`${pageContext.request.contextPath}` 用於動態獲取專案的根路徑（Context Path），解決寫死絕對路徑的問題。

---

## 第三部分：JSTL (JSP Standard Tag Library) 標籤庫重點

JSTL 提供了一套標準的標籤，用來處理邏輯判斷、迴圈迭代、資料格式化等，徹底消滅 JSP 頁面中的 `<% Java code %>`。 
使用前必須在 JSP 頂部匯入：

### 1. 核心標籤庫 Core Tags (`prefix="c"`)

最常用、最重要的標籤庫。

* **`<c:set>`**：在指定作用域中設定變數或物件的屬性。
* **`<c:out>`**：輸出資料。優點是可以防止 XSS 攻擊（預設會跳脫 HTML 特殊字元）。
* **`<c:remove>`**：移除指定作用域的變數。
* **`<c:if>`**：單一條件判斷（JSTL 沒有 `<c:else>`）。
* **`<c:choose>`, `<c:when>`, `<c:otherwise>`**：相當於 Java 的 `if-else if-else` 或 `switch`。
* **`<c:forEach>`**：最強大的迴圈標籤。用於遍歷 List、Set、Map 或陣列。
    * `items`：要遍歷的集合（通常用 EL 給值）。
    * `var`：目前迭代元素的變數名稱。
    * `varStatus`：迴圈狀態物件（可獲取 `index` 索引、`count` 計數、`first`、`last` 等）。
* **`<c:url>` 與 `<c:param>`**：動態生成 URL，並自動處理 URL Rewriting（若客戶端禁用 Cookie 時自動附加上 session id）及中文參數編碼。

### 2. 格式化標籤庫 Formatting Tags (`prefix="fmt"`)

處理日期、時間、數字、貨幣的國際化顯示。

* **`<fmt:formatDate>`**：將 `java.util.Date` 物件格式化為字串。
* **`<fmt:parseDate>`**：將字串解析回 `java.util.Date` 物件。
* **`<fmt:formatNumber>`**：格式化數字（千位分隔符、小數點位數、貨幣符號）。

### 3. 函式標籤庫 Function Tags (`prefix="fn"`)

本質上是呼叫 Java `String` 類別的方法，用於字串處理。必須與 EL 搭配使用。

* **字串長度與判斷**：`fn:length(collection/string)`, `fn:contains(str, search)`
* **字串操作**：`fn:substring(str, begin, end)`, `fn:replace(str, before, after)`, `fn:split(str, delimiter)`

---

## 總結

1. **JSP** 是載體，理解它的 LifeCycle 和四大作用域是管理資料生命週期的基礎。
2. **EL** 是橋樑，透過 `${}` 優雅地從作用域中取出資料，尤其是 `.運算子` 和 `empty` 關鍵字最為核心。
3. **JSTL** 是引擎，處理視圖層的渲染邏輯。精通 `<c:if>` 和 `<c:forEach>` 足以應付 80% 的日常開發需求；結合 `fmt:formatDate`則能解決惱人的日期顯示問題。