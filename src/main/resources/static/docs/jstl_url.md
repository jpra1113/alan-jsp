# JSTL URL 處理與資源匯入 (Day 2-3)

本單元設計為 90 分鐘，專注於 JSTL 提供的 URL 管理與外部資源整合能力，解決硬編碼路徑與 Session 追蹤問題。

## 1. 課程大綱
- **[30m] 動態 URL 建構**：`<c:url>` 自動加上 Context Path 並進行編碼。
- **[20m] 參數附加**：`<c:param>` 安全地附加 Query String。
- **[30m] 資源匯入**：`<c:import>` 整合其他網頁或文字資源。
- **[10m] 對比分析**：`<c:url>` vs 手動字串拼接的優劣。

## 2. 核心觀念：為何需要 c:url？
1. **Context Path 自動前綴**：部署在不同路徑時無需修改連結。
2. **URL 編碼**：自動處理中文、特殊字元與 `jsessionid` 附加（當瀏覽器停用 Cookie 時）。
3. **安全性**：避免參數注入攻擊。

## 3. 實作任務
### 實驗 1：安全的超連結
- 建立一個指向 `/learning/jsp/scopes` 的連結。
- 附加兩個參數：`user=ADMIN` 與 `session=${pageContext.session.id}`。
- 觀察產生的 URL 是否包含 Context Path 及正確編碼。

### 實驗 2：匯入本機 Markdown 文件
- 使用 `<c:import url="/docs/jstl.md" var="mdContent"/>`。
- 將匯入的內容用 `<pre>` 顯示，或用 `<c:out>` 跳脫 HTML。

### 實驗 3：動態課程導航列
- 給定主題清單 `['lifecycle','scopes','el','scriptlet']`。
- 利用 `<c:forEach>` 搭配 `<c:url>` 產生各主題的超連結，並統一加上 `ref=jstl-lab` 參數。

## 4. 關鍵語法清單
- `<c:url value="/path" var="link"> <c:param name="key" value="val"/> </c:url>`
- `<c:import url="http://example.com/page" var="remoteContent" charEncoding="UTF-8"/>`
- `<a href="${link}">...</a>`

## 5. 課後練習 (30m)
### 挑戰 1：多語言切換器
- **目標**：練習 `<c:url>` 與參數控制。
- **實作**：在頁面上放置「中文｜英文」兩個按鈕，點擊時將 `?lang=zh` 或 `?lang=en` 附加到目前 URL（並保留原有參數）。

### 挑戰 2：頁尾共用元件
- **目標**：使用 `<c:import>` 達到頁面複用。
- **實作**：建立一個 `footer.jspf`（內容為版權宣告），並在 `jstl_url.jsp` 中用 `<c:import>` 引入。
