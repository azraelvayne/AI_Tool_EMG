/*
  # Import 30 New Tools - Batch 4 (Tools 17-22)

  Continuing import with:
  - Kubernetes: Container orchestration
  - Carrd: Landing page builder
  - Mintlify: Documentation platform
  - Zenler: Course creation platform
  - Replicate: ML model hosting
  - Daloopa: Financial data extraction
*/

-- Tool 17: Kubernetes
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
    'Kubernetes',
    'kubernetes',
    'Open-source container orchestration platform for deploying and managing containerized applications.',
    jsonb_build_object(
      'purpose', jsonb_build_array('System Oriented'),
      'functional_role', jsonb_build_array('Container Orchestration', 'Infrastructure'),
      'application_field', jsonb_build_array('DevOps', 'Cloud Native'),
      'tech_layer', jsonb_build_array('Infrastructure Layer'),
      'data_flow_role', jsonb_build_array('Processing'),
      'difficulty', 'Code',
      'common_pairings', jsonb_build_array('Docker', 'Helm', 'Prometheus')
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
    'Kubernetes 是一個開源的容器協調平台,用於自動化部署、擴充和管理容器化應用程式。',
    jsonb_build_object(
      'encyclopedia', 'Kubernetes 是一個開源的容器協調平台,用於自動化部署、擴充和管理容器化應用程式。',
      'guide', '在雲原生架構中,Kubernetes 管理 Pod、Service 和 Deployment,使得應用在各種環境中穩定運行。',
      'strategy', '若需要高度可擴展及自癒的服務,可以採用 Kubernetes。透過 Helm chart、GitOps 可以簡化部署。',
      'inspiration', jsonb_build_array(
        '部署微服務架構,管理多個容器並自動水平擴展。',
        '結合 CI/CD pipeline,透過 Kubernetes 滾動更新應用。',
        '使用 Kubernetes 管理機器學習模型服務的部署與伸縮。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;

-- Tool 18: Carrd
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
    'Carrd',
    'carrd',
    'Simple one-page site builder for personal profiles, landing pages, and portfolios.',
    jsonb_build_object(
      'purpose', jsonb_build_array('Application Oriented'),
      'functional_role', jsonb_build_array('Site Building', 'Landing Pages'),
      'application_field', jsonb_build_array('Personal Branding', 'Marketing'),
      'tech_layer', jsonb_build_array('Frontend Layer'),
      'data_flow_role', jsonb_build_array('Output'),
      'difficulty', 'No-code',
      'common_pairings', jsonb_build_array('Mailchimp', 'Google Analytics', 'Typeform')
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
    'Carrd 是一個簡單的單頁網站建設平台,用戶可以快速製作個人簡介、落地頁面或作品集。',
    jsonb_build_object(
      'encyclopedia', 'Carrd 是一個簡單的單頁網站建設平台,用戶可以快速製作個人簡介、落地頁面或作品集。',
      'guide', '透過 Carrd 的拖放介面與模板,只需幾分鐘即可建立簡單且美觀的頁面,支援自訂域名與表單。',
      'strategy', '如果想建立快速的宣傳頁面或試驗概念,Carrd 提供低門檻且成本低廉的選擇。',
      'inspiration', jsonb_build_array(
        '創建個人簡歷或求職作品集頁面,包含聯絡表單。',
        '建立活動宣傳頁,與外部報名系統整合。',
        '為創業項目設立簡單落地頁並收集訂閱。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;

-- Tool 19: Mintlify
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
    'Mintlify',
    'mintlify',
    'Documentation platform that turns code into beautifully formatted docs with AI-assisted content generation.',
    jsonb_build_object(
      'purpose', jsonb_build_array('Learning Oriented', 'Application Oriented'),
      'functional_role', jsonb_build_array('Documentation', 'Developer Tools'),
      'application_field', jsonb_build_array('Developer Experience', 'API Docs'),
      'tech_layer', jsonb_build_array('Frontend Layer'),
      'data_flow_role', jsonb_build_array('Output'),
      'difficulty', 'Low-code',
      'common_pairings', jsonb_build_array('GitHub', 'Markdown', 'Notion')
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
    'Mintlify 是一個文件生成平台,可自動從程式碼中生成美觀的 API 與技術文檔,並提供 AI 協助改寫。',
    jsonb_build_object(
      'encyclopedia', 'Mintlify 是一個文件生成平台,可自動從程式碼中生成美觀的 API 與技術文檔,並提供 AI 協助改寫。',
      'guide', '透過匯入程式庫或專案,Mintlify 自動解析函式和類別,生成互動式說明書。可自訂主題與支援部屬。',
      'strategy', '若您想提高開源專案或 SaaS 平台的文件品質,又不想手動編寫,可使用 Mintlify 節省時間並提升讀者體驗。',
      'inspiration', jsonb_build_array(
        '為 JavaScript 庫自動生成 API 文檔並托管於自己的網站。',
        '結合 ChatGPT 功能,將摘要翻譯為多語版本。',
        '同步文件變更至 GitHub,每次程式更新即自動更新文檔。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;

-- Tool 20: Zenler
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
    'Zenler',
    'zenler',
    'All-in-one platform for course creation, marketing, and hosting for educators and entrepreneurs.',
    jsonb_build_object(
      'purpose', jsonb_build_array('Application Oriented'),
      'functional_role', jsonb_build_array('Course Creation', 'Marketing', 'E-commerce'),
      'application_field', jsonb_build_array('Education', 'Online Business'),
      'tech_layer', jsonb_build_array('Frontend Layer', 'Integration Layer'),
      'data_flow_role', jsonb_build_array('Output', 'Storage'),
      'difficulty', 'No-code',
      'common_pairings', jsonb_build_array('Stripe', 'Mailchimp', 'Zapier')
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
    'Zenler 提供建立線上課程的全方位平台,結合課程製作、行銷、收款與社群功能。',
    jsonb_build_object(
      'encyclopedia', 'Zenler 提供建立線上課程的全方位平台,結合課程製作、行銷、收款與社群功能。',
      'guide', '教師與創業者可利用 Zenler 上傳影片、建立課程模組並設定銷售方案;並透過整合 Email 行銷和付款功能吸引學生。',
      'strategy', '若您想快速推出線上課程且需要專業行銷與付費管理功能,Zenler 提供從內容建立到銷售的完整解決方案。',
      'inspiration', jsonb_build_array(
        '建立線上學院,提供預錄與直播課程並收取費用。',
        '利用 Zenler 自動電子郵件、漏斗行銷吸引新學生。',
        '結合社群社區功能,提升學生參與度。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;

-- Tool 21: Replicate
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
    'Replicate',
    'replicate',
    'Platform for hosting and running machine learning models in the cloud via simple API calls.',
    jsonb_build_object(
      'purpose', jsonb_build_array('Application Oriented', 'System Oriented'),
      'functional_role', jsonb_build_array('AI Models', 'Deployment'),
      'application_field', jsonb_build_array('Machine Learning', 'Prototyping'),
      'tech_layer', jsonb_build_array('AI Layer', 'Processing Layer'),
      'data_flow_role', jsonb_build_array('Processing', 'Output'),
      'difficulty', 'Low-code',
      'common_pairings', jsonb_build_array('Python', 'Gradio', 'Hugging Face')
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
    'Replicate 是一個雲端平台,使用者可以迅速部署並呼叫各類 AI 模型作為 API,支援圖片生成、語言模型等。',
    jsonb_build_object(
      'encyclopedia', 'Replicate 是一個雲端平台,使用者可以迅速部署並呼叫各類 AI 模型作為 API,支援圖片生成、語言模型等。',
      'guide', '用戶只需透過 API 傳入輸入資料即可獲取模型輸出結果;同時可將自己的模型封裝發布,供他人使用。',
      'strategy', '若需要快速在產品中測試不同的 AI 模型,或是公開自己的模型供他人使用,Replicate 提供了簡易且可擴展的環境。',
      'inspiration', jsonb_build_array(
        '為網頁加入圖片生成功能,透過 Replicate 的 Stable Diffusion 模型 API 呼叫。',
        '將實驗模型部署到 Replicate,提供團隊測試接口。',
        '結合 Gradio 架設簡易介面,供使用者互動體驗 AI 功能。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;

-- Tool 22: Daloopa
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
    'Daloopa',
    'daloopa',
    'AI-driven data extraction and transcription tool for financial documents and calls.',
    jsonb_build_object(
      'purpose', jsonb_build_array('Application Oriented'),
      'functional_role', jsonb_build_array('Data Extraction', 'Transcription'),
      'application_field', jsonb_build_array('Finance', 'Research'),
      'tech_layer', jsonb_build_array('Processing Layer'),
      'data_flow_role', jsonb_build_array('Input', 'Processing'),
      'difficulty', 'No-code',
      'common_pairings', jsonb_build_array('Excel', 'Bloomberg', 'Python')
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
    'Daloopa 提供自動資料提取與逐字稿服務,特別針對財務報表與公司業績電話會議。',
    jsonb_build_object(
      'encyclopedia', 'Daloopa 提供自動資料提取與逐字稿服務,特別針對財務報表與公司業績電話會議。',
      'guide', '投資研究者可使用 Daloopa 將數百頁的財報自動解析為結構化資料表,或快速取得企業電話會議的逐字稿。',
      'strategy', '當分析大量財務資料並需要高精度提取時,可使用 Daloopa 提升效率,減少手動輸入,並配合 Excel 或 BI 工具分析。',
      'inspiration', jsonb_build_array(
        '自動收集上市公司財務報表並輸出為 Excel 供分析。',
        '生成多家公司季度會議記錄的逐字稿,建立詞頻分析。',
        '整合 Daloopa 與投資研究平台,加快研究速度。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;