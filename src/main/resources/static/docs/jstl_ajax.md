# JSTL + AJAX 整合實戰 (Day 2-4)

本單元設計為 120 分鐘，結合前端 jQuery 與後端 Spring Boot API，實作非同步資料互動，並與 JSTL 的伺服器端渲染策略進行對比。

## 1. 課程大綱
- **[20m] API 設計分析**：檢視 `/api/options` 提供的 JSON 資料結構。
- **[40m] AJAX 請求實作**：使用 jQuery `$.ajax` 取得資料並動態產生 HTML。
- **[30m] 前後端渲染對比**：表格比較 JSTL (SSR) 與 AJAX (CSR) 的適用場景。
- **[30m] 完整整合練習**：結合 `<c:url>` 與 AJAX 請求路徑管理。

## 2. 核心觀念：混合渲染策略
- **伺服器端渲染 (SSR, JSTL)**：適合 SEO 需求、初次載入即須顯示的內容（如產品列表）。
- **用戶端渲染 (CSR, AJAX)**：適合不需刷新頁面的互動操作（如下拉選單動態載入、表單即時驗證）。
- **實務最佳實踐**：頁面骨架與靜態內容使用 JSTL，動態區域使用 AJAX 填充。

## 3. 實作任務
### 實驗 1：載入下拉選單資料
- 點擊按鈕後呼叫 `/api/options`。
- 成功時將回傳的 `[{id, name}]` 轉換為 `<option>` 並插入表單。

### 實驗 2：錯誤處理與使用者提示
- 模擬網路中斷或 API 錯誤，顯示「載入失敗」訊息。
- 練習 `$.ajax` 的 `error` 回呼函式。

### 實驗 3：混合使用 c:url 與 AJAX
- 使用 `<c:url var="apiUrl" value="/api/options"/>` 產生正確的 Context Path。
- 在 JavaScript 中引用 `${apiUrl}`，確保部署路徑變動時 AJAX 請求不失效。

## 4. 關鍵語法清單
- `$.ajax({ url, type, dataType, success, error })`
- `marked.parse(mdContent)`（若整合 Markdown 預覽）
- JSTL 產生 JavaScript 變數：`var ctxPath = "${pageContext.request.contextPath}";`

## 5. 課後練習 (30m)
### 挑戰 1：即時搜尋建議
- **目標**：結合 AJAX 與輸入事件。
- **實作**：建立一個文字輸入框，當使用者輸入時，呼叫後端搜尋 API（可自行建立簡單的模擬 API），並即時顯示匹配的結果清單。

### 挑戰 2：無刷新分頁
- **目標**：練習動態載入表格內容。
- **實作**：在 `jstl_ajax.jsp` 中加入「下一頁」按鈕，點擊時透過 AJAX 取得下一頁的產品資料（後端需支援 `?page=1` 參數），並更新表格內容。
