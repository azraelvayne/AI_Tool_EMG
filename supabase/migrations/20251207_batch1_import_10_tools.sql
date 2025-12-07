/*
  # Import Tools - Batch 1 of 3 (Phase 3 Expansion)

  ## Overview
  This migration imports 10 tools as part of batch 1.
  Tools in this batch: Airflow, fal, Prefect, Egnyte, Composio, BrightData, ScrapingBee, Phantombuster, Thunderbit, Miro

  ## Data Source
  Generated from additional_tools_dataset.json

  ## Import Strategy
  - Each tool gets a unique UUID
  - Categories are properly mapped to match existing schema
  - Translations are added for zh-TW locale
  - Common pairings are stored in categories
  - Curation batch: v3.0-expansion-batch1

  ## Date
  Generated: 2025-12-07T15:22:02.593Z
*/

-- Import tools (Batch 1)
DO $$
DECLARE
  tool_id UUID;
BEGIN

  -- 1. Airflow
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
    'Airflow',
    'Open-source platform to programmatically author, schedule, and monitor workflows.',
    'airflow',
    '{"purpose":["System Oriented","Application Oriented"],"functional_role":["Automation","Workflow Orchestration"],"application_field":["Data Engineering","ETL","Orchestration"],"tech_layer":["Processing Layer"],"data_flow_role":["Processing","Orchestration"],"difficulty":"Low-code","common_pairings":["Docker","Kubernetes","AWS Lambda"]}'::jsonb,
    '{"encyclopedia":"Airflow 是一個用 Python 編寫的開源平台，用於調度和監控工作流，主要應用於資料工程和 ETL。","guide":"在資料工作流程中，Airflow 扮演了 Orchestrator 的角色，適合協調多個資料處理任務並設定依賴關係。透過 DAG 定義流程，執行排程。","strategy":"當需要定期整理資料並在任務間建立依賴時，例如每日 ETL 或模型訓練 pipeline，可以使用 Airflow 作為流程引擎。搭配 Docker 或 Kubernetes 部署，提高彈性。","inspiration":["建立每日資料清理和轉換流程，將資料從多源匯入，轉換後送入數據倉庫。","整合預測模型訓練、評估和部署，形成自動化機器學習 pipeline。","作為報告生成流程控制台，定期拉取資料、生成報表並寄送給管理者。"]}'::jsonb,
    '[{"goal":"自動化資料管道","method":"透過 DAG 定義並排程","tool_stack":["Airflow","PostgreSQL","Python"],"steps":["建立 DAG 檔案定義資料管道的任務與依賴。","撰寫每個 task 所需的 Python Operator 或外部指令。","使用 Airflow Scheduler 設定排程頻率。","監控 DAG 執行狀態並處理失敗重試。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch1',
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
    curation_batch = 'v3.0-expansion-batch1',
    updated_at = NOW();

  -- Add zh-TW translation for Airflow
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
    'Open-source platform to programmatically author, schedule, and monitor workflows.',
    '{"encyclopedia":"Airflow 是一個用 Python 編寫的開源平台，用於調度和監控工作流，主要應用於資料工程和 ETL。","guide":"在資料工作流程中，Airflow 扮演了 Orchestrator 的角色，適合協調多個資料處理任務並設定依賴關係。透過 DAG 定義流程，執行排程。","strategy":"當需要定期整理資料並在任務間建立依賴時，例如每日 ETL 或模型訓練 pipeline，可以使用 Airflow 作為流程引擎。搭配 Docker 或 Kubernetes 部署，提高彈性。","inspiration":["建立每日資料清理和轉換流程，將資料從多源匯入，轉換後送入數據倉庫。","整合預測模型訓練、評估和部署，形成自動化機器學習 pipeline。","作為報告生成流程控制台，定期拉取資料、生成報表並寄送給管理者。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 2. fal
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
    'fal',
    'SQL-first transformation tool for data pipelines, integrates with dbt and orchestration engines.',
    'fal',
    '{"purpose":["Application Oriented"],"functional_role":["Data Transformation","Analytics"],"application_field":["ETL","Data Engineering"],"tech_layer":["Processing Layer"],"data_flow_role":["Processing"],"difficulty":"Low-code","common_pairings":["dbt","Snowflake","Airflow"]}'::jsonb,
    '{"encyclopedia":"fal 是一款聚焦於 SQL 轉換的資料管道工具，可與 dbt 與 Orchestration 平台整合，提供豐富的轉換腳本管理功能。","guide":"fal 主要在資料轉換流程中作為轉換執行者，允許直接撰寫 SQL 腳本管理資料轉換邏輯。可與 dbt 一起使用，提高程式化管理。","strategy":"如果您的團隊已使用 dbt 管理資料模型，而想統一管理 SQL 轉換並與 Airflow 等排程系統接軌，可導入 fal 作為橋樑，維持資料轉換一致性。","inspiration":["利用 fal 將資料倉庫中需要清理的資料寫成 SQL，並與 dbt 同步管理。","結合 Airflow 排程每日跑 fal 的 SQL 轉換，保持表格更新。","在分析流程中快速試驗新的 SQL 轉換腳本，再推送到生產環境。"]}'::jsonb,
    '[{"goal":"管理 SQL 資料模型轉換","method":"使用 fal + dbt","tool_stack":["fal","dbt","Snowflake"],"steps":["將資料模型轉換腳本寫入 dbt 專案。","使用 fal 連線到資料庫，執行轉換 SQL。","透過 Orchestration 平台（如 Airflow）定期排程轉換。","監控轉換結果並回滾失敗。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch1',
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
    curation_batch = 'v3.0-expansion-batch1',
    updated_at = NOW();

  -- Add zh-TW translation for fal
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
    'SQL-first transformation tool for data pipelines, integrates with dbt and orchestration engines.',
    '{"encyclopedia":"fal 是一款聚焦於 SQL 轉換的資料管道工具，可與 dbt 與 Orchestration 平台整合，提供豐富的轉換腳本管理功能。","guide":"fal 主要在資料轉換流程中作為轉換執行者，允許直接撰寫 SQL 腳本管理資料轉換邏輯。可與 dbt 一起使用，提高程式化管理。","strategy":"如果您的團隊已使用 dbt 管理資料模型，而想統一管理 SQL 轉換並與 Airflow 等排程系統接軌，可導入 fal 作為橋樑，維持資料轉換一致性。","inspiration":["利用 fal 將資料倉庫中需要清理的資料寫成 SQL，並與 dbt 同步管理。","結合 Airflow 排程每日跑 fal 的 SQL 轉換，保持表格更新。","在分析流程中快速試驗新的 SQL 轉換腳本，再推送到生產環境。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 3. Prefect
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
    'Prefect',
    'Dataflow automation and orchestration platform to build, observe, and manage data pipelines.',
    'prefect',
    '{"purpose":["System Oriented","Application Oriented"],"functional_role":["Automation","Workflow Orchestration"],"application_field":["Data Engineering","ETL","Machine Learning"],"tech_layer":["Processing Layer"],"data_flow_role":["Processing","Orchestration"],"difficulty":"Low-code","common_pairings":["Python","AWS","S3"]}'::jsonb,
    '{"encyclopedia":"Prefect 是一個現代化的資料流程編排平台，支援編寫、監控及管理資料管道，並提供豐富的觀測功能。","guide":"在資料管道中，Prefect 提供了 Task 和 Flow 的抽象，簡化複雜流程的定義與重試策略設定。可在雲端運行或本地。","strategy":"當需要彈性管理資料管道且想避免 Airflow 的複雜性時，可導入 Prefect。它支援 Python function-based 定義流程，更易於測試與本地開發。","inspiration":["建立 ETL 流程，透過 Prefect 將 Python 任務串起，並在失敗時自動重試。","運用 Prefect 的 Orion 平台監控 pipeline，快速定位問題。","將機器學習訓練過程以 Prefect Flow 定義，使得模型訓練、評估與部署可視化。"]}'::jsonb,
    '[{"goal":"簡化資料管道管理並提高監控","method":"採用 Prefect Flow 定義 pipeline","tool_stack":["Prefect","Python","AWS"],"steps":["安裝 Prefect 並初始化專案。","定義任務 (Task) 與流程 (Flow)，利用 Python 函數串連。","設定條件邏輯與失敗重試策略。","使用 Prefect UI 監控流程執行並查看日誌。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch1',
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
    curation_batch = 'v3.0-expansion-batch1',
    updated_at = NOW();

  -- Add zh-TW translation for Prefect
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
    'Dataflow automation and orchestration platform to build, observe, and manage data pipelines.',
    '{"encyclopedia":"Prefect 是一個現代化的資料流程編排平台，支援編寫、監控及管理資料管道，並提供豐富的觀測功能。","guide":"在資料管道中，Prefect 提供了 Task 和 Flow 的抽象，簡化複雜流程的定義與重試策略設定。可在雲端運行或本地。","strategy":"當需要彈性管理資料管道且想避免 Airflow 的複雜性時，可導入 Prefect。它支援 Python function-based 定義流程，更易於測試與本地開發。","inspiration":["建立 ETL 流程，透過 Prefect 將 Python 任務串起，並在失敗時自動重試。","運用 Prefect 的 Orion 平台監控 pipeline，快速定位問題。","將機器學習訓練過程以 Prefect Flow 定義，使得模型訓練、評估與部署可視化。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 4. Egnyte
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
    'Egnyte',
    'Enterprise-grade file sharing and content governance platform for secure collaboration.',
    'egnyte',
    '{"purpose":["Application Oriented"],"functional_role":["File Storage","Collaboration"],"application_field":["Document Management","Enterprise"],"tech_layer":["Storage Layer"],"data_flow_role":["Storage","Output"],"difficulty":"No-code","common_pairings":["Slack","Microsoft Office","Salesforce"]}'::jsonb,
    '{"encyclopedia":"Egnyte 提供雲端檔案共享與內容管理服務，支援企業內外部協作，並具備合規與安全功能。","guide":"Egnyte 在工作流程中作為安全的檔案儲存與共享平台，可透過桌面同步客戶端或網頁使用，與各式協作工具整合。","strategy":"若企業需要集中管理檔案且符合合規要求，又不想自建檔案伺服器，可採用 Egnyte。它支援權限控制與活動追蹤，適合分散團隊協作。","inspiration":["建立中央檔案庫，供遠端團隊安全共享文件並管控版本。","整合 Egnyte 與 CRM 系統，自動保存合約與客戶資料。","利用 Egnyte API 建立自動報告匯出，將資料定期同步到第三方系統。"]}'::jsonb,
    '[{"goal":"提升企業檔案管理與安全","method":"部署 Egnyte 並整合協作工具","tool_stack":["Egnyte","Slack","Salesforce"],"steps":["建立 Egnyte 企業帳戶並設定權限策略。","安裝同步客戶端，將檔案夾同步到雲端。","與主要應用整合，例如 Salesforce、Office，保障文件即時更新。","設定活動監控以追蹤檔案下載與分享。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch1',
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
    curation_batch = 'v3.0-expansion-batch1',
    updated_at = NOW();

  -- Add zh-TW translation for Egnyte
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
    'Enterprise-grade file sharing and content governance platform for secure collaboration.',
    '{"encyclopedia":"Egnyte 提供雲端檔案共享與內容管理服務，支援企業內外部協作，並具備合規與安全功能。","guide":"Egnyte 在工作流程中作為安全的檔案儲存與共享平台，可透過桌面同步客戶端或網頁使用，與各式協作工具整合。","strategy":"若企業需要集中管理檔案且符合合規要求，又不想自建檔案伺服器，可採用 Egnyte。它支援權限控制與活動追蹤，適合分散團隊協作。","inspiration":["建立中央檔案庫，供遠端團隊安全共享文件並管控版本。","整合 Egnyte 與 CRM 系統，自動保存合約與客戶資料。","利用 Egnyte API 建立自動報告匯出，將資料定期同步到第三方系統。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 5. Composio
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
    'Composio',
    'Unified integration platform enabling applications to communicate via a single API or SDK.',
    'composio',
    '{"purpose":["System Oriented"],"functional_role":["Integration","API Gateway"],"application_field":["Developer Tools","Automation"],"tech_layer":["Integration Layer"],"data_flow_role":["Input","Output"],"difficulty":"Low-code","common_pairings":["Zapier","n8n","SaaS Platforms"]}'::jsonb,
    '{"encyclopedia":"Composio 是一個連接不同 SaaS 平台的整合平台，提供統一 API，簡化多系統協作與工作流程的開發。","guide":"透過 Composio，可以快速串接不同應用，使用單一 SDK 存取多個服務的資料與功能。適合開發者建立整合型應用。","strategy":"當你需要在同一應用程式中讀取並控制不同 SaaS 服務資料時，可利用 Composio 作為中介 API 層，減少重複整合開發工作。","inspiration":["在內部專案中串接 Slack、Google Drive 與 CRM 系統，並透過 Composio 直接管理檔案與訊息。","結合自動化平台（如 n8n），利用 Composio 觸發多個服務的任務。","打造統一控制台，可集中查看各服務資訊並進行批次操作。"]}'::jsonb,
    '[{"goal":"快速整合多個 SaaS 服務","method":"採用 Composio API","tool_stack":["Composio","n8n","Google Drive","Slack"],"steps":["在 Composio 上註冊並取得統一 API 金鑰。","使用 API 調用整合 Slack、Drive 等服務功能。","在應用程式或自動化流程中利用 Composio 處理檔案與訊息。","監控統一 API 呼叫狀況並調整權限設定。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch1',
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
    curation_batch = 'v3.0-expansion-batch1',
    updated_at = NOW();

  -- Add zh-TW translation for Composio
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
    'Unified integration platform enabling applications to communicate via a single API or SDK.',
    '{"encyclopedia":"Composio 是一個連接不同 SaaS 平台的整合平台，提供統一 API，簡化多系統協作與工作流程的開發。","guide":"透過 Composio，可以快速串接不同應用，使用單一 SDK 存取多個服務的資料與功能。適合開發者建立整合型應用。","strategy":"當你需要在同一應用程式中讀取並控制不同 SaaS 服務資料時，可利用 Composio 作為中介 API 層，減少重複整合開發工作。","inspiration":["在內部專案中串接 Slack、Google Drive 與 CRM 系統，並透過 Composio 直接管理檔案與訊息。","結合自動化平台（如 n8n），利用 Composio 觸發多個服務的任務。","打造統一控制台，可集中查看各服務資訊並進行批次操作。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 6. BrightData
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
    'BrightData',
    'Web data collection platform providing proxy networks and scraping tools for large-scale crawling.',
    'brightdata',
    '{"purpose":["Application Oriented"],"functional_role":["Data Collection","Scraping"],"application_field":["Market Research","Competitive Intelligence"],"tech_layer":["Processing Layer"],"data_flow_role":["Input"],"difficulty":"Low-code","common_pairings":["Python","ScrapingBee","Proxy Server"]}'::jsonb,
    '{"encyclopedia":"BrightData (原名 Luminati) 提供全球性的代理網路和資料收集服務，適合進行大規模網路資料抓取。","guide":"使用 BrightData 可以取得住宅 IP 代理並進行高效資料抓取，也提供 API 和自動化工具。必須注意合法使用並遵守網站政策。","strategy":"當需要收集市場資訊、大型電商價格或其他公開資料時，可以利用 BrightData 的代理網路避免封鎖，並透過自動化程式整理資料。","inspiration":["監測多國電子商務網站價格，更新商業分析儀表。","結合自製爬蟲程式，使用 BrightData 的住宅代理提升抓取成功率。","建立競品監測平台，每日收集公開資訊並生成報表。"]}'::jsonb,
    '[{"goal":"大量收集公開網頁資料","method":"使用 BrightData 住宅代理","tool_stack":["BrightData","Python","PostgreSQL"],"steps":["在 BrightData 平台申請住宅代理套餐。","撰寫爬蟲程式，使用代理進行資料抓取。","將抓取的資料存入資料庫並進行清洗。","以分析工具或視覺化平台呈現資料。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch1',
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
    curation_batch = 'v3.0-expansion-batch1',
    updated_at = NOW();

  -- Add zh-TW translation for BrightData
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
    'Web data collection platform providing proxy networks and scraping tools for large-scale crawling.',
    '{"encyclopedia":"BrightData (原名 Luminati) 提供全球性的代理網路和資料收集服務，適合進行大規模網路資料抓取。","guide":"使用 BrightData 可以取得住宅 IP 代理並進行高效資料抓取，也提供 API 和自動化工具。必須注意合法使用並遵守網站政策。","strategy":"當需要收集市場資訊、大型電商價格或其他公開資料時，可以利用 BrightData 的代理網路避免封鎖，並透過自動化程式整理資料。","inspiration":["監測多國電子商務網站價格，更新商業分析儀表。","結合自製爬蟲程式，使用 BrightData 的住宅代理提升抓取成功率。","建立競品監測平台，每日收集公開資訊並生成報表。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 7. ScrapingBee
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
    'ScrapingBee',
    'Headless browser scraping API to extract data from websites with support for rendering JavaScript.',
    'scrapingbee',
    '{"purpose":["Application Oriented"],"functional_role":["Data Collection","Scraping"],"application_field":["Market Research","Lead Generation"],"tech_layer":["Processing Layer"],"data_flow_role":["Input"],"difficulty":"Low-code","common_pairings":["BrightData","Pandas","n8n"]}'::jsonb,
    '{"encyclopedia":"ScrapingBee 提供簡單的 API，可執行無頭瀏覽器抓取網頁資料，支援渲染 JavaScript。","guide":"透過 ScrapingBee API，只需傳入目標網址，就能取得解析後的 HTML 或 JSON，適合沒有複雜爬蟲框架的使用者。","strategy":"若想快速抓取需要 JavaScript 渲染才能取得的資料，可以使用 ScrapingBee，結合代理服務或自動化流程節省開發時間。","inspiration":["搭配 n8n 自動化，批次抓取熱門新聞並分析內容趨勢。","使用 ScrapingBee API 抓取外部網站的評論資料，生成競品分析。","與 BrightData 代理結合，突破網站防爬限制。"]}'::jsonb,
    '[{"goal":"快速抓取動態網頁資料","method":"ScrapingBee API","tool_stack":["ScrapingBee","Python","n8n"],"steps":["註冊 ScrapingBee 取得 API key。","使用 HTTP 請求傳入 URL 及需要的參數，獲取頁面資料。","解析回傳結果並存入資料庫或分析工具。","整合工作流工具，以自動化定期抓取。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch1',
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
    curation_batch = 'v3.0-expansion-batch1',
    updated_at = NOW();

  -- Add zh-TW translation for ScrapingBee
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
    'Headless browser scraping API to extract data from websites with support for rendering JavaScript.',
    '{"encyclopedia":"ScrapingBee 提供簡單的 API，可執行無頭瀏覽器抓取網頁資料，支援渲染 JavaScript。","guide":"透過 ScrapingBee API，只需傳入目標網址，就能取得解析後的 HTML 或 JSON，適合沒有複雜爬蟲框架的使用者。","strategy":"若想快速抓取需要 JavaScript 渲染才能取得的資料，可以使用 ScrapingBee，結合代理服務或自動化流程節省開發時間。","inspiration":["搭配 n8n 自動化，批次抓取熱門新聞並分析內容趨勢。","使用 ScrapingBee API 抓取外部網站的評論資料，生成競品分析。","與 BrightData 代理結合，突破網站防爬限制。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 8. Phantombuster
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
    'Phantombuster',
    'Automation and data extraction platform for social media and web platforms.',
    'phantombuster',
    '{"purpose":["Application Oriented"],"functional_role":["Automation","Scraping"],"application_field":["Lead Generation","Marketing","Social Media"],"tech_layer":["Processing Layer"],"data_flow_role":["Input","Output"],"difficulty":"No-code","common_pairings":["LinkedIn","Salesforce","n8n"]}'::jsonb,
    '{"encyclopedia":"Phantombuster 提供一系列無須程式碼的 API 器和自動化模組，幫助使用者在社交平台和網站上抓取資料、發送訊息或執行其他操作。","guide":"在行銷和業務開發場景中，可利用 Phantombuster 收集潛在客戶名單，自動化重複操作，如在 LinkedIn 傳送邀請或抓取職業資訊。","strategy":"若需要批次收集社群資料或自動執行登入操作，Phantombuster 提供的現成功能可省去自建爬蟲時間，但需留意平台政策。","inspiration":["自動抓取 LinkedIn 名單並匯入 CRM，管理商機。","在 Twitter/Facebook 等社群媒體上追蹤特定主題並收集貼文資料。","使用 Phantombuster 自動發送邀請與關注，配合後續郵件行銷。"]}'::jsonb,
    '[{"goal":"建立自動化的名單收集流程","method":"使用 Phantombuster 社群 API","tool_stack":["Phantombuster","LinkedIn","Salesforce"],"steps":["選擇並設定所需的 Phantom（如 LinkedIn Contact Scraper）。","輸入搜尋參數並定義輸出格式。","將產生的名單匯出到 CRM 或行銷平台。","定期運行 Phantom 並保持資料更新。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch1',
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
    curation_batch = 'v3.0-expansion-batch1',
    updated_at = NOW();

  -- Add zh-TW translation for Phantombuster
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
    'Automation and data extraction platform for social media and web platforms.',
    '{"encyclopedia":"Phantombuster 提供一系列無須程式碼的 API 器和自動化模組，幫助使用者在社交平台和網站上抓取資料、發送訊息或執行其他操作。","guide":"在行銷和業務開發場景中，可利用 Phantombuster 收集潛在客戶名單，自動化重複操作，如在 LinkedIn 傳送邀請或抓取職業資訊。","strategy":"若需要批次收集社群資料或自動執行登入操作，Phantombuster 提供的現成功能可省去自建爬蟲時間，但需留意平台政策。","inspiration":["自動抓取 LinkedIn 名單並匯入 CRM，管理商機。","在 Twitter/Facebook 等社群媒體上追蹤特定主題並收集貼文資料。","使用 Phantombuster 自動發送邀請與關注，配合後續郵件行銷。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 9. Thunderbit
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
    'Thunderbit',
    'No-code automation and integration platform for building simple workflows.',
    'thunderbit',
    '{"purpose":["Application Oriented"],"functional_role":["Automation","Integration"],"application_field":["Marketing Automation","Productivity"],"tech_layer":["Integration Layer"],"data_flow_role":["Input","Output"],"difficulty":"No-code","common_pairings":["Google Sheets","Slack","Trello"]}'::jsonb,
    '{"encyclopedia":"Thunderbit 是一款簡易的無程式碼自動化工具，提供大量預設流程和整合，讓非技術使用者構建自動工作流。","guide":"使用 Thunderbit，可以直接拖拉元件來自動化常見任務，如同步表單資料到試算表、通知 Slack 等，不需寫程式。","strategy":"適合中小企業或個人快速建置簡易自動化流程，不想使用功能複雜的自動化平台時，Thunderbit 提供親民的替代方案。","inspiration":["當客戶填寫表單時，自動在 Trello 建立任務並通知團隊。","定期收集 Google Sheets 資料，發送至行銷平台。","在 Slack 中自動推播來自 CRM 的狀態更新。"]}'::jsonb,
    '[{"goal":"建置快速自動通知流程","method":"使用 Thunderbit 預設整合","tool_stack":["Thunderbit","Google Forms","Slack"],"steps":["登入 Thunderbit 並選擇表單-通知範本。","連結 Google Forms 帳號，選取特定表單。","連結 Slack，指定接收頻道。","啟用流程並測試提交表單後訊息是否順利推送。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch1',
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
    curation_batch = 'v3.0-expansion-batch1',
    updated_at = NOW();

  -- Add zh-TW translation for Thunderbit
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
    'No-code automation and integration platform for building simple workflows.',
    '{"encyclopedia":"Thunderbit 是一款簡易的無程式碼自動化工具，提供大量預設流程和整合，讓非技術使用者構建自動工作流。","guide":"使用 Thunderbit，可以直接拖拉元件來自動化常見任務，如同步表單資料到試算表、通知 Slack 等，不需寫程式。","strategy":"適合中小企業或個人快速建置簡易自動化流程，不想使用功能複雜的自動化平台時，Thunderbit 提供親民的替代方案。","inspiration":["當客戶填寫表單時，自動在 Trello 建立任務並通知團隊。","定期收集 Google Sheets 資料，發送至行銷平台。","在 Slack 中自動推播來自 CRM 的狀態更新。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 10. Miro
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
    'Miro',
    'Visual collaboration platform for brainstorming, diagramming, and project planning.',
    'miro',
    '{"purpose":["Learning Oriented","Application Oriented"],"functional_role":["Collaboration","Visualization"],"application_field":["UX Design","Project Management","Education"],"tech_layer":["Frontend Layer"],"data_flow_role":["Input","Output"],"difficulty":"No-code","common_pairings":["Figma","Jira","Slack"]}'::jsonb,
    '{"encyclopedia":"Miro 是一個線上白板平台，適合團隊共同協作、構思和規劃專案，支援無程式碼互動。","guide":"在工作坊、設計衝刺或專案規劃中，可使用 Miro 建立看板、流程圖及貼便簽，並與 Figma、Jira 等工具整合。","strategy":"適合跨團隊線上協作與視覺化流程，例如遠距團隊進行設計評審時，可用 Miro 統一意見，並同步更新至管理工具。","inspiration":["在 Miro 上啟動設計衝刺工作坊，利用貼便簽與投票功能集思廣益。","建立產品路線圖並連結 Jira 任務，提升透明度。","與 Figma 結合，將 UI 草圖直接貼至白板討論。"]}'::jsonb,
    '[{"goal":"遠距團隊設計規劃","method":"使用 Miro 白板協作","tool_stack":["Miro","Jira","Figma"],"steps":["建立 Miro 板並邀請團隊。","利用模板新增貼便簽、流程圖等元素。","在會議中共同編輯與討論，並標記優先事項。","將決議同步至 Jira 任務，後續追蹤。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch1',
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
    curation_batch = 'v3.0-expansion-batch1',
    updated_at = NOW();

  -- Add zh-TW translation for Miro
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
    'Visual collaboration platform for brainstorming, diagramming, and project planning.',
    '{"encyclopedia":"Miro 是一個線上白板平台，適合團隊共同協作、構思和規劃專案，支援無程式碼互動。","guide":"在工作坊、設計衝刺或專案規劃中，可使用 Miro 建立看板、流程圖及貼便簽，並與 Figma、Jira 等工具整合。","strategy":"適合跨團隊線上協作與視覺化流程，例如遠距團隊進行設計評審時，可用 Miro 統一意見，並同步更新至管理工具。","inspiration":["在 Miro 上啟動設計衝刺工作坊，利用貼便簽與投票功能集思廣益。","建立產品路線圖並連結 Jira 任務，提升透明度。","與 Figma 結合，將 UI 草圖直接貼至白板討論。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

END $$;

-- Add comment
COMMENT ON TABLE tools IS 'Updated with tools from Phase 3 expansion - Batch 1';
