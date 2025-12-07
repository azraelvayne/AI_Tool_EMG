/*
  # Import 30 New Tools - Batch 3 (Tools 11-16)

  Continuing import with:
  - Atlassian: Collaboration suite
  - Jam.dev: Bug reporting
  - Temporal: Workflow orchestration
  - Typedream: Site builder
  - Triform: Data transformation
  - Kintone: App builder
*/

-- Tool 11: Atlassian
DO $$
DECLARE
  v_tool_id uuid;
BEGIN
  INSERT INTO tools (
    tool_name,
    source_slug,
    summary,
    categories,
    is_curated,
    curation_batch
  ) VALUES (
    'Atlassian',
    'atlassian',
    'Suite of collaboration and productivity software including Jira, Confluence, Trello, and Bitbucket.',
    jsonb_build_object(
      'purpose', jsonb_build_array('System Oriented', 'Application Oriented'),
      'functional_role', jsonb_build_array('Project Management', 'Documentation', 'Version Control'),
      'application_field', jsonb_build_array('Software Development', 'Team Collaboration'),
      'tech_layer', jsonb_build_array('Integration Layer', 'Frontend Layer'),
      'data_flow_role', jsonb_build_array('Input', 'Processing', 'Output'),
      'difficulty', 'No-code',
      'common_pairings', jsonb_build_array('Slack', 'GitHub', 'Jira Service Management')
    ),
    true,
    'v3.0-expansion'
  )
  ON CONFLICT (tool_name) DO UPDATE
  SET summary = EXCLUDED.summary,
      categories = EXCLUDED.categories,
      is_curated = EXCLUDED.is_curated,
      curation_batch = EXCLUDED.curation_batch,
      updated_at = now()
  RETURNING id INTO v_tool_id;

  INSERT INTO tool_translations (tool_id, language_code, summary, description_styles)
  VALUES (
    v_tool_id,
    'zh-TW',
    'Atlassian 提供多款軟體,如 Jira、Confluence、Bitbucket,支援專案管理、文件協作與程式版本控制。',
    jsonb_build_object(
      'encyclopedia', 'Atlassian 提供多款軟體,如 Jira、Confluence、Bitbucket,支援專案管理、文件協作與程式版本控制。',
      'guide', '在軟體專案中,Jira 用於任務追蹤,Confluence 用於知識共享,而 Bitbucket 用於源碼管理。這些工具彼此整合,方便團隊協作。',
      'strategy', '如果您的團隊需要一站式管理開發任務、知識庫和程式碼,可以選擇 Atlassian 的產品組合,並整合 Slack 或 CI/CD 工具。',
      'inspiration', jsonb_build_array(
        '使用 Jira Sprint 管理敏捷迭代並追蹤進度。',
        '建立 Confluence 空間共享設計文件與決策記錄。',
        '使用 Bitbucket Pipelines 執行自動部署流程。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;

-- Tool 12: Jam.dev
DO $$
DECLARE
  v_tool_id uuid;
BEGIN
  INSERT INTO tools (
    tool_name,
    source_slug,
    summary,
    categories,
    is_curated,
    curation_batch
  ) VALUES (
    'Jam.dev',
    'jam-dev',
    'Bug reporting tool for dev teams capturing console logs, network requests, and annotated screenshots.',
    jsonb_build_object(
      'purpose', jsonb_build_array('Application Oriented'),
      'functional_role', jsonb_build_array('Bug Reporting', 'Collaboration'),
      'application_field', jsonb_build_array('Software QA', 'Developer Tools'),
      'tech_layer', jsonb_build_array('Frontend Layer'),
      'data_flow_role', jsonb_build_array('Input', 'Processing'),
      'difficulty', 'No-code',
      'common_pairings', jsonb_build_array('GitHub', 'Jira', 'Slack')
    ),
    true,
    'v3.0-expansion'
  )
  ON CONFLICT (tool_name) DO UPDATE
  SET summary = EXCLUDED.summary,
      categories = EXCLUDED.categories,
      is_curated = EXCLUDED.is_curated,
      curation_batch = EXCLUDED.curation_batch,
      updated_at = now()
  RETURNING id INTO v_tool_id;

  INSERT INTO tool_translations (tool_id, language_code, summary, description_styles)
  VALUES (
    v_tool_id,
    'zh-TW',
    'Jam.dev 是一個可擷取瀏覽器畫面、控制台 log 和網路請求的錯誤報告工具,幫助團隊即時了解問題。',
    jsonb_build_object(
      'encyclopedia', 'Jam.dev 是一個可擷取瀏覽器畫面、控制台 log 和網路請求的錯誤報告工具,幫助團隊即時了解問題。',
      'guide', '使用 Jam.dev 插件,測試者可以在瀏覽器中點擊一下即可錄下錯誤狀態與上下文,並直接發送至指定的問題追蹤系統。',
      'strategy', '若團隊常因無法重現錯誤而浪費時間,導入 Jam.dev 可在第一時間取得完整上下文,縮短 debug 時間。',
      'inspiration', jsonb_build_array(
        '在執行功能測試時,透過 Jam.dev 快速回報 bug 及錄影。',
        '當客戶報錯時,使用 Jam.dev 收集瀏覽器環境資訊並傳送給開發團隊。',
        '與 Jira 結合,自動建立帶有影片和 log 的 bug ticket。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;

-- Tool 13: Temporal
DO $$
DECLARE
  v_tool_id uuid;
BEGIN
  INSERT INTO tools (
    tool_name,
    source_slug,
    summary,
    categories,
    is_curated,
    curation_batch
  ) VALUES (
    'Temporal',
    'temporal',
    'Workflow as code platform to build and scale distributed applications with reliability.',
    jsonb_build_object(
      'purpose', jsonb_build_array('System Oriented'),
      'functional_role', jsonb_build_array('Workflow Orchestration', 'Distributed Systems'),
      'application_field', jsonb_build_array('Microservices', 'Backend'),
      'tech_layer', jsonb_build_array('Processing Layer'),
      'data_flow_role', jsonb_build_array('Processing', 'Orchestration'),
      'difficulty', 'Code',
      'common_pairings', jsonb_build_array('Go', 'Java', 'Kubernetes')
    ),
    true,
    'v3.0-expansion'
  )
  ON CONFLICT (tool_name) DO UPDATE
  SET summary = EXCLUDED.summary,
      categories = EXCLUDED.categories,
      is_curated = EXCLUDED.is_curated,
      curation_batch = EXCLUDED.curation_batch,
      updated_at = now()
  RETURNING id INTO v_tool_id;

  INSERT INTO tool_translations (tool_id, language_code, summary, description_styles)
  VALUES (
    v_tool_id,
    'zh-TW',
    'Temporal 是一個可程式化的工作流程平台,用於撰寫可靠且可擴展的分散式應用,支援長時間運行的工作與錯誤自動補償。',
    jsonb_build_object(
      'encyclopedia', 'Temporal 是一個可程式化的工作流程平台,用於撰寫可靠且可擴展的分散式應用,支援長時間運行的工作與錯誤自動補償。',
      'guide', 'Temporal 將工作流程定義寫成 code,提供持久化與重試機制,適合處理複雜且要求高穩定性的任務,如訂單流程或支付服務。',
      'strategy', '如須在微服務架構中處理需要多次重試或狀態管理的流程,可採用 Temporal 取代傳統 message queue + cron 的做法,確保一致性。',
      'inspiration', jsonb_build_array(
        '開發複雜的電商訂單流程,管理跨多服務的確認、付款與出貨。',
        '用於支援長時間執行的視頻轉檔或資料處理任務,確保每一小步成功。',
        '在微服務中實現 Saga 模式,處理事務補償。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;

-- Tool 14: Typedream
DO $$
DECLARE
  v_tool_id uuid;
BEGIN
  INSERT INTO tools (
    tool_name,
    source_slug,
    summary,
    categories,
    is_curated,
    curation_batch
  ) VALUES (
    'Typedream',
    'typedream',
    'No-code site builder that uses a Notion-like interface to create responsive web pages.',
    jsonb_build_object(
      'purpose', jsonb_build_array('Application Oriented', 'Learning Oriented'),
      'functional_role', jsonb_build_array('Site Building', 'CMS'),
      'application_field', jsonb_build_array('Web Development', 'Content Management'),
      'tech_layer', jsonb_build_array('Frontend Layer'),
      'data_flow_role', jsonb_build_array('Output'),
      'difficulty', 'No-code',
      'common_pairings', jsonb_build_array('Notion', 'Airtable', 'Zapier')
    ),
    true,
    'v3.0-expansion'
  )
  ON CONFLICT (tool_name) DO UPDATE
  SET summary = EXCLUDED.summary,
      categories = EXCLUDED.categories,
      is_curated = EXCLUDED.is_curated,
      curation_batch = EXCLUDED.curation_batch,
      updated_at = now()
  RETURNING id INTO v_tool_id;

  INSERT INTO tool_translations (tool_id, language_code, summary, description_styles)
  VALUES (
    v_tool_id,
    'zh-TW',
    'Typedream 是一個無程式碼網站建構工具,其介面類似 Notion,讓使用者輕鬆拖拉內容並快速生成響應式網站。',
    jsonb_build_object(
      'encyclopedia', 'Typedream 是一個無程式碼網站建構工具,其介面類似 Notion,讓使用者輕鬆拖拉內容並快速生成響應式網站。',
      'guide', '透過 Typedream,可將文字、圖片和區塊排列在頁面中。它支援自訂域名、表單與會員系統,可連結數據來源。',
      'strategy', '如果你需要快速建立個人或小型企業的品牌頁面,不想使用傳統 CMS,可選擇 Typedream 以最短時間上線。',
      'inspiration', jsonb_build_array(
        '創建個人作品集網站,將 Notion 中的內容同步到 Typedream。',
        '為 podcast 或部落格搭建官方網站,整合留言表單與訂閱系統。',
        '與 Airtable 整合,動態展示產品清單。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;

-- Tool 15: Triform
DO $$
DECLARE
  v_tool_id uuid;
BEGIN
  INSERT INTO tools (
    tool_name,
    source_slug,
    summary,
    categories,
    is_curated,
    curation_batch
  ) VALUES (
    'Triform',
    'triform',
    'Data transformation and validation tool for converting and cleaning datasets in various formats.',
    jsonb_build_object(
      'purpose', jsonb_build_array('Application Oriented'),
      'functional_role', jsonb_build_array('Data Transformation', 'Data Quality'),
      'application_field', jsonb_build_array('ETL', 'Data Engineering'),
      'tech_layer', jsonb_build_array('Processing Layer'),
      'data_flow_role', jsonb_build_array('Processing'),
      'difficulty', 'Low-code',
      'common_pairings', jsonb_build_array('Python', 'AWS Glue', 'Data warehouses')
    ),
    true,
    'v3.0-expansion'
  )
  ON CONFLICT (tool_name) DO UPDATE
  SET summary = EXCLUDED.summary,
      categories = EXCLUDED.categories,
      is_curated = EXCLUDED.is_curated,
      curation_batch = EXCLUDED.curation_batch,
      updated_at = now()
  RETURNING id INTO v_tool_id;

  INSERT INTO tool_translations (tool_id, language_code, summary, description_styles)
  VALUES (
    v_tool_id,
    'zh-TW',
    'Triform 是一個資料轉換與驗證工具,用於將各種資料格式轉換為一致的結構,並清理資料。',
    jsonb_build_object(
      'encyclopedia', 'Triform 是一個資料轉換與驗證工具,用於將各種資料格式轉換為一致的結構,並清理資料。',
      'guide', 'Triform 讓使用者以 GUI 或腳本形式定義資料轉換邏輯,包括欄位映射、型別轉換和規則驗證。',
      'strategy', '若需要將來自不同系統的資料整合到數據倉庫,並確保資料一致與品質,可先用 Triform 進行 ETL 前處理。',
      'inspiration', jsonb_build_array(
        '將 CSV 檔案轉換為 JSON 並進行欄位標準化。',
        '設定資料驗證規則,自動檢查缺失值並填補。',
        '結合 ETL 工具,對進入數據湖的資料進行清洗。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;

-- Tool 16: Kintone
DO $$
DECLARE
  v_tool_id uuid;
BEGIN
  INSERT INTO tools (
    tool_name,
    source_slug,
    summary,
    categories,
    is_curated,
    curation_batch
  ) VALUES (
    'Kintone',
    'kintone',
    'Customizable workspace platform to build apps and manage data without coding.',
    jsonb_build_object(
      'purpose', jsonb_build_array('Application Oriented'),
      'functional_role', jsonb_build_array('Database', 'App Builder'),
      'application_field', jsonb_build_array('Business Operations', 'Project Management'),
      'tech_layer', jsonb_build_array('Data Layer', 'Frontend Layer'),
      'data_flow_role', jsonb_build_array('Input', 'Storage', 'Output'),
      'difficulty', 'No-code',
      'common_pairings', jsonb_build_array('Zapier', 'n8n', 'Slack')
    ),
    true,
    'v3.0-expansion'
  )
  ON CONFLICT (tool_name) DO UPDATE
  SET summary = EXCLUDED.summary,
      categories = EXCLUDED.categories,
      is_curated = EXCLUDED.is_curated,
      curation_batch = EXCLUDED.curation_batch,
      updated_at = now()
  RETURNING id INTO v_tool_id;

  INSERT INTO tool_translations (tool_id, language_code, summary, description_styles)
  VALUES (
    v_tool_id,
    'zh-TW',
    'Kintone 是一個無程式碼應用平台,允許使用者建立自訂資料表和工作流程,用於內部管理和協作。',
    jsonb_build_object(
      'encyclopedia', 'Kintone 是一個無程式碼應用平台,允許使用者建立自訂資料表和工作流程,用於內部管理和協作。',
      'guide', '透過 Kintone,可以快速建立客製化 CRUD 應用,如採購申請、專案追蹤,並透過視覺化界面管理資料。',
      'strategy', '適合中小企業或團隊快速開發內部工具,例如申請流程與資料管理,無需程式技能。',
      'inspiration', jsonb_build_array(
        '建立差旅申請系統,由員工提交申請並由主管批核。',
        '以 Kintone 管理專案任務,並透過 Slack 通知更新。',
        '整合自動化工具,將 Kintone 資料定期導出分析。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;