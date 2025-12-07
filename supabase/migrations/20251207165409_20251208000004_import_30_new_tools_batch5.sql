/*
  # Import 30 New Tools - Batch 5 (Tools 23-30) - FINAL BATCH

  Final batch import:
  - LSEG: Financial data infrastructure
  - Spaceship: Workflow automation
  - Alpaca: Trading API
  - BioRender: Scientific illustrations
  - Hex: Collaborative analytics
  - AllTrails: Outdoor navigation
  - Canva: Graphic design
  - Figma: UI/UX design
*/

-- Tool 23: LSEG
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
    'LSEG',
    'lseg',
    'Financial data and infrastructure from London Stock Exchange Group for trading and analytics.',
    jsonb_build_object(
      'purpose', jsonb_build_array('System Oriented', 'Application Oriented'),
      'functional_role', jsonb_build_array('Market Data', 'Trading Infrastructure'),
      'application_field', jsonb_build_array('Finance', 'Investment'),
      'tech_layer', jsonb_build_array('Data Layer', 'Integration Layer'),
      'data_flow_role', jsonb_build_array('Input', 'Processing'),
      'difficulty', 'Low-code',
      'common_pairings', jsonb_build_array('Alpaca', 'Bloomberg', 'Python')
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
    'LSEG 提供全球市場資料、交易和基礎設施服務,包括 London Stock Exchange 以及各類數據平台。',
    jsonb_build_object(
      'encyclopedia', 'LSEG 提供全球市場資料、交易和基礎設施服務,包括 London Stock Exchange 以及各類數據平台。',
      'guide', '投資者與開發者可從 LSEG API 取得即時及歷史市場資料,也可透過基礎設施進行交易連接。',
      'strategy', '若需提供金融服務或執行大量量化交易,可以結合 LSEG 資料來源與其他 broker API,提高數據準確度與覆蓋範圍。',
      'inspiration', jsonb_build_array(
        '結合 LSEG 的即時市場資料與交易 API 建立量化交易平台。',
        '使用 LSEG 歷史數據進行金融模型回測。',
        '為金融新聞平台提供行情看板。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;

-- Tool 24: Spaceship
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
    'Spaceship',
    'spaceship',
    'Workflow automation platform designed to integrate data sources and coordinate multi-step processes.',
    jsonb_build_object(
      'purpose', jsonb_build_array('System Oriented', 'Application Oriented'),
      'functional_role', jsonb_build_array('Automation', 'Integration'),
      'application_field', jsonb_build_array('Data Engineering', 'ETL'),
      'tech_layer', jsonb_build_array('Integration Layer', 'Processing Layer'),
      'data_flow_role', jsonb_build_array('Input', 'Processing', 'Output'),
      'difficulty', 'Low-code',
      'common_pairings', jsonb_build_array('Snowflake', 'BigQuery', 'Python')
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
    'Spaceship 是一個資料工作流程自動化平台,用於將多個資料源連接並協調 ETL 過程。',
    jsonb_build_object(
      'encyclopedia', 'Spaceship 是一個資料工作流程自動化平台,用於將多個資料源連接並協調 ETL 過程。',
      'guide', '透過 Spaceship,可以定義資料移動與轉換流程,對於跨資料倉庫、資料湖和 API 的整合很方便。',
      'strategy', '適合需要在多個資料來源之間做同步與轉換的團隊,比如定期從 SaaS 應用抓取資料並導入數據倉庫。',
      'inspiration', jsonb_build_array(
        '將 CRM 資料匯入數據倉庫,並定期更新儀表板。',
        '同時從多個 API 抓取資料,經過清理後寫入 BigQuery。',
        '使用 Spaceship 自動排程 ETL 任務,提高準確性。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;

-- Tool 25: Alpaca
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
    'Alpaca',
    'alpaca',
    'Commission-free stock and crypto trading API for developers to build investment applications.',
    jsonb_build_object(
      'purpose', jsonb_build_array('Application Oriented', 'System Oriented'),
      'functional_role', jsonb_build_array('Trading', 'Broker API'),
      'application_field', jsonb_build_array('Finance', 'Quantitative Analysis'),
      'tech_layer', jsonb_build_array('Integration Layer'),
      'data_flow_role', jsonb_build_array('Processing', 'Output'),
      'difficulty', 'Low-code',
      'common_pairings', jsonb_build_array('Python', 'LSEG', 'Pandas')
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
    'Alpaca 提供股票與加密貨幣的免佣金交易 API,開發者可透過 HTTP 或 SDK 建立投資應用。',
    jsonb_build_object(
      'encyclopedia', 'Alpaca 提供股票與加密貨幣的免佣金交易 API,開發者可透過 HTTP 或 SDK 建立投資應用。',
      'guide', '使用 Alpaca API,可以下單、管理資產及存取市場資料,適合開發自動交易或投資分析應用。',
      'strategy', '如果您想自建投資機器人或為使用者提供交易功能,採用 Alpaca 作為後端可以快速上線。與分析庫搭配可建立量化系統。',
      'inspiration', jsonb_build_array(
        '開發一個交易機器人,自動買賣股票和加密貨幣。',
        '建立投資組合追蹤工具,整合 Alpaca 資產資料。',
        '撰寫量化策略並使用 Alpaca API 下單。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;

-- Tool 26: BioRender
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
    'BioRender',
    'biorender',
    'Web-based tool for creating professional scientific illustrations and graphics.',
    jsonb_build_object(
      'purpose', jsonb_build_array('Learning Oriented', 'Application Oriented'),
      'functional_role', jsonb_build_array('Graphic Design', 'Visualization'),
      'application_field', jsonb_build_array('Scientific Research', 'Education'),
      'tech_layer', jsonb_build_array('Frontend Layer'),
      'data_flow_role', jsonb_build_array('Output'),
      'difficulty', 'No-code',
      'common_pairings', jsonb_build_array('Canva', 'Illustrator', 'PowerPoint')
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
    'BioRender 是一個線上工具,專為科學家和教育工作者設計,提供豐富的科學圖標庫以製作專業插圖。',
    jsonb_build_object(
      'encyclopedia', 'BioRender 是一個線上工具,專為科學家和教育工作者設計,提供豐富的科學圖標庫以製作專業插圖。',
      'guide', '使用 BioRender,可以透過拖拉方式組合細胞、蛋白質或分子圖案,快速生成出版級的圖像,支援匯出多種格式。',
      'strategy', '在撰寫論文、海報或教學材料時,使用 BioRender 可以提升視覺品質並節省繪圖時間。',
      'inspiration', jsonb_build_array(
        '為科研論文繪製實驗流程圖。',
        '設計教育海報,展示細胞作用機制。',
        '結合 PowerPoint,讓報告更具吸引力。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;

-- Tool 27: Hex
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
    'Hex',
    'hex',
    'Collaborative data workspace for analytics and visualization using notebooks and SQL.',
    jsonb_build_object(
      'purpose', jsonb_build_array('Learning Oriented', 'Application Oriented'),
      'functional_role', jsonb_build_array('Analytics', 'Visualization'),
      'application_field', jsonb_build_array('Data Science', 'Business Intelligence'),
      'tech_layer', jsonb_build_array('Processing Layer', 'AI Layer'),
      'data_flow_role', jsonb_build_array('Input', 'Processing', 'Output'),
      'difficulty', 'Low-code',
      'common_pairings', jsonb_build_array('SQL', 'Python', 'Snowflake')
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
    'Hex 是一個協作式資料工作空間,可在 notebook 中混合 SQL 和 Python,快速進行分析並分享儀表板。',
    jsonb_build_object(
      'encyclopedia', 'Hex 是一個協作式資料工作空間,可在 notebook 中混合 SQL 和 Python,快速進行分析並分享儀表板。',
      'guide', '在 Hex 中,使用者可建立互動式 notebook,編寫 SQL 查詢並透過 Python 繪製圖表,然後分享為 web app。',
      'strategy', '適合數據團隊需要視覺化分析並與非技術成員分享結果的情境;Hex 讓分析與儀表板連貫,同時支援版本控制。',
      'inspiration', jsonb_build_array(
        '用 Hex 連線 Snowflake,寫 SQL 查詢並繪製銷售趨勢圖。',
        '建立交互式分析應用,讓用戶自訂篩選,動態更新結果。',
        '與團隊協作同時編輯 notebook,共同探索資料。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;

-- Tool 28: AllTrails
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
    'AllTrails',
    'alltrails',
    'Platform offering trail maps, reviews, and route planning for outdoor activities.',
    jsonb_build_object(
      'purpose', jsonb_build_array('Application Oriented', 'Learning Oriented'),
      'functional_role', jsonb_build_array('Navigation', 'Community'),
      'application_field', jsonb_build_array('Outdoor Recreation', 'Fitness'),
      'tech_layer', jsonb_build_array('Frontend Layer'),
      'data_flow_role', jsonb_build_array('Output'),
      'difficulty', 'No-code',
      'common_pairings', jsonb_build_array('Strava', 'Google Maps', 'Apple Health')
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
    'AllTrails 提供世界各地的戶外步道資料庫,包括地圖、路線規劃和用戶評論,適合登山、跑步或騎行。',
    jsonb_build_object(
      'encyclopedia', 'AllTrails 提供世界各地的戶外步道資料庫,包括地圖、路線規劃和用戶評論,適合登山、跑步或騎行。',
      'guide', '使用 AllTrails 應用或網站,可搜尋附近路線,查看難度、距離與景點資訊,並記錄自己的活動軌跡。',
      'strategy', '若您正在規劃戶外行程或希望發現新路線,AllTrails 提供廣泛且即時的資訊;亦可與健身應用整合同步活動。',
      'inspiration', jsonb_build_array(
        '查找適合全家健走的友善步道並查看其他人評價。',
        '規劃長距離跑步路線,並利用 AllTrails 提供的 GPX 檔匯入手錶。',
        '探索新的登山路線,記錄途中的照片與心得並分享。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;

-- Tool 29: Canva
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
    'Canva',
    'canva',
    'Online graphic design platform for creating presentations, social media graphics, and marketing materials.',
    jsonb_build_object(
      'purpose', jsonb_build_array('Learning Oriented', 'Application Oriented'),
      'functional_role', jsonb_build_array('Graphic Design', 'Presentation'),
      'application_field', jsonb_build_array('Marketing', 'Education', 'Social Media'),
      'tech_layer', jsonb_build_array('Frontend Layer'),
      'data_flow_role', jsonb_build_array('Output'),
      'difficulty', 'No-code',
      'common_pairings', jsonb_build_array('Instagram', 'PowerPoint', 'Figma')
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
    'Canva 是一個線上圖像設計工具,提供大量模板與元素,適合創建演示文稿、社群貼文和行銷素材。',
    jsonb_build_object(
      'encyclopedia', 'Canva 是一個線上圖像設計工具,提供大量模板與元素,適合創建演示文稿、社群貼文和行銷素材。',
      'guide', '透過 Canva 使用者可選擇適用於不同場景的預設模板,並以拖放方式編輯圖文,完成後可直接下載或分享到社群平台。',
      'strategy', '適合需要快速產出專業設計的個人與團隊,Canva 提供簡易操作與協作功能,並支援自訂品牌素材。',
      'inspiration', jsonb_build_array(
        '製作吸睛的 Instagram 貼文或 Facebook 封面。',
        '為線上課程創建 PPT 並匯出為 PDF。',
        '使用 Team 功能與同事協作完成行銷刊物。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;

-- Tool 30: Figma
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
    'Figma',
    'figma',
    'Collaborative interface design tool for UI/UX designers and product teams.',
    jsonb_build_object(
      'purpose', jsonb_build_array('Learning Oriented', 'Application Oriented'),
      'functional_role', jsonb_build_array('Design', 'Collaboration'),
      'application_field', jsonb_build_array('UI/UX', 'Product Design'),
      'tech_layer', jsonb_build_array('Frontend Layer'),
      'data_flow_role', jsonb_build_array('Input', 'Output'),
      'difficulty', 'Low-code',
      'common_pairings', jsonb_build_array('Miro', 'Zeplin', 'Storybook')
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
    'Figma 是一個協作式介面設計工具,提供即時共同編輯與原型製作功能。',
    jsonb_build_object(
      'encyclopedia', 'Figma 是一個協作式介面設計工具,提供即時共同編輯與原型製作功能。',
      'guide', '設計師可在 Figma 上繪製線框稿、視覺介面,並建立互動原型;與產品經理和工程師同步,支援評論與交付。',
      'strategy', '適合設計團隊希望縮短交付周期並保持版本一致性;Figma 提供元件系統和變體,讓設計規範化。',
      'inspiration', jsonb_build_array(
        '創建設計系統,分享可重用元件供全公司使用。',
        '與產品經理在同一檔案協作,標記需求並寫下備註。',
        '生成互動原型並用於用戶測試。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;