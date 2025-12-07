/*
  # Import Tools - Batch 3 of 3 (Phase 3 Expansion)

  ## Overview
  This migration imports 10 tools as part of batch 3.
  Tools in this batch: Replicate, Daloopa, LSEG, Spaceship, Alpaca, BioRender, Hex, AllTrails, Canva, Figma

  ## Data Source
  Generated from additional_tools_dataset.json

  ## Import Strategy
  - Each tool gets a unique UUID
  - Categories are properly mapped to match existing schema
  - Translations are added for zh-TW locale
  - Common pairings are stored in categories
  - Curation batch: v3.0-expansion-batch3

  ## Date
  Generated: 2025-12-07T15:22:04.968Z
*/

-- Import tools (Batch 3)
DO $$
DECLARE
  tool_id UUID;
BEGIN

  -- 1. Replicate
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
    'Replicate',
    'Platform for hosting and running machine learning models in the cloud via simple API calls.',
    'replicate',
    '{"purpose":["Application Oriented","System Oriented"],"functional_role":["AI Models","Deployment"],"application_field":["Machine Learning","Prototyping"],"tech_layer":["AI Layer","Processing Layer"],"data_flow_role":["Processing","Output"],"difficulty":"Low-code","common_pairings":["Python","Gradio","Hugging Face"]}'::jsonb,
    '{"encyclopedia":"Replicate 是一個雲端平台，使用者可以迅速部署並呼叫各類 AI 模型作為 API，支援圖片生成、語言模型等。","guide":"用戶只需透過 API 傳入輸入資料即可獲取模型輸出結果；同時可將自己的模型封裝發布，供他人使用。","strategy":"若需要快速在產品中測試不同的 AI 模型，或是公開自己的模型供他人使用，Replicate 提供了簡易且可擴展的環境。","inspiration":["為網頁加入圖片生成功能，透過 Replicate 的 Stable Diffusion 模型 API 呼叫。","將實驗模型部署到 Replicate，提供團隊測試接口。","結合 Gradio 架設簡易介面，供使用者互動體驗 AI 功能。"]}'::jsonb,
    '[{"goal":"在應用中使用 AI 模型","method":"調用 Replicate API","tool_stack":["Replicate","Python","Gradio"],"steps":["在 Replicate 頁面尋找適合模型並取得 API token。","撰寫程式碼呼叫 API 並傳入需要的參數。","接收模型輸出並顯示於應用介面。","若需要，將自己的模型部署上 Replicate 並提供團隊使用。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch3',
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
    curation_batch = 'v3.0-expansion-batch3',
    updated_at = NOW();

  -- Add zh-TW translation for Replicate
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
    'Platform for hosting and running machine learning models in the cloud via simple API calls.',
    '{"encyclopedia":"Replicate 是一個雲端平台，使用者可以迅速部署並呼叫各類 AI 模型作為 API，支援圖片生成、語言模型等。","guide":"用戶只需透過 API 傳入輸入資料即可獲取模型輸出結果；同時可將自己的模型封裝發布，供他人使用。","strategy":"若需要快速在產品中測試不同的 AI 模型，或是公開自己的模型供他人使用，Replicate 提供了簡易且可擴展的環境。","inspiration":["為網頁加入圖片生成功能，透過 Replicate 的 Stable Diffusion 模型 API 呼叫。","將實驗模型部署到 Replicate，提供團隊測試接口。","結合 Gradio 架設簡易介面，供使用者互動體驗 AI 功能。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 2. Daloopa
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
    'Daloopa',
    'AI-driven data extraction and transcription tool for financial documents and calls.',
    'daloopa',
    '{"purpose":["Application Oriented"],"functional_role":["Data Extraction","Transcription"],"application_field":["Finance","Research"],"tech_layer":["Processing Layer"],"data_flow_role":["Input","Processing"],"difficulty":"No-code","common_pairings":["Excel","Bloomberg","Python"]}'::jsonb,
    '{"encyclopedia":"Daloopa 提供自動資料提取與逐字稿服務，特別針對財務報表與公司業績電話會議。","guide":"投資研究者可使用 Daloopa 將數百頁的財報自動解析為結構化資料表，或快速取得企業電話會議的逐字稿。","strategy":"當分析大量財務資料並需要高精度提取時，可使用 Daloopa 提升效率，減少手動輸入，並配合 Excel 或 BI 工具分析。","inspiration":["自動收集上市公司財務報表並輸出為 Excel 供分析。","生成多家公司季度會議記錄的逐字稿，建立詞頻分析。","整合 Daloopa 與投資研究平台，加快研究速度。"]}'::jsonb,
    '[{"goal":"提升財務資料分析效率","method":"使用 Daloopa 提取數據","tool_stack":["Daloopa","Excel","Bloomberg"],"steps":["上傳財務文件或提供報表連結至 Daloopa。","等待 AI 解析並輸出結構化資料。","下載 Excel 檔並進行後續分析與視覺化。","與外部資料庫交叉比對，獲得更深入洞見。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch3',
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
    curation_batch = 'v3.0-expansion-batch3',
    updated_at = NOW();

  -- Add zh-TW translation for Daloopa
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
    'AI-driven data extraction and transcription tool for financial documents and calls.',
    '{"encyclopedia":"Daloopa 提供自動資料提取與逐字稿服務，特別針對財務報表與公司業績電話會議。","guide":"投資研究者可使用 Daloopa 將數百頁的財報自動解析為結構化資料表，或快速取得企業電話會議的逐字稿。","strategy":"當分析大量財務資料並需要高精度提取時，可使用 Daloopa 提升效率，減少手動輸入，並配合 Excel 或 BI 工具分析。","inspiration":["自動收集上市公司財務報表並輸出為 Excel 供分析。","生成多家公司季度會議記錄的逐字稿，建立詞頻分析。","整合 Daloopa 與投資研究平台，加快研究速度。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 3. LSEG
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
    'LSEG',
    'Financial data and infrastructure from London Stock Exchange Group for trading and analytics.',
    'lseg',
    '{"purpose":["System Oriented","Application Oriented"],"functional_role":["Market Data","Trading Infrastructure"],"application_field":["Finance","Investment"],"tech_layer":["Data Layer","Integration Layer"],"data_flow_role":["Input","Processing"],"difficulty":"Low-code","common_pairings":["Alpaca","Bloomberg","Python"]}'::jsonb,
    '{"encyclopedia":"LSEG 提供全球市場資料、交易和基礎設施服務，包括 London Stock Exchange 以及各類數據平台。","guide":"投資者與開發者可從 LSEG API 取得即時及歷史市場資料，也可透過基礎設施進行交易連接。","strategy":"若需提供金融服務或執行大量量化交易，可以結合 LSEG 資料來源與其他 broker API，提高數據準確度與覆蓋範圍。","inspiration":["結合 LSEG 的即時市場資料與交易 API 建立量化交易平台。","使用 LSEG 歷史數據進行金融模型回測。","為金融新聞平台提供行情看板。"]}'::jsonb,
    '[{"goal":"建構量化交易系統","method":"使用 LSEG 資料 + broker API","tool_stack":["LSEG","Alpaca","Python"],"steps":["向 LSEG 取得即時市場行情與歷史資料。","使用 Alpaca 提供的交易介面執行訂單。","撰寫量化策略並利用 Python 執行。","監控交易結果並回測模型性能。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch3',
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
    curation_batch = 'v3.0-expansion-batch3',
    updated_at = NOW();

  -- Add zh-TW translation for LSEG
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
    'Financial data and infrastructure from London Stock Exchange Group for trading and analytics.',
    '{"encyclopedia":"LSEG 提供全球市場資料、交易和基礎設施服務，包括 London Stock Exchange 以及各類數據平台。","guide":"投資者與開發者可從 LSEG API 取得即時及歷史市場資料，也可透過基礎設施進行交易連接。","strategy":"若需提供金融服務或執行大量量化交易，可以結合 LSEG 資料來源與其他 broker API，提高數據準確度與覆蓋範圍。","inspiration":["結合 LSEG 的即時市場資料與交易 API 建立量化交易平台。","使用 LSEG 歷史數據進行金融模型回測。","為金融新聞平台提供行情看板。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 4. Spaceship
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
    'Spaceship',
    'Workflow automation platform designed to integrate data sources and coordinate multi-step processes.',
    'spaceship',
    '{"purpose":["System Oriented","Application Oriented"],"functional_role":["Automation","Integration"],"application_field":["Data Engineering","ETL"],"tech_layer":["Integration Layer","Processing Layer"],"data_flow_role":["Input","Processing","Output"],"difficulty":"Low-code","common_pairings":["Snowflake","BigQuery","Python"]}'::jsonb,
    '{"encyclopedia":"Spaceship 是一個資料工作流程自動化平台，用於將多個資料源連接並協調 ETL 過程。","guide":"透過 Spaceship，可以定義資料移動與轉換流程，對於跨資料倉庫、資料湖和 API 的整合很方便。","strategy":"適合需要在多個資料來源之間做同步與轉換的團隊，比如定期從 SaaS 應用抓取資料並導入數據倉庫。","inspiration":["將 CRM 資料匯入數據倉庫，並定期更新儀表板。","同時從多個 API 抓取資料，經過清理後寫入 BigQuery。","使用 Spaceship 自動排程 ETL 任務，提高準確性。"]}'::jsonb,
    '[{"goal":"統一資料管道","method":"使用 Spaceship 整合 ETL","tool_stack":["Spaceship","Snowflake","Python"],"steps":["在 Spaceship 建立新流程並連接資料來源。","設定資料轉換規則與排程。","執行流程並監測結果。","將清理後資料寫入目標數據倉庫。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch3',
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
    curation_batch = 'v3.0-expansion-batch3',
    updated_at = NOW();

  -- Add zh-TW translation for Spaceship
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
    'Workflow automation platform designed to integrate data sources and coordinate multi-step processes.',
    '{"encyclopedia":"Spaceship 是一個資料工作流程自動化平台，用於將多個資料源連接並協調 ETL 過程。","guide":"透過 Spaceship，可以定義資料移動與轉換流程，對於跨資料倉庫、資料湖和 API 的整合很方便。","strategy":"適合需要在多個資料來源之間做同步與轉換的團隊，比如定期從 SaaS 應用抓取資料並導入數據倉庫。","inspiration":["將 CRM 資料匯入數據倉庫，並定期更新儀表板。","同時從多個 API 抓取資料，經過清理後寫入 BigQuery。","使用 Spaceship 自動排程 ETL 任務，提高準確性。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 5. Alpaca
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
    'Alpaca',
    'Commission-free stock and crypto trading API for developers to build investment applications.',
    'alpaca',
    '{"purpose":["Application Oriented","System Oriented"],"functional_role":["Trading","Broker API"],"application_field":["Finance","Quantitative Analysis"],"tech_layer":["Integration Layer"],"data_flow_role":["Processing","Output"],"difficulty":"Low-code","common_pairings":["Python","LSEG","Pandas"]}'::jsonb,
    '{"encyclopedia":"Alpaca 提供股票與加密貨幣的免佣金交易 API，開發者可透過 HTTP 或 SDK 建立投資應用。","guide":"使用 Alpaca API，可以下單、管理資產及存取市場資料，適合開發自動交易或投資分析應用。","strategy":"如果您想自建投資機器人或為使用者提供交易功能，採用 Alpaca 作為後端可以快速上線。與分析庫搭配可建立量化系統。","inspiration":["開發一個交易機器人，自動買賣股票和加密貨幣。","建立投資組合追蹤工具，整合 Alpaca 資產資料。","撰寫量化策略並使用 Alpaca API 下單。"]}'::jsonb,
    '[{"goal":"建立自動交易應用","method":"使用 Alpaca API","tool_stack":["Alpaca","Python","Pandas"],"steps":["註冊 Alpaca 帳戶並取得 API key。","使用 Python SDK 撰寫交易程式碼。","訂閱即時行情並執行策略。","下單並監控資產變動。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch3',
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
    curation_batch = 'v3.0-expansion-batch3',
    updated_at = NOW();

  -- Add zh-TW translation for Alpaca
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
    'Commission-free stock and crypto trading API for developers to build investment applications.',
    '{"encyclopedia":"Alpaca 提供股票與加密貨幣的免佣金交易 API，開發者可透過 HTTP 或 SDK 建立投資應用。","guide":"使用 Alpaca API，可以下單、管理資產及存取市場資料，適合開發自動交易或投資分析應用。","strategy":"如果您想自建投資機器人或為使用者提供交易功能，採用 Alpaca 作為後端可以快速上線。與分析庫搭配可建立量化系統。","inspiration":["開發一個交易機器人，自動買賣股票和加密貨幣。","建立投資組合追蹤工具，整合 Alpaca 資產資料。","撰寫量化策略並使用 Alpaca API 下單。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 6. BioRender
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
    'BioRender',
    'Web-based tool for creating professional scientific illustrations and graphics.',
    'biorender',
    '{"purpose":["Learning Oriented","Application Oriented"],"functional_role":["Graphic Design","Visualization"],"application_field":["Scientific Research","Education"],"tech_layer":["Frontend Layer"],"data_flow_role":["Output"],"difficulty":"No-code","common_pairings":["Canva","Illustrator","PowerPoint"]}'::jsonb,
    '{"encyclopedia":"BioRender 是一個線上工具，專為科學家和教育工作者設計，提供豐富的科學圖標庫以製作專業插圖。","guide":"使用 BioRender，可以透過拖拉方式組合細胞、蛋白質或分子圖案，快速生成出版級的圖像，支援匯出多種格式。","strategy":"在撰寫論文、海報或教學材料時，使用 BioRender 可以提升視覺品質並節省繪圖時間。","inspiration":["為科研論文繪製實驗流程圖。","設計教育海報，展示細胞作用機制。","結合 PowerPoint，讓報告更具吸引力。"]}'::jsonb,
    '[{"goal":"製作生物學插圖","method":"使用 BioRender 圖形庫","tool_stack":["BioRender","PowerPoint","Illustrator"],"steps":["登入 BioRender 選擇合適模板或從空白開始。","拖拉需要的科學圖標並排版。","自訂顏色和標註文字。","匯出為圖檔並用於論文或簡報。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch3',
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
    curation_batch = 'v3.0-expansion-batch3',
    updated_at = NOW();

  -- Add zh-TW translation for BioRender
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
    'Web-based tool for creating professional scientific illustrations and graphics.',
    '{"encyclopedia":"BioRender 是一個線上工具，專為科學家和教育工作者設計，提供豐富的科學圖標庫以製作專業插圖。","guide":"使用 BioRender，可以透過拖拉方式組合細胞、蛋白質或分子圖案，快速生成出版級的圖像，支援匯出多種格式。","strategy":"在撰寫論文、海報或教學材料時，使用 BioRender 可以提升視覺品質並節省繪圖時間。","inspiration":["為科研論文繪製實驗流程圖。","設計教育海報，展示細胞作用機制。","結合 PowerPoint，讓報告更具吸引力。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 7. Hex
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
    'Hex',
    'Collaborative data workspace for analytics and visualization using notebooks and SQL.',
    'hex',
    '{"purpose":["Learning Oriented","Application Oriented"],"functional_role":["Analytics","Visualization"],"application_field":["Data Science","Business Intelligence"],"tech_layer":["Processing Layer","AI Layer"],"data_flow_role":["Input","Processing","Output"],"difficulty":"Low-code","common_pairings":["SQL","Python","Snowflake"]}'::jsonb,
    '{"encyclopedia":"Hex 是一個協作式資料工作空間，可在 notebook 中混合 SQL 和 Python，快速進行分析並分享儀表板。","guide":"在 Hex 中，使用者可建立互動式 notebook，編寫 SQL 查詢並透過 Python 繪製圖表，然後分享為 web app。","strategy":"適合數據團隊需要視覺化分析並與非技術成員分享結果的情境；Hex 讓分析與儀表板連貫，同時支援版本控制。","inspiration":["用 Hex 連線 Snowflake，寫 SQL 查詢並繪製銷售趨勢圖。","建立交互式分析應用，讓用戶自訂篩選，動態更新結果。","與團隊協作同時編輯 notebook，共同探索資料。"]}'::jsonb,
    '[{"goal":"製作互動式資料分析應用","method":"混合 SQL 和 Python","tool_stack":["Hex","Snowflake","Matplotlib"],"steps":["在 Hex 中建立新的 workbook。","撰寫 SQL 查詢獲得資料並載入至 Python cell。","使用 Python 進行資料處理與繪圖。","發佈為互動 dashboard 並分享給團隊。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch3',
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
    curation_batch = 'v3.0-expansion-batch3',
    updated_at = NOW();

  -- Add zh-TW translation for Hex
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
    'Collaborative data workspace for analytics and visualization using notebooks and SQL.',
    '{"encyclopedia":"Hex 是一個協作式資料工作空間，可在 notebook 中混合 SQL 和 Python，快速進行分析並分享儀表板。","guide":"在 Hex 中，使用者可建立互動式 notebook，編寫 SQL 查詢並透過 Python 繪製圖表，然後分享為 web app。","strategy":"適合數據團隊需要視覺化分析並與非技術成員分享結果的情境；Hex 讓分析與儀表板連貫，同時支援版本控制。","inspiration":["用 Hex 連線 Snowflake，寫 SQL 查詢並繪製銷售趨勢圖。","建立交互式分析應用，讓用戶自訂篩選，動態更新結果。","與團隊協作同時編輯 notebook，共同探索資料。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 8. AllTrails
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
    'AllTrails',
    'Platform offering trail maps, reviews, and route planning for outdoor activities.',
    'alltrails',
    '{"purpose":["Application Oriented","Learning Oriented"],"functional_role":["Navigation","Community"],"application_field":["Outdoor Recreation","Fitness"],"tech_layer":["Frontend Layer"],"data_flow_role":["Output"],"difficulty":"No-code","common_pairings":["Strava","Google Maps","Apple Health"]}'::jsonb,
    '{"encyclopedia":"AllTrails 提供世界各地的戶外步道資料庫，包括地圖、路線規劃和用戶評論，適合登山、跑步或騎行。","guide":"使用 AllTrails 應用或網站，可搜尋附近路線，查看難度、距離與景點資訊，並記錄自己的活動軌跡。","strategy":"若您正在規劃戶外行程或希望發現新路線，AllTrails 提供廣泛且即時的資訊；亦可與健身應用整合同步活動。","inspiration":["查找適合全家健走的友善步道並查看其他人評價。","規劃長距離跑步路線，並利用 AllTrails 提供的 GPX 檔匯入手錶。","探索新的登山路線，記錄途中的照片與心得並分享。"]}'::jsonb,
    '[{"goal":"發現新戶外路線","method":"使用 AllTrails 應用搜尋","tool_stack":["AllTrails","Google Maps","Strava"],"steps":["開啟 AllTrails 並依據所在地搜尋路線。","查看路線難度、距離與評分後選擇合適路線。","開始活動並記錄，完成後可將軌跡匯出到其他健身平台。","留下評論與照片，回饋社群。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch3',
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
    curation_batch = 'v3.0-expansion-batch3',
    updated_at = NOW();

  -- Add zh-TW translation for AllTrails
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
    'Platform offering trail maps, reviews, and route planning for outdoor activities.',
    '{"encyclopedia":"AllTrails 提供世界各地的戶外步道資料庫，包括地圖、路線規劃和用戶評論，適合登山、跑步或騎行。","guide":"使用 AllTrails 應用或網站，可搜尋附近路線，查看難度、距離與景點資訊，並記錄自己的活動軌跡。","strategy":"若您正在規劃戶外行程或希望發現新路線，AllTrails 提供廣泛且即時的資訊；亦可與健身應用整合同步活動。","inspiration":["查找適合全家健走的友善步道並查看其他人評價。","規劃長距離跑步路線，並利用 AllTrails 提供的 GPX 檔匯入手錶。","探索新的登山路線，記錄途中的照片與心得並分享。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 9. Canva
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
    'Canva',
    'Online graphic design platform for creating presentations, social media graphics, and marketing materials.',
    'canva',
    '{"purpose":["Learning Oriented","Application Oriented"],"functional_role":["Graphic Design","Presentation"],"application_field":["Marketing","Education","Social Media"],"tech_layer":["Frontend Layer"],"data_flow_role":["Output"],"difficulty":"No-code","common_pairings":["Instagram","PowerPoint","Figma"]}'::jsonb,
    '{"encyclopedia":"Canva 是一個線上圖像設計工具，提供大量模板與元素，適合創建演示文稿、社群貼文和行銷素材。","guide":"透過 Canva 使用者可選擇適用於不同場景的預設模板，並以拖放方式編輯圖文，完成後可直接下載或分享到社群平台。","strategy":"適合需要快速產出專業設計的個人與團隊，Canva 提供簡易操作與協作功能，並支援自訂品牌素材。","inspiration":["製作吸睛的 Instagram 貼文或 Facebook 封面。","為線上課程創建 PPT 並匯出為 PDF。","使用 Team 功能與同事協作完成行銷刊物。"]}'::jsonb,
    '[{"goal":"設計社群貼文模板","method":"使用 Canva 模板","tool_stack":["Canva","Instagram","Figma"],"steps":["選擇符合品牌風格的社群模板。","替換文字、圖片與配色。","與團隊協作檢查並編輯。","匯出並發布至社群平台。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch3',
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
    curation_batch = 'v3.0-expansion-batch3',
    updated_at = NOW();

  -- Add zh-TW translation for Canva
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
    'Online graphic design platform for creating presentations, social media graphics, and marketing materials.',
    '{"encyclopedia":"Canva 是一個線上圖像設計工具，提供大量模板與元素，適合創建演示文稿、社群貼文和行銷素材。","guide":"透過 Canva 使用者可選擇適用於不同場景的預設模板，並以拖放方式編輯圖文，完成後可直接下載或分享到社群平台。","strategy":"適合需要快速產出專業設計的個人與團隊，Canva 提供簡易操作與協作功能，並支援自訂品牌素材。","inspiration":["製作吸睛的 Instagram 貼文或 Facebook 封面。","為線上課程創建 PPT 並匯出為 PDF。","使用 Team 功能與同事協作完成行銷刊物。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

  -- 10. Figma
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
    'Figma',
    'Collaborative interface design tool for UI/UX designers and product teams.',
    'figma',
    '{"purpose":["Learning Oriented","Application Oriented"],"functional_role":["Design","Collaboration"],"application_field":["UI/UX","Product Design"],"tech_layer":["Frontend Layer"],"data_flow_role":["Input","Output"],"difficulty":"Low-code","common_pairings":["Miro","Zeplin","Storybook"]}'::jsonb,
    '{"encyclopedia":"Figma 是一個協作式介面設計工具，提供即時共同編輯與原型製作功能。","guide":"設計師可在 Figma 上繪製線框稿、視覺介面，並建立互動原型；與產品經理和工程師同步，支援評論與交付。","strategy":"適合設計團隊希望縮短交付周期並保持版本一致性；Figma 提供元件系統和變體，讓設計規範化。","inspiration":["創建設計系統，分享可重用元件供全公司使用。","與產品經理在同一檔案協作，標記需求並寫下備註。","生成互動原型並用於用戶測試。"]}'::jsonb,
    '[{"goal":"制定產品介面設計方案","method":"使用 Figma 協作","tool_stack":["Figma","Miro","Storybook"],"steps":["建立新設計檔案並設定畫板。","設計線框稿與高擬真介面。","定義元件並運用變體統一樣式。","匯出原型交付給工程團隊，並與 Storybook 對照。"]}]'::jsonb,
    true,
    'v3.0-expansion-batch3',
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
    curation_batch = 'v3.0-expansion-batch3',
    updated_at = NOW();

  -- Add zh-TW translation for Figma
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
    'Collaborative interface design tool for UI/UX designers and product teams.',
    '{"encyclopedia":"Figma 是一個協作式介面設計工具，提供即時共同編輯與原型製作功能。","guide":"設計師可在 Figma 上繪製線框稿、視覺介面，並建立互動原型；與產品經理和工程師同步，支援評論與交付。","strategy":"適合設計團隊希望縮短交付周期並保持版本一致性；Figma 提供元件系統和變體，讓設計規範化。","inspiration":["創建設計系統，分享可重用元件供全公司使用。","與產品經理在同一檔案協作，標記需求並寫下備註。","生成互動原型並用於用戶測試。"]}'::jsonb,
    NOW()
  ) ON CONFLICT (tool_id, language_code) DO UPDATE SET
    summary = EXCLUDED.summary,
    description_styles = EXCLUDED.description_styles;

END $$;

-- Add comment
COMMENT ON TABLE tools IS 'Updated with tools from Phase 3 expansion - Batch 3';
