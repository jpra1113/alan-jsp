# JSTL 核心標籤入門 (Day 2-1)

本單元設計為 90 分鐘的實戰內容，旨在讓學生掌握 JSTL 核心標籤庫，徹底取代 Scriptlet 中的流程控制與輸出。

## 1. 課程大綱
- **[20m] 變數管理**：使用 `<c:set>` 與 `<c:remove>` 操作作用域屬性。
- **[20m] 安全輸出**：`<c:out>` 的 XSS 防護機制與 `escapeXml` 屬性。
- **[30m] 條件控制**：`<c:if>` 與 `<c:choose>` 家族（`when` / `otherwise`）。
- **[20m] 異常處理**：`<c:catch>` 優雅捕捉頁面例外。

## 2. 核心觀念：為什麼使用 JSTL？
1. **無 Java 程式碼**：JSP 頁面僅保留標籤，提高可讀性與維護性。
2. **自動 XSS 防護**：`<c:out>` 預設跳脫 HTML 標籤，防止指令碼攻擊。
3. **邏輯與呈現分離**：條件、迴圈等由標籤完成，JSP 更像樣板引擎。

## 3. 實作任務
### 實驗 1：計算獎金並刪除變數
- 使用 `<c:set>` 計算 `accountBalance * 0.1` 存入 `bonus`。
- 使用 `<c:remove>` 移除該變數，觀察 `${bonus}` 輸出。

### 實驗 2：XSS 攻擊防護測試
- 提供一段包含 `<script>alert('XSS')</script>` 的字串。
- 比較 `escapeXml="true"`（預設）與 `false` 的渲染差異。

### 實驗 3：使用者角色權限面板
- 根據 `userRole`（ADMIN / USER）與 `isLoggedIn` 顯示不同區塊。
- 實作 `<c:choose>` 多分支判斷。

## 4. 關鍵語法清單
- `<c:set var="name" value="..." scope="page|request|session|application"/>`
- `<c:out value="${expr}" escapeXml="true"/>`
- `<c:if test="${condition}"> ... </c:if>`
- `<c:choose> <c:when test="..."> ... </c:when> <c:otherwise> ... </c:otherwise> </c:choose>`
- `<c:catch var="ex"> ... </c:catch>`

## 5. 課後練習 (30m)
### 挑戰 1：會員等級徽章
- **目標**：練習 `<c:choose>` 巢狀判斷。
- **實作**：給定 `points` 變數（例如 3200），使用 `<c:set>` 設定。當 points ≥ 3000 顯示「鑽石會員」；≥ 1500 顯示「黃金會員」；否則顯示「普通會員」。

### 挑戰 2：自訂錯誤訊息捕捉
- **目標**：使用 `<c:catch>` 攔截例外。
- **實作**：在頁面中故意寫入會拋出 `NullPointerException` 的 EL（如 `${nullVar.length()}`），用 `<c:catch>` 捕捉並顯示「發生錯誤：xxx」。
