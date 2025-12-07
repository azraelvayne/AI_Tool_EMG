/*
  # Import 30 New Tools - Batch 2 (Tools 6-10)

  Continuing import with:
  - BrightData: Web scraping proxy
  - ScrapingBee: Headless browser scraping
  - Phantombuster: Social media automation
  - Thunderbit: No-code automation
  - Miro: Visual collaboration
*/

-- Tool 6: BrightData
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
    'BrightData',
    'brightdata',
    'Web data collection platform providing proxy networks and scraping tools for large-scale crawling.',
    jsonb_build_object(
      'purpose', jsonb_build_array('Application Oriented'),
      'functional_role', jsonb_build_array('Data Collection', 'Scraping'),
      'application_field', jsonb_build_array('Market Research', 'Competitive Intelligence'),
      'tech_layer', jsonb_build_array('Processing Layer'),
      'data_flow_role', jsonb_build_array('Input'),
      'difficulty', 'Low-code',
      'common_pairings', jsonb_build_array('Python', 'ScrapingBee', 'Proxy Server')
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
    'BrightData (原名 Luminati) 提供全球性的代理網路和資料收集服務,適合進行大規模網路資料抓取。',
    jsonb_build_object(
      'encyclopedia', 'BrightData (原名 Luminati) 提供全球性的代理網路和資料收集服務,適合進行大規模網路資料抓取。',
      'guide', '使用 BrightData 可以取得住宅 IP 代理並進行高效資料抓取,也提供 API 和自動化工具。必須注意合法使用並遵守網站政策。',
      'strategy', '當需要收集市場資訊、大型電商價格或其他公開資料時,可以利用 BrightData 的代理網路避免封鎖,並透過自動化程式整理資料。',
      'inspiration', jsonb_build_array(
        '監測多國電子商務網站價格,更新商業分析儀表。',
        '結合自製爬蟲程式,使用 BrightData 的住宅代理提升抓取成功率。',
        '建立競品監測平台,每日收集公開資訊並生成報表。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;

-- Tool 7: ScrapingBee
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
    'ScrapingBee',
    'scrapingbee',
    'Headless browser scraping API to extract data from websites with support for rendering JavaScript.',
    jsonb_build_object(
      'purpose', jsonb_build_array('Application Oriented'),
      'functional_role', jsonb_build_array('Data Collection', 'Scraping'),
      'application_field', jsonb_build_array('Market Research', 'Lead Generation'),
      'tech_layer', jsonb_build_array('Processing Layer'),
      'data_flow_role', jsonb_build_array('Input'),
      'difficulty', 'Low-code',
      'common_pairings', jsonb_build_array('BrightData', 'Pandas', 'n8n')
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
    'ScrapingBee 提供簡單的 API,可執行無頭瀏覽器抓取網頁資料,支援渲染 JavaScript。',
    jsonb_build_object(
      'encyclopedia', 'ScrapingBee 提供簡單的 API,可執行無頭瀏覽器抓取網頁資料,支援渲染 JavaScript。',
      'guide', '透過 ScrapingBee API,只需傳入目標網址,就能取得解析後的 HTML 或 JSON,適合沒有複雜爬蟲框架的使用者。',
      'strategy', '若想快速抓取需要 JavaScript 渲染才能取得的資料,可以使用 ScrapingBee,結合代理服務或自動化流程節省開發時間。',
      'inspiration', jsonb_build_array(
        '搭配 n8n 自動化,批次抓取熱門新聞並分析內容趨勢。',
        '使用 ScrapingBee API 抓取外部網站的評論資料,生成競品分析。',
        '與 BrightData 代理結合,突破網站防爬限制。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;

-- Tool 8: Phantombuster
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
    'Phantombuster',
    'phantombuster',
    'Automation and data extraction platform for social media and web platforms.',
    jsonb_build_object(
      'purpose', jsonb_build_array('Application Oriented'),
      'functional_role', jsonb_build_array('Automation', 'Scraping'),
      'application_field', jsonb_build_array('Lead Generation', 'Marketing', 'Social Media'),
      'tech_layer', jsonb_build_array('Processing Layer'),
      'data_flow_role', jsonb_build_array('Input', 'Output'),
      'difficulty', 'No-code',
      'common_pairings', jsonb_build_array('LinkedIn', 'Salesforce', 'n8n')
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
    'Phantombuster 提供一系列無須程式碼的 API 器和自動化模組,幫助使用者在社交平台和網站上抓取資料、發送訊息或執行其他操作。',
    jsonb_build_object(
      'encyclopedia', 'Phantombuster 提供一系列無須程式碼的 API 器和自動化模組,幫助使用者在社交平台和網站上抓取資料、發送訊息或執行其他操作。',
      'guide', '在行銷和業務開發場景中,可利用 Phantombuster 收集潛在客戶名單,自動化重複操作,如在 LinkedIn 傳送邀請或抓取職業資訊。',
      'strategy', '若需要批次收集社群資料或自動執行登入操作,Phantombuster 提供的現成功能可省去自建爬蟲時間,但需留意平台政策。',
      'inspiration', jsonb_build_array(
        '自動抓取 LinkedIn 名單並匯入 CRM,管理商機。',
        '在 Twitter/Facebook 等社群媒體上追蹤特定主題並收集貼文資料。',
        '使用 Phantombuster 自動發送邀請與關注,配合後續郵件行銷。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;

-- Tool 9: Thunderbit
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
    'Thunderbit',
    'thunderbit',
    'No-code automation and integration platform for building simple workflows.',
    jsonb_build_object(
      'purpose', jsonb_build_array('Application Oriented'),
      'functional_role', jsonb_build_array('Automation', 'Integration'),
      'application_field', jsonb_build_array('Marketing Automation', 'Productivity'),
      'tech_layer', jsonb_build_array('Integration Layer'),
      'data_flow_role', jsonb_build_array('Input', 'Output'),
      'difficulty', 'No-code',
      'common_pairings', jsonb_build_array('Google Sheets', 'Slack', 'Trello')
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
    'Thunderbit 是一款簡易的無程式碼自動化工具,提供大量預設流程和整合,讓非技術使用者構建自動工作流。',
    jsonb_build_object(
      'encyclopedia', 'Thunderbit 是一款簡易的無程式碼自動化工具,提供大量預設流程和整合,讓非技術使用者構建自動工作流。',
      'guide', '使用 Thunderbit,可以直接拖拉元件來自動化常見任務,如同步表單資料到試算表、通知 Slack 等,不需寫程式。',
      'strategy', '適合中小企業或個人快速建置簡易自動化流程,不想使用功能複雜的自動化平台時,Thunderbit 提供親民的替代方案。',
      'inspiration', jsonb_build_array(
        '當客戶填寫表單時,自動在 Trello 建立任務並通知團隊。',
        '定期收集 Google Sheets 資料,發送至行銷平台。',
        '在 Slack 中自動推播來自 CRM 的狀態更新。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;

-- Tool 10: Miro
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
    'Miro',
    'miro',
    'Visual collaboration platform for brainstorming, diagramming, and project planning.',
    jsonb_build_object(
      'purpose', jsonb_build_array('Learning Oriented', 'Application Oriented'),
      'functional_role', jsonb_build_array('Collaboration', 'Visualization'),
      'application_field', jsonb_build_array('UX Design', 'Project Management', 'Education'),
      'tech_layer', jsonb_build_array('Frontend Layer'),
      'data_flow_role', jsonb_build_array('Input', 'Output'),
      'difficulty', 'No-code',
      'common_pairings', jsonb_build_array('Figma', 'Jira', 'Slack')
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
    'Miro 是一個線上白板平台,適合團隊共同協作、構思和規劃專案,支援無程式碼互動。',
    jsonb_build_object(
      'encyclopedia', 'Miro 是一個線上白板平台,適合團隊共同協作、構思和規劃專案,支援無程式碼互動。',
      'guide', '在工作坊、設計衝刺或專案規劃中,可使用 Miro 建立看板、流程圖及貼便簽,並與 Figma、Jira 等工具整合。',
      'strategy', '適合跨團隊線上協作與視覺化流程,例如遠距團隊進行設計評審時,可用 Miro 統一意見,並同步更新至管理工具。',
      'inspiration', jsonb_build_array(
        '在 Miro 上啟動設計衝刺工作坊,利用貼便簽與投票功能集思廣益。',
        '建立產品路線圖並連結 Jira 任務,提升透明度。',
        '與 Figma 結合,將 UI 草圖直接貼至白板討論。'
      )
    )
  )
  ON CONFLICT (tool_id, language_code) DO UPDATE
  SET summary = EXCLUDED.summary,
      description_styles = EXCLUDED.description_styles;
END $$;