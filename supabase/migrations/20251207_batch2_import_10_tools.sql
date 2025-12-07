/*
  # Import Tools - Batch 2 of 3 (Phase 3 Expansion)

  ## Overview
  This migration imports 10 tools as part of batch 2.
  Tools in this batch: Atlassian, Jam.dev, Temporal, Typedream, Triform, Kintone, Kubernetes, Carrd, Mintlify, Zenler

  ## Data Source
  Generated from additional_tools_dataset.json

  ## Import Strategy
  - Each tool gets a unique UUID
  - Categories are properly mapped to match existing schema
  - Translations are added for zh-TW locale
  - Common pairings are stored in categories
  - Curation batch: v3.0-expansion-batch2

  ## Date
  Generated: 2025-12-07T15:22:03.779Z
*/

-- Import tools (Batch 2)
DO $$
DECLARE
  tool_id UUID;
BEGIN

  -- 1. Atlassian
  tool_id := gen_random_uuid();
  INSERT INTO tools (
    id,
    tool_name,
    summary,
    source_slug,
    categories,
    description_styles,
    use_case_templates,
    is_curated,
    curation_batch,
    generation_source,
    created_at,
    updated_at
  ) VALUES (
    tool_id,
    'Atlassian',
    'Suite of collaboration and productivity software including Jira, Confluence, Trello, and Bitbucket.',
    'atlassian',
    '{"purpose":["System Oriented","Application Oriented"],"functional_role":["Project Management","Documentation","Version Control"],"application_field":["Software Development","Team Collaboration"],"tech_layer":["Integration Layer","Frontend Layer"],"data_flow_role":["Input","Processing","Output"],"difficulty":"No-code","common_pairings":["Slack","GitHub","Jira Service Management"]}'::jsonb,
    '{"encyclopedia":"Atlassian 提供多款軟體，如 Jira、Confluence、Bitbucket，支援專案管理、文件協作與程式版本控制。","guide":"在軟體專案中，Jira 用於任務追蹤，Confluence 用於知識共享，而 Bitbucket 用於源碼管理。這些工具彼此整合，方便團隊協作。","strategy":"如果您的團隊需要一站式管理開發任務、知識庫和程式碼，可以選擇 Atlassian 的產品組合，並整合 Slack 或 CI/CD 工具。","inspiration":["使用 Jira Sprint 管理敏捷迭代並追蹤進度。","建立 Confluence 空間共享設計文件與決策記錄。","使用 Bitbucket Pipelines 執行自動部署流程。"]}'::jsonb,
    '[{"goal":"改善團隊專案管理與協作","method":"使用 Atlassian 套件","tool_stack":["Jira","Confluence","Bitbucket"],"steps":["設定 Jira 專案與任務工作流程。","在 Confluence 建立知識頁面並連結 Jira 任務。","使用 Bitbucket 儲存代碼並設定 Pull Request 流程。","整合 Slack 或 Email 通知，以確保資訊同步。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch2',
    'claude-ai',
    NOW(),
    NOW()
  ) ON CONFLICT (tool_name) DO UPDATE SET
    summary = EXCLUDED.summary,
    source_slug = EXCLUDED.source_slug,
    categories = EXCLUDED.categories,
    description_styles = EXCLUDED.description_styles,
    use_case_templates = EXCLUDED.use_case_templates,
    is_curated = true,
    curation_batch = 'v3.0-expansion-batch2',
    updated_at = NOW();

  -- Add zh-TW translation for Atlassian
  INSERT INTO tool_translations (
    id,
    tool_id,
    language_code,
    summary,
    description_styles,
    created_at
  ) VALUES (
    gen_random_uuid(),
    tool_id,
    'zh-TW',
    'Suite of collaboration and productivity software including Jira, Confluence, Trello, and Bitbucket.',
    '{"encyclopedia":"Atlassian 提供多款軟體，如 Jira、Confluence、Bitbucket，支援專案管理、文件協作與程式版本控制。","guide":"在軟體專案中，Jira 用於任務追蹤，Confluence 用於知識共享，而 Bitbucket 用於源碼管理。這些工具彼此整合，方便團隊協作。","strategy":"如果您的團隊需要一站式管理開發任務、知識庫和程式碼，可以選擇 Atlassian 的產品組合，並整合 Slack 或 CI/CD 工具。","inspiration":["使用 Jira Sprint 管理敏捷迭代並追蹤進度。","建立 Confluence 空間共享設計文件與決策記錄。","使用 Bitbucket Pipelines 執行自動部署流程。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 2. Jam.dev
  tool_id := gen_random_uuid();
  INSERT INTO tools (
    id,
    tool_name,
    summary,
    source_slug,
    categories,
    description_styles,
    use_case_templates,
    is_curated,
    curation_batch,
    generation_source,
    created_at,
    updated_at
  ) VALUES (
    tool_id,
    'Jam.dev',
    'Bug reporting tool for dev teams capturing console logs, network requests, and annotated screenshots.',
    'jam-dev',
    '{"purpose":["Application Oriented"],"functional_role":["Bug Reporting","Collaboration"],"application_field":["Software QA","Developer Tools"],"tech_layer":["Frontend Layer"],"data_flow_role":["Input","Processing"],"difficulty":"No-code","common_pairings":["GitHub","Jira","Slack"]}'::jsonb,
    '{"encyclopedia":"Jam.dev 是一個可擷取瀏覽器畫面、控制台 log 和網路請求的錯誤報告工具，幫助團隊即時了解問題。","guide":"使用 Jam.dev 插件，測試者可以在瀏覽器中點擊一下即可錄下錯誤狀態與上下文，並直接發送至指定的問題追蹤系統。","strategy":"若團隊常因無法重現錯誤而浪費時間，導入 Jam.dev 可在第一時間取得完整上下文，縮短 debug 時間。","inspiration":["在執行功能測試時，透過 Jam.dev 快速回報 bug 及錄影。","當客戶報錯時，使用 Jam.dev 收集瀏覽器環境資訊並傳送給開發團隊。","與 Jira 結合，自動建立帶有影片和 log 的 bug ticket。"]}'::jsonb,
    '[{"goal":"提升錯誤報告效率","method":"Jam.dev 擴充套件","tool_stack":["Jam.dev","Jira","GitHub"],"steps":["安裝 Jam.dev browser extension。","在發現 bug 時按下錄製，收集頁面、console log 和 network data。","提交 bug report 並附加影片與記錄。","由開發人員查閱 ticket 並修復錯誤。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch2',
    'claude-ai',
    NOW(),
    NOW()
  ) ON CONFLICT (tool_name) DO UPDATE SET
    summary = EXCLUDED.summary,
    source_slug = EXCLUDED.source_slug,
    categories = EXCLUDED.categories,
    description_styles = EXCLUDED.description_styles,
    use_case_templates = EXCLUDED.use_case_templates,
    is_curated = true,
    curation_batch = 'v3.0-expansion-batch2',
    updated_at = NOW();

  -- Add zh-TW translation for Jam.dev
  INSERT INTO tool_translations (
    id,
    tool_id,
    language_code,
    summary,
    description_styles,
    created_at
  ) VALUES (
    gen_random_uuid(),
    tool_id,
    'zh-TW',
    'Bug reporting tool for dev teams capturing console logs, network requests, and annotated screenshots.',
    '{"encyclopedia":"Jam.dev 是一個可擷取瀏覽器畫面、控制台 log 和網路請求的錯誤報告工具，幫助團隊即時了解問題。","guide":"使用 Jam.dev 插件，測試者可以在瀏覽器中點擊一下即可錄下錯誤狀態與上下文，並直接發送至指定的問題追蹤系統。","strategy":"若團隊常因無法重現錯誤而浪費時間，導入 Jam.dev 可在第一時間取得完整上下文，縮短 debug 時間。","inspiration":["在執行功能測試時，透過 Jam.dev 快速回報 bug 及錄影。","當客戶報錯時，使用 Jam.dev 收集瀏覽器環境資訊並傳送給開發團隊。","與 Jira 結合，自動建立帶有影片和 log 的 bug ticket。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 3. Temporal
  tool_id := gen_random_uuid();
  INSERT INTO tools (
    id,
    tool_name,
    summary,
    source_slug,
    categories,
    description_styles,
    use_case_templates,
    is_curated,
    curation_batch,
    generation_source,
    created_at,
    updated_at
  ) VALUES (
    tool_id,
    'Temporal',
    'Workflow as code platform to build and scale distributed applications with reliability.',
    'temporal',
    '{"purpose":["System Oriented"],"functional_role":["Workflow Orchestration","Distributed Systems"],"application_field":["Microservices","Backend"],"tech_layer":["Processing Layer"],"data_flow_role":["Processing","Orchestration"],"difficulty":"Code","common_pairings":["Go","Java","Kubernetes"]}'::jsonb,
    '{"encyclopedia":"Temporal 是一個可程式化的工作流程平台，用於撰寫可靠且可擴展的分散式應用，支援長時間運行的工作與錯誤自動補償。","guide":"Temporal 將工作流程定義寫成 code，提供持久化與重試機制，適合處理複雜且要求高穩定性的任務，如訂單流程或支付服務。","strategy":"如須在微服務架構中處理需要多次重試或狀態管理的流程，可採用 Temporal 取代傳統 message queue + cron 的做法，確保一致性。","inspiration":["開發複雜的電商訂單流程，管理跨多服務的確認、付款與出貨。","用於支援長時間執行的視頻轉檔或資料處理任務，確保每一小步成功。","在微服務中實現 Saga 模式，處理事務補償。"]}'::jsonb,
    '[{"goal":"管理複雜分散式流程","method":"Temporal workflow as code","tool_stack":["Temporal","Go","Kubernetes"],"steps":["安裝 Temporal Server 並配置儲存 backend。","在應用程式中導入 Temporal client library。","撰寫 workflow 和 activities，定義業務流程。","部署並監控 workflow 執行狀態。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch2',
    'claude-ai',
    NOW(),
    NOW()
  ) ON CONFLICT (tool_name) DO UPDATE SET
    summary = EXCLUDED.summary,
    source_slug = EXCLUDED.source_slug,
    categories = EXCLUDED.categories,
    description_styles = EXCLUDED.description_styles,
    use_case_templates = EXCLUDED.use_case_templates,
    is_curated = true,
    curation_batch = 'v3.0-expansion-batch2',
    updated_at = NOW();

  -- Add zh-TW translation for Temporal
  INSERT INTO tool_translations (
    id,
    tool_id,
    language_code,
    summary,
    description_styles,
    created_at
  ) VALUES (
    gen_random_uuid(),
    tool_id,
    'zh-TW',
    'Workflow as code platform to build and scale distributed applications with reliability.',
    '{"encyclopedia":"Temporal 是一個可程式化的工作流程平台，用於撰寫可靠且可擴展的分散式應用，支援長時間運行的工作與錯誤自動補償。","guide":"Temporal 將工作流程定義寫成 code，提供持久化與重試機制，適合處理複雜且要求高穩定性的任務，如訂單流程或支付服務。","strategy":"如須在微服務架構中處理需要多次重試或狀態管理的流程，可採用 Temporal 取代傳統 message queue + cron 的做法，確保一致性。","inspiration":["開發複雜的電商訂單流程，管理跨多服務的確認、付款與出貨。","用於支援長時間執行的視頻轉檔或資料處理任務，確保每一小步成功。","在微服務中實現 Saga 模式，處理事務補償。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 4. Typedream
  tool_id := gen_random_uuid();
  INSERT INTO tools (
    id,
    tool_name,
    summary,
    source_slug,
    categories,
    description_styles,
    use_case_templates,
    is_curated,
    curation_batch,
    generation_source,
    created_at,
    updated_at
  ) VALUES (
    tool_id,
    'Typedream',
    'No-code site builder that uses a Notion-like interface to create responsive web pages.',
    'typedream',
    '{"purpose":["Application Oriented","Learning Oriented"],"functional_role":["Site Building","CMS"],"application_field":["Web Development","Content Management"],"tech_layer":["Frontend Layer"],"data_flow_role":["Output"],"difficulty":"No-code","common_pairings":["Notion","Airtable","Zapier"]}'::jsonb,
    '{"encyclopedia":"Typedream 是一個無程式碼網站建構工具，其介面類似 Notion，讓使用者輕鬆拖拉內容並快速生成響應式網站。","guide":"透過 Typedream，可將文字、圖片和區塊排列在頁面中。它支援自訂域名、表單與會員系統，可連結數據來源。","strategy":"如果你需要快速建立個人或小型企業的品牌頁面，不想使用傳統 CMS，可選擇 Typedream 以最短時間上線。","inspiration":["創建個人作品集網站，將 Notion 中的內容同步到 Typedream。","為 podcast 或部落格搭建官方網站，整合留言表單與訂閱系統。","與 Airtable 整合，動態展示產品清單。"]}'::jsonb,
    '[{"goal":"建立品牌網站","method":"拖拉式建站","tool_stack":["Typedream","Notion","Zapier"],"steps":["在 Typedream 開啟新的專案並設計版型。","將內容從 Notion 複製到頁面區塊或與資料庫同步。","設置表單收集訪客資訊，透過 Zapier 自動傳送電子郵件。","設定自訂網域並發布網站。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch2',
    'claude-ai',
    NOW(),
    NOW()
  ) ON CONFLICT (tool_name) DO UPDATE SET
    summary = EXCLUDED.summary,
    source_slug = EXCLUDED.source_slug,
    categories = EXCLUDED.categories,
    description_styles = EXCLUDED.description_styles,
    use_case_templates = EXCLUDED.use_case_templates,
    is_curated = true,
    curation_batch = 'v3.0-expansion-batch2',
    updated_at = NOW();

  -- Add zh-TW translation for Typedream
  INSERT INTO tool_translations (
    id,
    tool_id,
    language_code,
    summary,
    description_styles,
    created_at
  ) VALUES (
    gen_random_uuid(),
    tool_id,
    'zh-TW',
    'No-code site builder that uses a Notion-like interface to create responsive web pages.',
    '{"encyclopedia":"Typedream 是一個無程式碼網站建構工具，其介面類似 Notion，讓使用者輕鬆拖拉內容並快速生成響應式網站。","guide":"透過 Typedream，可將文字、圖片和區塊排列在頁面中。它支援自訂域名、表單與會員系統，可連結數據來源。","strategy":"如果你需要快速建立個人或小型企業的品牌頁面，不想使用傳統 CMS，可選擇 Typedream 以最短時間上線。","inspiration":["創建個人作品集網站，將 Notion 中的內容同步到 Typedream。","為 podcast 或部落格搭建官方網站，整合留言表單與訂閱系統。","與 Airtable 整合，動態展示產品清單。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 5. Triform
  tool_id := gen_random_uuid();
  INSERT INTO tools (
    id,
    tool_name,
    summary,
    source_slug,
    categories,
    description_styles,
    use_case_templates,
    is_curated,
    curation_batch,
    generation_source,
    created_at,
    updated_at
  ) VALUES (
    tool_id,
    'Triform',
    'Data transformation and validation tool for converting and cleaning datasets in various formats.',
    'triform',
    '{"purpose":["Application Oriented"],"functional_role":["Data Transformation","Data Quality"],"application_field":["ETL","Data Engineering"],"tech_layer":["Processing Layer"],"data_flow_role":["Processing"],"difficulty":"Low-code","common_pairings":["Python","AWS Glue","Data warehouses"]}'::jsonb,
    '{"encyclopedia":"Triform 是一個資料轉換與驗證工具，用於將各種資料格式轉換為一致的結構，並清理資料。","guide":"Triform 讓使用者以 GUI 或腳本形式定義資料轉換邏輯，包括欄位映射、型別轉換和規則驗證。","strategy":"若需要將來自不同系統的資料整合到數據倉庫，並確保資料一致與品質，可先用 Triform 進行 ETL 前處理。","inspiration":["將 CSV 檔案轉換為 JSON 並進行欄位標準化。","設定資料驗證規則，自動檢查缺失值並填補。","結合 ETL 工具，對進入數據湖的資料進行清洗。"]}'::jsonb,
    '[{"goal":"清理並轉換資料集","method":"使用 Triform GUI","tool_stack":["Triform","AWS Glue","S3"],"steps":["載入原始資料集並識別欄位。","定義轉換規則，例如欄位合併、欄位重命名。","執行驗證步驟，修正格式錯誤。","將處理後資料輸出到下一管道。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch2',
    'claude-ai',
    NOW(),
    NOW()
  ) ON CONFLICT (tool_name) DO UPDATE SET
    summary = EXCLUDED.summary,
    source_slug = EXCLUDED.source_slug,
    categories = EXCLUDED.categories,
    description_styles = EXCLUDED.description_styles,
    use_case_templates = EXCLUDED.use_case_templates,
    is_curated = true,
    curation_batch = 'v3.0-expansion-batch2',
    updated_at = NOW();

  -- Add zh-TW translation for Triform
  INSERT INTO tool_translations (
    id,
    tool_id,
    language_code,
    summary,
    description_styles,
    created_at
  ) VALUES (
    gen_random_uuid(),
    tool_id,
    'zh-TW',
    'Data transformation and validation tool for converting and cleaning datasets in various formats.',
    '{"encyclopedia":"Triform 是一個資料轉換與驗證工具，用於將各種資料格式轉換為一致的結構，並清理資料。","guide":"Triform 讓使用者以 GUI 或腳本形式定義資料轉換邏輯，包括欄位映射、型別轉換和規則驗證。","strategy":"若需要將來自不同系統的資料整合到數據倉庫，並確保資料一致與品質，可先用 Triform 進行 ETL 前處理。","inspiration":["將 CSV 檔案轉換為 JSON 並進行欄位標準化。","設定資料驗證規則，自動檢查缺失值並填補。","結合 ETL 工具，對進入數據湖的資料進行清洗。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 6. Kintone
  tool_id := gen_random_uuid();
  INSERT INTO tools (
    id,
    tool_name,
    summary,
    source_slug,
    categories,
    description_styles,
    use_case_templates,
    is_curated,
    curation_batch,
    generation_source,
    created_at,
    updated_at
  ) VALUES (
    tool_id,
    'Kintone',
    'Customizable workspace platform to build apps and manage data without coding.',
    'kintone',
    '{"purpose":["Application Oriented"],"functional_role":["Database","App Builder"],"application_field":["Business Operations","Project Management"],"tech_layer":["Data Layer","Frontend Layer"],"data_flow_role":["Input","Storage","Output"],"difficulty":"No-code","common_pairings":["Zapier","n8n","Slack"]}'::jsonb,
    '{"encyclopedia":"Kintone 是一個無程式碼應用平台，允許使用者建立自訂資料表和工作流程，用於內部管理和協作。","guide":"透過 Kintone，可以快速建立客製化 CRUD 應用，如採購申請、專案追蹤，並透過視覺化界面管理資料。","strategy":"適合中小企業或團隊快速開發內部工具，例如申請流程與資料管理，無需程式技能。","inspiration":["建立差旅申請系統，由員工提交申請並由主管批核。","以 Kintone 管理專案任務，並透過 Slack 通知更新。","整合自動化工具，將 Kintone 資料定期導出分析。"]}'::jsonb,
    '[{"goal":"建立內部申請管理系統","method":"使用 Kintone 表格","tool_stack":["Kintone","Slack","Zapier"],"steps":["建立新應用並定義資料欄位和表單。","設定工作流程與權限。","與 Slack 整合，使得審核通知即時。","用 Zapier 將結果同步至其他系統。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch2',
    'claude-ai',
    NOW(),
    NOW()
  ) ON CONFLICT (tool_name) DO UPDATE SET
    summary = EXCLUDED.summary,
    source_slug = EXCLUDED.source_slug,
    categories = EXCLUDED.categories,
    description_styles = EXCLUDED.description_styles,
    use_case_templates = EXCLUDED.use_case_templates,
    is_curated = true,
    curation_batch = 'v3.0-expansion-batch2',
    updated_at = NOW();

  -- Add zh-TW translation for Kintone
  INSERT INTO tool_translations (
    id,
    tool_id,
    language_code,
    summary,
    description_styles,
    created_at
  ) VALUES (
    gen_random_uuid(),
    tool_id,
    'zh-TW',
    'Customizable workspace platform to build apps and manage data without coding.',
    '{"encyclopedia":"Kintone 是一個無程式碼應用平台，允許使用者建立自訂資料表和工作流程，用於內部管理和協作。","guide":"透過 Kintone，可以快速建立客製化 CRUD 應用，如採購申請、專案追蹤，並透過視覺化界面管理資料。","strategy":"適合中小企業或團隊快速開發內部工具，例如申請流程與資料管理，無需程式技能。","inspiration":["建立差旅申請系統，由員工提交申請並由主管批核。","以 Kintone 管理專案任務，並透過 Slack 通知更新。","整合自動化工具，將 Kintone 資料定期導出分析。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 7. Kubernetes
  tool_id := gen_random_uuid();
  INSERT INTO tools (
    id,
    tool_name,
    summary,
    source_slug,
    categories,
    description_styles,
    use_case_templates,
    is_curated,
    curation_batch,
    generation_source,
    created_at,
    updated_at
  ) VALUES (
    tool_id,
    'Kubernetes',
    'Open-source container orchestration platform for deploying and managing containerized applications.',
    'kubernetes',
    '{"purpose":["System Oriented"],"functional_role":["Container Orchestration","Infrastructure"],"application_field":["DevOps","Cloud Native"],"tech_layer":["Infrastructure Layer"],"data_flow_role":["Processing"],"difficulty":"Code","common_pairings":["Docker","Helm","Prometheus"]}'::jsonb,
    '{"encyclopedia":"Kubernetes 是一個開源的容器協調平台，用於自動化部署、擴充和管理容器化應用程式。","guide":"在雲原生架構中，Kubernetes 管理 Pod、Service 和 Deployment，使得應用在各種環境中穩定運行。","strategy":"若需要高度可擴展及自癒的服務，可以採用 Kubernetes。透過 Helm chart、GitOps 可以簡化部署。","inspiration":["部署微服務架構，管理多個容器並自動水平擴展。","結合 CI/CD pipeline，透過 Kubernetes 滾動更新應用。","使用 Kubernetes 管理機器學習模型服務的部署與伸縮。"]}'::jsonb,
    '[{"goal":"管理容器化應用部署","method":"使用 Kubernetes cluster","tool_stack":["Kubernetes","Docker","Helm"],"steps":["在雲端或本地環境設置 Kubernetes cluster。","將應用容器化並撰寫 deployment 配置。","使用 kubectl 部署，監控 Pod 狀態。","利用 autoscaler 動態伸縮資源。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch2',
    'claude-ai',
    NOW(),
    NOW()
  ) ON CONFLICT (tool_name) DO UPDATE SET
    summary = EXCLUDED.summary,
    source_slug = EXCLUDED.source_slug,
    categories = EXCLUDED.categories,
    description_styles = EXCLUDED.description_styles,
    use_case_templates = EXCLUDED.use_case_templates,
    is_curated = true,
    curation_batch = 'v3.0-expansion-batch2',
    updated_at = NOW();

  -- Add zh-TW translation for Kubernetes
  INSERT INTO tool_translations (
    id,
    tool_id,
    language_code,
    summary,
    description_styles,
    created_at
  ) VALUES (
    gen_random_uuid(),
    tool_id,
    'zh-TW',
    'Open-source container orchestration platform for deploying and managing containerized applications.',
    '{"encyclopedia":"Kubernetes 是一個開源的容器協調平台，用於自動化部署、擴充和管理容器化應用程式。","guide":"在雲原生架構中，Kubernetes 管理 Pod、Service 和 Deployment，使得應用在各種環境中穩定運行。","strategy":"若需要高度可擴展及自癒的服務，可以採用 Kubernetes。透過 Helm chart、GitOps 可以簡化部署。","inspiration":["部署微服務架構，管理多個容器並自動水平擴展。","結合 CI/CD pipeline，透過 Kubernetes 滾動更新應用。","使用 Kubernetes 管理機器學習模型服務的部署與伸縮。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 8. Carrd
  tool_id := gen_random_uuid();
  INSERT INTO tools (
    id,
    tool_name,
    summary,
    source_slug,
    categories,
    description_styles,
    use_case_templates,
    is_curated,
    curation_batch,
    generation_source,
    created_at,
    updated_at
  ) VALUES (
    tool_id,
    'Carrd',
    'Simple one-page site builder for personal profiles, landing pages, and portfolios.',
    'carrd',
    '{"purpose":["Application Oriented"],"functional_role":["Site Building","Landing Pages"],"application_field":["Personal Branding","Marketing"],"tech_layer":["Frontend Layer"],"data_flow_role":["Output"],"difficulty":"No-code","common_pairings":["Mailchimp","Google Analytics","Typeform"]}'::jsonb,
    '{"encyclopedia":"Carrd 是一個簡單的單頁網站建設平台，用戶可以快速製作個人簡介、落地頁面或作品集。","guide":"透過 Carrd 的拖放介面與模板，只需幾分鐘即可建立簡單且美觀的頁面，支援自訂域名與表單。","strategy":"如果想建立快速的宣傳頁面或試驗概念，Carrd 提供低門檻且成本低廉的選擇。","inspiration":["創建個人簡歷或求職作品集頁面，包含聯絡表單。","建立活動宣傳頁，與外部報名系統整合。","為創業項目設立簡單落地頁並收集訂閱。"]}'::jsonb,
    '[{"goal":"快速建立落地頁","method":"使用 Carrd 模板","tool_stack":["Carrd","Typeform","Mailchimp"],"steps":["選擇適合主題的 Carrd template。","修改文字、圖片與排版，符合品牌風格。","嵌入報名或訂閱表單。","購買自訂域名並發布。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch2',
    'claude-ai',
    NOW(),
    NOW()
  ) ON CONFLICT (tool_name) DO UPDATE SET
    summary = EXCLUDED.summary,
    source_slug = EXCLUDED.source_slug,
    categories = EXCLUDED.categories,
    description_styles = EXCLUDED.description_styles,
    use_case_templates = EXCLUDED.use_case_templates,
    is_curated = true,
    curation_batch = 'v3.0-expansion-batch2',
    updated_at = NOW();

  -- Add zh-TW translation for Carrd
  INSERT INTO tool_translations (
    id,
    tool_id,
    language_code,
    summary,
    description_styles,
    created_at
  ) VALUES (
    gen_random_uuid(),
    tool_id,
    'zh-TW',
    'Simple one-page site builder for personal profiles, landing pages, and portfolios.',
    '{"encyclopedia":"Carrd 是一個簡單的單頁網站建設平台，用戶可以快速製作個人簡介、落地頁面或作品集。","guide":"透過 Carrd 的拖放介面與模板，只需幾分鐘即可建立簡單且美觀的頁面，支援自訂域名與表單。","strategy":"如果想建立快速的宣傳頁面或試驗概念，Carrd 提供低門檻且成本低廉的選擇。","inspiration":["創建個人簡歷或求職作品集頁面，包含聯絡表單。","建立活動宣傳頁，與外部報名系統整合。","為創業項目設立簡單落地頁並收集訂閱。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 9. Mintlify
  tool_id := gen_random_uuid();
  INSERT INTO tools (
    id,
    tool_name,
    summary,
    source_slug,
    categories,
    description_styles,
    use_case_templates,
    is_curated,
    curation_batch,
    generation_source,
    created_at,
    updated_at
  ) VALUES (
    tool_id,
    'Mintlify',
    'Documentation platform that turns code into beautifully formatted docs with AI-assisted content generation.',
    'mintlify',
    '{"purpose":["Learning Oriented","Application Oriented"],"functional_role":["Documentation","Developer Tools"],"application_field":["Developer Experience","API Docs"],"tech_layer":["Frontend Layer"],"data_flow_role":["Output"],"difficulty":"Low-code","common_pairings":["GitHub","Markdown","Notion"]}'::jsonb,
    '{"encyclopedia":"Mintlify 是一個文件生成平台，可自動從程式碼中生成美觀的 API 與技術文檔，並提供 AI 協助改寫。","guide":"透過匯入程式庫或專案，Mintlify 自動解析函式和類別，生成互動式說明書。可自訂主題與支援部屬。","strategy":"若您想提高開源專案或 SaaS 平台的文件品質，又不想手動編寫，可使用 Mintlify 節省時間並提升讀者體驗。","inspiration":["為 JavaScript 庫自動生成 API 文檔並托管於自己的網站。","結合 ChatGPT 功能，將摘要翻譯為多語版本。","同步文件變更至 GitHub，每次程式更新即自動更新文檔。"]}'::jsonb,
    '[{"goal":"生成高品質程式碼文件","method":"使用 Mintlify 自動化文件生成","tool_stack":["Mintlify","GitHub","ChatGPT"],"steps":["將代碼庫導入 Mintlify 平台。","自動解析函式與類別並生成文件。","使用 AI 工具改善描述與範例。","發佈文件並提供搜尋功能。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch2',
    'claude-ai',
    NOW(),
    NOW()
  ) ON CONFLICT (tool_name) DO UPDATE SET
    summary = EXCLUDED.summary,
    source_slug = EXCLUDED.source_slug,
    categories = EXCLUDED.categories,
    description_styles = EXCLUDED.description_styles,
    use_case_templates = EXCLUDED.use_case_templates,
    is_curated = true,
    curation_batch = 'v3.0-expansion-batch2',
    updated_at = NOW();

  -- Add zh-TW translation for Mintlify
  INSERT INTO tool_translations (
    id,
    tool_id,
    language_code,
    summary,
    description_styles,
    created_at
  ) VALUES (
    gen_random_uuid(),
    tool_id,
    'zh-TW',
    'Documentation platform that turns code into beautifully formatted docs with AI-assisted content generation.',
    '{"encyclopedia":"Mintlify 是一個文件生成平台，可自動從程式碼中生成美觀的 API 與技術文檔，並提供 AI 協助改寫。","guide":"透過匯入程式庫或專案，Mintlify 自動解析函式和類別，生成互動式說明書。可自訂主題與支援部屬。","strategy":"若您想提高開源專案或 SaaS 平台的文件品質，又不想手動編寫，可使用 Mintlify 節省時間並提升讀者體驗。","inspiration":["為 JavaScript 庫自動生成 API 文檔並托管於自己的網站。","結合 ChatGPT 功能，將摘要翻譯為多語版本。","同步文件變更至 GitHub，每次程式更新即自動更新文檔。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 10. Zenler
  tool_id := gen_random_uuid();
  INSERT INTO tools (
    id,
    tool_name,
    summary,
    source_slug,
    categories,
    description_styles,
    use_case_templates,
    is_curated,
    curation_batch,
    generation_source,
    created_at,
    updated_at
  ) VALUES (
    tool_id,
    'Zenler',
    'All-in-one platform for course creation, marketing, and hosting for educators and entrepreneurs.',
    'zenler',
    '{"purpose":["Application Oriented"],"functional_role":["Course Creation","Marketing","E-commerce"],"application_field":["Education","Online Business"],"tech_layer":["Frontend Layer","Integration Layer"],"data_flow_role":["Output","Storage"],"difficulty":"No-code","common_pairings":["Stripe","Mailchimp","Zapier"]}'::jsonb,
    '{"encyclopedia":"Zenler 提供建立線上課程的全方位平台，結合課程製作、行銷、收款與社群功能。","guide":"教師與創業者可利用 Zenler 上傳影片、建立課程模組並設定銷售方案；並透過整合 Email 行銷和付款功能吸引學生。","strategy":"若您想快速推出線上課程且需要專業行銷與付費管理功能，Zenler 提供從內容建立到銷售的完整解決方案。","inspiration":["建立線上學院，提供預錄與直播課程並收取費用。","利用 Zenler 自動電子郵件、漏斗行銷吸引新學生。","結合社群社區功能，提升學生參與度。"]}'::jsonb,
    '[{"goal":"建立線上課程平台","method":"使用 Zenler 平台","tool_stack":["Zenler","Stripe","Mailchimp"],"steps":["註冊 Zenler 並建立課程區域。","上傳課程內容、設定章節與測驗。","設置付款方案並整合 Stripe。","利用電郵行銷功能招募學生並追蹤進度。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch2',
    'claude-ai',
    NOW(),
    NOW()
  ) ON CONFLICT (tool_name) DO UPDATE SET
    summary = EXCLUDED.summary,
    source_slug = EXCLUDED.source_slug,
    categories = EXCLUDED.categories,
    description_styles = EXCLUDED.description_styles,
    use_case_templates = EXCLUDED.use_case_templates,
    is_curated = true,
    curation_batch = 'v3.0-expansion-batch2',
    updated_at = NOW();

  -- Add zh-TW translation for Zenler
  INSERT INTO tool_translations (
    id,
    tool_id,
    language_code,
    summary,
    description_styles,
    created_at
  ) VALUES (
    gen_random_uuid(),
    tool_id,
    'zh-TW',
    'All-in-one platform for course creation, marketing, and hosting for educators and entrepreneurs.',
    '{"encyclopedia":"Zenler 提供建立線上課程的全方位平台，結合課程製作、行銷、收款與社群功能。","guide":"教師與創業者可利用 Zenler 上傳影片、建立課程模組並設定銷售方案；並透過整合 Email 行銷和付款功能吸引學生。","strategy":"若您想快速推出線上課程且需要專業行銷與付費管理功能，Zenler 提供從內容建立到銷售的完整解決方案。","inspiration":["建立線上學院，提供預錄與直播課程並收取費用。","利用 Zenler 自動電子郵件、漏斗行銷吸引新學生。","結合社群社區功能，提升學生參與度。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

END $$;

-- Add comment
COMMENT ON TABLE tools IS 'Updated with tools from Phase 3 expansion - Batch 2';
