# iReport 知識點

## 1. 什麼是 iReport

- iReport 是 JasperReports 的可視化報表設計器
- 用來設計、編輯、預覽和編譯 JRXML 報表模板
- 可直接連線資料源，生成報表並匯出 PDF/Excel/HTML 等格式

## 2. 核心概念

- `JRXML`：報表的 XML 定義檔，包含欄位、參數、變數、區段和元件配置
- `編譯`：將 JRXML 轉換為 Jasper 檔案（`.jasper`）以供報表引擎使用
- `Report Bands`（區段）:
  - `Title`：報表標題區塊
  - `Page Header` / `Page Footer`：每頁顯示的頁首 / 頁尾
  - `Column Header` / `Column Footer`：每欄顯示的標題 / 結尾
  - `Detail`：主要資料列輸出區，通常放動態欄位
  - `Summary`：報表總結、合計、結尾資訊
  - `Group Header` / `Group Footer`：分組標題與分組小計
- `Fields`：從資料來源導入的資料欄位
- `Parameters`：外部傳入的報表參數，例如日期、篩選條件、使用者資訊
- `Variables`：報表內部計算欄位，可做累加、計數、平均、最大/最小等運算

## 3. 資料來源

常見資料來源類型：

- SQL 資料庫（JDBC）
- Java Bean 或 Java 物件清單
- XML
- CSV
- JSON
- 自訂 DataSource

在 iReport 中可建立 Data Source 以測試查詢和報表預覽。

## 4. 常用元件

- `Text Field`：顯示動態資料，例如 `$F{field}`, `$P{parameter}`, `$V{variable}`
- `Static Text`：固定文字標題或說明
- `Image`：插入圖片或 QR code
- `Line` / `Rectangle`：用於版面排版和區塊分隔
- `Subreport`：嵌套子報表以重複使用報表設計
- `Chart`：長條圖、折線圖、圓餅圖、面積圖等圖表
- `Table` / `List`：呈現複雜表格或清單資料
- `Crosstab`：交叉分析報表
- `Barcode` / `Component`：進階物件，例如條碼、HTML 元素

## 5. 排版與格式

- `Style`：建立共用樣式，統一管理字型、顏色、邊框、對齊
- `Conditional Style`：根據資料條件變更樣式
- `Stretch Type`：文字區塊自動伸縮，避免內容截斷
- `Print When Expression`：條件式列印元件，可依值決定是否顯示
- `Position Type`：決定元件在區段內的定位方式，如 `FixRelativeToTop`、`Float`
- `Line Spacing`、`Padding`、`Border`：調整報表版面細節

## 6. 進階功能

- `Group`：資料分組與小計
- `Subdataset`：在同一報表中使用多個資料集
- `Scriptlet`：使用 Java 程式碼自訂報表邏輯
- `Built-in functions`：例如 `PAGE_NUMBER`, `COLUMN_NUMBER`, `REPORT_COUNT`
- `Cross-band`：跨欄位邊框和區塊設計
- `Report Query`：使用 SQL、XML、JSON 或自訂語法來取得資料

## 7. 匯出方式

iReport / JasperReports 支援的匯出格式：

- PDF
- HTML
- XLS / XLSX
- CSV
- RTF
- XML
- ODT
- DOCX
- PPTX

## 8. iReport 與 JasperReports 的關係

- iReport：報表設計工具（前端），主要負責建立和編輯 JRXML
- JasperReports：Java 報表引擎，負責填充資料、編譯報表和匯出檔案

## 9. 常見應用場景

- 發票、訂單、出貨單
- 會計 / 財務報表
- 銷售與庫存分析
- ERP / CRM 報表
- 系統統計與列印輸出

## 10. 版本與替代工具

- iReport 已停止維護，最新穩定工具為 `Jaspersoft Studio`
- Jaspersoft Studio 支援更新版 JasperReports、Eclipse 插件、更多元件與雲端整合
- 若要長期維護，建議使用 `Jaspersoft Studio` 取代 iReport

## 11. 使用小技巧

- 先設計好資料庫查詢，再把字段對應到 `Fields`
- 使用 `Preview` 測試資料輸出和版面
- 常用 `Print When Expression` 篩選顯示內容
- 透過 `Style` 管理字型與顏色一致性
- 若報表版面不正確，檢查 `Stretch Type` 和 `Position Type`
- 若需重複使用區塊，改用 `Subreport` 或 `Table`

## 12. iReport 基礎教學

1. 新增報表
   - 開啟 iReport，選擇「File > New」或「Wizard」建立新報表
   - 選擇報表範本（Blank A4、Blank Letter、Simple Report 等）
2. 設定資料來源
   - 在 Data Source 窗口新增 JDBC 連線、Java Bean、XML 或 JSON Source
   - 測試連線是否成功
3. 設計報表欄位
   - 建立 `Fields`，對應資料來源中的欄位名稱
   - 新增 `Parameters` 以接收外部參數
   - 建立 `Variables` 以計算總和、計數或平均值
4. 放置元件
   - 在 `Title` 放置報表標題和公司 Logo
   - 在 `Column Header` 放置欄位標題
   - 在 `Detail` 放置 `Text Field` 顯示動態資料
   - 在 `Summary` 放置總計或摘要資訊
5. 調整版面與樣式
   - 使用 `Style` 統一字型、顏色和邊框
   - 設定 `Stretch Type` 讓文字自動換行
   - 加上 `Print When Expression` 控制內容顯示
6. 預覽與匯出
   - 按 `Preview` 檢查資料輸出與版面
   - 匯出成 PDF、HTML、XLS 等格式

## 13. iReport 快速上手範例

範例：建立簡單客戶清單報表

1. 資料來源設定
   - 使用 JDBC 連線到資料庫
   - 查詢語句：`SELECT id, name, email, phone FROM customers`
2. 新增 Fields
   - `id`、`name`、`email`、`phone`
3. 報表區段配置
   - `Title`：`Customer List`
   - `Column Header`：`ID`, `Name`, `Email`, `Phone`
   - `Detail`：對應各欄位的 `Text Field`
   - `Summary`：統計總筆數，例如 `$V{REPORT_COUNT}`
4. 常用設定
   - `Text Field` 設為 `Stretch with overflow`
   - `Position Type` 設為 `Float`，避免欄位重疊
   - `Print When Expression`：例如 `new Boolean($F{email} != null)`，只顯示存在 Email 的欄位
5. 匯出建議
   - 先以 PDF 預覽格式
   - 再匯出為 XLS / XLSX，以供 Excel 查看

## 14. 常見問題

- Q：為什麼報表顯示內容被截斷？
  - A：請檢查 `Text Field` 的 `Stretch Type` 是否設為 `Relative to Tallest Object`，並確認區段高度足夠。
- Q：為什麼查詢結果無法顯示？
  - A：先檢查資料來源連線、SQL 語句是否正確，並確保 `Fields` 名稱與資料列欄位一致。
- Q：為什麼報表匯出後格式跑版？
  - A：檢查 `Position Type`、`Stretch Type` 和元件邊界是否正確配置，或改用 `Table` 元件排版。

## 15. Jaspersoft Studio 基礎教學

1. 安裝與啟動
   - 下載 Jaspersoft Studio 並安裝，或在 Eclipse 中安裝 Jaspersoft Studio 外掛
   - 啟動後，選擇工作區（Workspace）
2. 建立新報表
   - 選擇 `File > New > Jasper Report`
   - 由報表精靈選擇範本：`Blank A4`, `Simple Report`, `Tabular`, `Cross Tab` 等
3. 設定資料來源
   - 在 `Repository Explorer` 或 `Data Adapter` 新增資料源
   - 支援 JDBC、JSON、XML、CSV、Hibernate 等資料來源
   - 測試資料適配器是否正常連線
4. 新增欄位與參數
   - 點選 `Outline` 視窗中的 `Fields` 節點，新增欄位或從資料來源導入
   - 新增 `Parameters` 以外部傳遞資料
   - 在 `Variables` 下新增統計或累加變數
5. 設計報表版面
   - 將元件拖曳到 `Title`, `Column Header`, `Detail`, `Summary` 分區
   - 使用 `Text Field`, `Static Text`, `Image`, `Chart`, `Table` 等元件
   - 使用 `Properties` 面板設定樣式、邊距、對齊、表現式
6. 預覽與編譯
   - 點擊 `Preview` 檢視報表結果
   - 如果需要，按 `Compile Report` 生成 `.jasper` 檔案
7. 匯出與整合
   - 在 `Preview` 中匯出為 PDF、HTML、XLS、DOCX 等格式
   - 將編譯後的 `.jasper` 檔案與 Java 專案整合，透過 `JasperFillManager` 與 `JasperExportManager` 建立報表

## 16. 實際 JRXML 範例

以下範例是一個簡單客戶清單報表的 JRXML 範本，包含標題、欄位與資料列輸出：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<jasperReport xmlns="http://jasperreports.sourceforge.net/jasperreports"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://jasperreports.sourceforge.net/jasperreports http://jasperreports.sourceforge.net/xsd/jasperreport.xsd"
    name="customer_list" pageWidth="595" pageHeight="842" columnWidth="515" leftMargin="40" rightMargin="40" topMargin="50" bottomMargin="50" uuid="12345678-1234-1234-1234-1234567890ab">

    <parameter name="ReportTitle" class="java.lang.String"/>

    <field name="id" class="java.lang.Integer"/>
    <field name="name" class="java.lang.String"/>
    <field name="email" class="java.lang.String"/>
    <field name="phone" class="java.lang.String"/>

    <title>
        <band height="50">
            <staticText>
                <reportElement x="0" y="10" width="515" height="30"/>
                <textElement textAlignment="Center" verticalAlignment="Middle">
                    <font size="18" isBold="true"/>
                </textElement>
                <text><![CDATA[$P{ReportTitle}]]></text>
            </staticText>
        </band>
    </title>

    <columnHeader>
        <band height="20">
            <staticText>
                <reportElement x="0" y="0" width="50" height="20"/>
                <text><![CDATA[ID]]></text>
            </staticText>
            <staticText>
                <reportElement x="60" y="0" width="150" height="20"/>
                <text><![CDATA[Name]]></text>
            </staticText>
            <staticText>
                <reportElement x="220" y="0" width="180" height="20"/>
                <text><![CDATA[Email]]></text>
            </staticText>
            <staticText>
                <reportElement x="410" y="0" width="105" height="20"/>
                <text><![CDATA[Phone]]></text>
            </staticText>
        </band>
    </columnHeader>

    <detail>
        <band height="20">
            <textField>
                <reportElement x="0" y="0" width="50" height="20"/>
                <textFieldExpression><![CDATA[$F{id}]]></textFieldExpression>
            </textField>
            <textField>
                <reportElement x="60" y="0" width="150" height="20"/>
                <textFieldExpression><![CDATA[$F{name}]]></textFieldExpression>
            </textField>
            <textField>
                <reportElement x="220" y="0" width="180" height="20"/>
                <textFieldExpression><![CDATA[$F{email}]]></textFieldExpression>
            </textField>
            <textField>
                <reportElement x="410" y="0" width="105" height="20"/>
                <textFieldExpression><![CDATA[$F{phone}]]></textFieldExpression>
            </textField>
        </band>
    </detail>

    <summary>
        <band height="30">
            <staticText>
                <reportElement x="0" y="5" width="200" height="20"/>
                <text><![CDATA[Total customers:]]></text>
            </staticText>
            <textField>
                <reportElement x="210" y="5" width="100" height="20"/>
                <textFieldExpression><![CDATA[$V{REPORT_COUNT}]]></textFieldExpression>
            </textField>
        </band>
    </summary>

</jasperReport>
```

這個範例可直接在 Jaspersoft Studio 或 iReport 中建立新報表，並將欄位對應到你的資料來源。若要更進一步，可加入分組、條件式樣式與圖表。
