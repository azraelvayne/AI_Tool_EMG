/*
  # Import 30 New Tools - Batch 1 (Tools 1-10)

  1. Overview
    First batch of 30 new AI tools to expand database coverage:
    - Airflow: Workflow orchestration
    - fal: SQL transformation
    - Prefect: Dataflow automation
    - Egnyte: Enterprise file sharing
    - Composio: Integration platform
    - BrightData: Web scraping proxy
    - ScrapingBee: Headless browser scraping
    - Phantombuster: Social media automation
    - Thunderbit: No-code automation
    - Miro: Visual collaboration

  2. Data Structure
    - Complete 4D classification for each tool
    - Chinese (zh-TW) translations
    - Marked as curated with batch 'v3.0-expansion'
*/

-- Tool 1: Airflow
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
    'Airflow',
    'airflow',
    'Open-source platform to programmatically author, schedule, and monitor workflows.',
    jsonb_build_object(
      'purpose', jsonb_build_array('System Oriented', 'Application Oriented'),
      'functional_role', jsonb_build_array('Automation', 'Workflow Orchestration'),
      'application_field', jsonb_build_array('Data Engineering', 'ETL', 'Orchestration'),
      'tech_layer', jsonb_build_array('Processing Layer'),
      'data_flow_role', jsonb_build_array('Processing', 'Orchestration'),
      'difficulty', 'Low-code',
      'common_pairings', jsonb_build_array('Docker', 'Kubernetes', 'AWS Lambda')
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
    'Airflow 是一個用 Python 編寫的開源平台,用於調度和監控工作流,主要應用於資料工程和 ETL。',
    jsonb_build_object(
      'encyclopedia', 'Airflow 是一個用 Python 編寫的開源平台,用於調度和監控工作流,主要應用於資料工程和 ETL。',
      'guide', '在資料工作流程中,Airflow 扮演了 Orchestrator 的角色,適合協調多個資料處理任務並設定依賴關係。透過 DAG 定義流程,執行排程。',
      'strategy', '當需要定期整理資料並在任務間建立依賴時,例如每日 ETL 或模型訓練 pipeline,可以使用 Airflow 作為流程引擎。搭配 Docker 或 Kubernetes 部署,提高彈性。',
      'inspiration', jsonb_build_array(
        '建立每日資料清理和轉換流程,將資料從多源匯入,轉換後送入數據倉庫。',
        '整合預測模型訓練、評估和部署,形成自動化機器學習 pipeline。',
        '作為報告生成流程控制台,定期拉取資料、生成報表並寄送給管理者。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;

-- Tool 2: fal
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
    'fal',
    'fal',
    'SQL-first transformation tool for data pipelines, integrates with dbt and orchestration engines.',
    jsonb_build_object(
      'purpose', jsonb_build_array('Application Oriented'),
      'functional_role', jsonb_build_array('Data Transformation', 'Analytics'),
      'application_field', jsonb_build_array('ETL', 'Data Engineering'),
      'tech_layer', jsonb_build_array('Processing Layer'),
      'data_flow_role', jsonb_build_array('Processing'),
      'difficulty', 'Low-code',
      'common_pairings', jsonb_build_array('dbt', 'Snowflake', 'Airflow')
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
    'fal 是一款聚焦於 SQL 轉換的資料管道工具,可與 dbt 與 Orchestration 平台整合,提供豐富的轉換腳本管理功能。',
    jsonb_build_object(
      'encyclopedia', 'fal 是一款聚焦於 SQL 轉換的資料管道工具,可與 dbt 與 Orchestration 平台整合,提供豐富的轉換腳本管理功能。',
      'guide', 'fal 主要在資料轉換流程中作為轉換執行者,允許直接撰寫 SQL 腳本管理資料轉換邏輯。可與 dbt 一起使用,提高程式化管理。',
      'strategy', '如果您的團隊已使用 dbt 管理資料模型,而想統一管理 SQL 轉換並與 Airflow 等排程系統接軌,可導入 fal 作為橋樑,維持資料轉換一致性。',
      'inspiration', jsonb_build_array(
        '利用 fal 將資料倉庫中需要清理的資料寫成 SQL,並與 dbt 同步管理。',
        '結合 Airflow 排程每日跑 fal 的 SQL 轉換,保持表格更新。',
        '在分析流程中快速試驗新的 SQL 轉換腳本,再推送到生產環境。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;

-- Tool 3: Prefect
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
    'Prefect',
    'prefect',
    'Dataflow automation and orchestration platform to build, observe, and manage data pipelines.',
    jsonb_build_object(
      'purpose', jsonb_build_array('System Oriented', 'Application Oriented'),
      'functional_role', jsonb_build_array('Automation', 'Workflow Orchestration'),
      'application_field', jsonb_build_array('Data Engineering', 'ETL', 'Machine Learning'),
      'tech_layer', jsonb_build_array('Processing Layer'),
      'data_flow_role', jsonb_build_array('Processing', 'Orchestration'),
      'difficulty', 'Low-code',
      'common_pairings', jsonb_build_array('Python', 'AWS', 'S3')
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
    'Prefect 是一個現代化的資料流程編排平台,支援編寫、監控及管理資料管道,並提供豐富的觀測功能。',
    jsonb_build_object(
      'encyclopedia', 'Prefect 是一個現代化的資料流程編排平台,支援編寫、監控及管理資料管道,並提供豐富的觀測功能。',
      'guide', '在資料管道中,Prefect 提供了 Task 和 Flow 的抽象,簡化複雜流程的定義與重試策略設定。可在雲端運行或本地。',
      'strategy', '當需要彈性管理資料管道且想避免 Airflow 的複雜性時,可導入 Prefect。它支援 Python function-based 定義流程,更易於測試與本地開發。',
      'inspiration', jsonb_build_array(
        '建立 ETL 流程,透過 Prefect 將 Python 任務串起,並在失敗時自動重試。',
        '運用 Prefect 的 Orion 平台監控 pipeline,快速定位問題。',
        '將機器學習訓練過程以 Prefect Flow 定義,使得模型訓練、評估與部署可視化。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;

-- Tool 4: Egnyte
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
    'Egnyte',
    'egnyte',
    'Enterprise-grade file sharing and content governance platform for secure collaboration.',
    jsonb_build_object(
      'purpose', jsonb_build_array('Application Oriented'),
      'functional_role', jsonb_build_array('File Storage', 'Collaboration'),
      'application_field', jsonb_build_array('Document Management', 'Enterprise'),
      'tech_layer', jsonb_build_array('Storage Layer'),
      'data_flow_role', jsonb_build_array('Storage', 'Output'),
      'difficulty', 'No-code',
      'common_pairings', jsonb_build_array('Slack', 'Microsoft Office', 'Salesforce')
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
    'Egnyte 提供雲端檔案共享與內容管理服務,支援企業內外部協作,並具備合規與安全功能。',
    jsonb_build_object(
      'encyclopedia', 'Egnyte 提供雲端檔案共享與內容管理服務,支援企業內外部協作,並具備合規與安全功能。',
      'guide', 'Egnyte 在工作流程中作為安全的檔案儲存與共享平台,可透過桌面同步客戶端或網頁使用,與各式協作工具整合。',
      'strategy', '若企業需要集中管理檔案且符合合規要求,又不想自建檔案伺服器,可採用 Egnyte。它支援權限控制與活動追蹤,適合分散團隊協作。',
      'inspiration', jsonb_build_array(
        '建立中央檔案庫,供遠端團隊安全共享文件並管控版本。',
        '整合 Egnyte 與 CRM 系統,自動保存合約與客戶資料。',
        '利用 Egnyte API 建立自動報告匯出,將資料定期同步到第三方系統。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;

-- Tool 5: Composio
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
    'Composio',
    'composio',
    'Unified integration platform enabling applications to communicate via a single API or SDK.',
    jsonb_build_object(
      'purpose', jsonb_build_array('System Oriented'),
      'functional_role', jsonb_build_array('Integration', 'API Gateway'),
      'application_field', jsonb_build_array('Developer Tools', 'Automation'),
      'tech_layer', jsonb_build_array('Integration Layer'),
      'data_flow_role', jsonb_build_array('Input', 'Output'),
      'difficulty', 'Low-code',
      'common_pairings', jsonb_build_array('Zapier', 'n8n', 'SaaS Platforms')
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
    'Composio 是一個連接不同 SaaS 平台的整合平台,提供統一 API,簡化多系統協作與工作流程的開發。',
    jsonb_build_object(
      'encyclopedia', 'Composio 是一個連接不同 SaaS 平台的整合平台,提供統一 API,簡化多系統協作與工作流程的開發。',
      'guide', '透過 Composio,可以快速串接不同應用,使用單一 SDK 存取多個服務的資料與功能。適合開發者建立整合型應用。',
      'strategy', '當你需要在同一應用程式中讀取並控制不同 SaaS 服務資料時,可利用 Composio 作為中介 API 層,減少重複整合開發工作。',
      'inspiration', jsonb_build_array(
        '在內部專案中串接 Slack、Google Drive 與 CRM 系統,並透過 Composio 直接管理檔案與訊息。',
        '結合自動化平台(如 n8n),利用 Composio 觸發多個服務的任務。',
        '打造統一控制台,可集中查看各服務資訊並進行批次操作。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;