/*
# Add AI agent and coding tools, plus three inspiration scenarios

1. New Rows
- `tools`: Hermes Agent, Claude Code, OpenAI Codex, OpenCode, Cline, Pi Coding Agent, Aider, Free Claude Code (FCC).
- `tool_stacks`: three tool groups that connect the new tools to the inspiration scenarios.
- `inspirations`: three scenarios (AI coding agent website build, Hermes + MCP research pipeline, multi-agent collaboration).

2. Existing Data
- No existing rows are changed or deleted.
- Inserts skip any row whose unique key already exists, so the migration is safe to re-run.

3. Security
- No table structure, row level security, or grant changes.
*/

INSERT INTO tools (tool_name, summary, categories, description_styles, use_case_templates, tags, url, free_tier_info, icon_url, generation_source, display_priority, is_curated, status)
VALUES
(
  'Hermes Agent',
  '由 Nous Research 開發的開源 AI 代理，可長時間運行並記住學習內容，支援排程與多種即時通訊平台。',
  '{"purpose":["Application Oriented","System Oriented"],"difficulty":"Developer","tech_layer":["AI Layer","Integration Layer"],"data_flow_role":["Processing"],"common_pairings":["Claude Code","OpenCode"],"functional_role":["Automation","AI Assistant"],"application_field":["AI Agent","Automation","Research"]}'::jsonb,
  '{"encyclopedia":"Hermes Agent 是 Nous Research 於 2026 年推出的開源 AI 代理，採 MIT 授權。它可部署在伺服器或個人電腦上，保留跨次對話的記憶，支援排程任務，並可透過 Telegram、Slack、Discord 等平台與使用者互動。","guide":"適合想建立長時間運作、可自動執行任務的 AI 代理的開發者與研究者。可先在本機安裝並測試基本對話，再逐步加入排程任務與 MCP 工具。","strategy":"當你需要的不只是單次寫程式，而是持續運作的研究、監控或報告流程時，Hermes Agent 比一般編碼助手更適合。建議先從單一任務開始，確認記憶與排程行為符合預期後再擴大使用。","inspiration":["每天自動收集指定主題的資料，整理成摘要並傳送到 Telegram","透過 MCP 連接外部資料來源，建立定期的競品觀察報告","在伺服器上常駐運作，接收團隊訊息後自動執行開發或文件整理任務"]}'::jsonb,
  '[]'::jsonb,
  ARRAY['AI Agent','Open Source','MCP','Automation','Scheduling'],
  'https://github.com/NousResearch/hermes-agent',
  '{}'::jsonb,
  '',
  'manual',
  50,
  false,
  'published'
),
(
  'Claude Code',
  'Anthropic 推出的終端機 AI 程式助手，可讀取專案、修改檔案並執行指令，協助完成開發任務。',
  '{"purpose":["Application Oriented"],"difficulty":"Developer","tech_layer":["AI Layer","Processing Layer"],"data_flow_role":["Processing","Output"],"common_pairings":["Hermes Agent","Free Claude Code (FCC)"],"functional_role":["Code Assistant","AI Assistant"],"application_field":["Software Development","AI Applications"]}'::jsonb,
  '{"encyclopedia":"Claude Code 是 Anthropic 官方推出的 AI 程式助手，在終端機或 IDE 中運作。它能理解整個專案的程式碼、規劃修改步驟、編輯檔案並執行測試指令，適合從功能開發到除錯的各種任務。","guide":"適合需要在既有專案中快速實作、重構或除錯的開發者。建議先描述清楚目標與限制，讓它逐步執行並檢查每次修改的結果。","strategy":"Claude Code 適合需要大範圍理解程式碼與多步驟修改的工作。搭配清楚的任務說明與測試流程，能有效降低來回修正的成本。","inspiration":["依照需求描述，從零建立一個完整的網站或小型應用","替舊專案補上測試並修復既有錯誤","閱讀陌生的程式庫後，撰寫說明文件與使用範例"]}'::jsonb,
  '[]'::jsonb,
  ARRAY['Coding Agent','Terminal','Anthropic','Code Generation','Refactoring'],
  'https://code.claude.com/docs/en/overview',
  '{}'::jsonb,
  '',
  'manual',
  50,
  false,
  'published'
),
(
  'OpenAI Codex',
  'OpenAI 的開源程式代理，可在終端機中閱讀程式碼、執行指令並協助完成開發任務。',
  '{"purpose":["Application Oriented"],"difficulty":"Developer","tech_layer":["AI Layer","Processing Layer"],"data_flow_role":["Processing","Output"],"common_pairings":["Claude Code","Aider"],"functional_role":["Code Assistant","AI Assistant"],"application_field":["Software Development","Developer Tools"]}'::jsonb,
  '{"encyclopedia":"Codex 是 OpenAI 的程式代理專案，可在本機終端機中運作，讀取專案內容、提出修改並執行命令。它採開源形式釋出，也可與 OpenAI 的模型與帳號方案搭配使用。","guide":"適合熟悉終端機、希望以命令列完成程式修改與測試的開發者。建議在版本控制下使用，方便檢視與還原每次變更。","strategy":"Codex 適合重視可追蹤修改與審查流程的團隊。先用小型任務熟悉它的權限與操作方式，再處理較大的重構工作。","inspiration":["根據需求單自動修正測試失敗的項目","在新功能分支中完成模組化重構，再交給人工審查","為命令列工具補上參數說明與使用範例"]}'::jsonb,
  '[]'::jsonb,
  ARRAY['Coding Agent','Terminal','OpenAI','Open Source','Code Review'],
  'https://github.com/openai/codex',
  '{}'::jsonb,
  '',
  'manual',
  50,
  false,
  'published'
),
(
  'OpenCode',
  '開源的終端機 AI 程式助手，支援多種模型供應商，可在專案中規劃、修改與測試程式碼。',
  '{"purpose":["Application Oriented"],"difficulty":"Developer","tech_layer":["AI Layer","Processing Layer"],"data_flow_role":["Processing","Output"],"common_pairings":["Hermes Agent","Free Claude Code (FCC)"],"functional_role":["Code Assistant","AI Assistant"],"application_field":["Software Development","Developer Tools"]}'::jsonb,
  '{"encyclopedia":"OpenCode 是開源的 AI 程式助手，提供終端機介面，並可連接多種大型語言模型供應商。使用者可依需求切換模型，並在專案目錄中完成閱讀、修改與執行指令等工作。","guide":"適合希望保留模型選擇彈性、不想綁定單一供應商的開發者。安裝後可在專案資料夾中啟動，並用清楚的任務描述逐步完成修改。","strategy":"當團隊需要比較不同模型的表現，或要控制成本與供應商依賴時，OpenCode 的多模型設計很有幫助。建議先建立固定的測試任務來比較結果。","inspiration":["同一個重構任務分別交給兩個模型執行，比較修改品質","在本機專案中快速建立 API 串接範例","透過開源設定檔統一團隊的程式助手環境"]}'::jsonb,
  '[]'::jsonb,
  ARRAY['Coding Agent','Terminal','Open Source','Multi-model'],
  'https://opencode.ai',
  '{}'::jsonb,
  '',
  'manual',
  50,
  false,
  'published'
),
(
  'Cline',
  '開源的 VS Code 擴充功能 AI 代理，可規劃任務、讀寫檔案、執行終端機指令，並在每一步請求確認。',
  '{"purpose":["Application Oriented"],"difficulty":"Low-code","tech_layer":["AI Layer","Frontend Layer"],"data_flow_role":["Processing","Output"],"common_pairings":["Claude Code","OpenAI Codex"],"functional_role":["Code Assistant","AI Assistant"],"application_field":["Software Development","Developer Tools"]}'::jsonb,
  '{"encyclopedia":"Cline 是開源的 AI 程式代理，以 VS Code 擴充功能形式運作。它會先規劃任務，再依使用者確認逐步修改檔案或執行指令，並可連接多種模型供應商。","guide":"適合習慣在 VS Code 內工作、希望看到每個步驟並保有控制權的使用者。建議先用小任務觀察它的規劃方式，再決定哪些操作可以自動允許。","strategy":"Cline 適合需要透明度與逐步確認的情境，尤其是初次讓 AI 代理接觸既有專案時。可搭配版本控制，讓每次修改都容易比較與還原。","inspiration":["在 VS Code 中依需求描述建立前端頁面原型","讓代理閱讀錯誤紀錄並提出修正方案","逐步完成既有功能的文件補充與測試撰寫"]}'::jsonb,
  '[]'::jsonb,
  ARRAY['Coding Agent','VS Code','Open Source','Human in the Loop'],
  'https://cline.bot',
  '{}'::jsonb,
  '',
  'manual',
  50,
  false,
  'published'
),
(
  'Pi Coding Agent',
  '極簡的終端機程式代理框架，以四個基本工具為核心，可透過擴充功能與技能依個人流程自行客製化。',
  '{"purpose":["Application Oriented","Learning Oriented"],"difficulty":"Developer","tech_layer":["AI Layer","Processing Layer"],"data_flow_role":["Processing"],"common_pairings":["Hermes Agent","OpenCode"],"functional_role":["Code Assistant","Development Environment"],"application_field":["Software Development","Developer Tools"]}'::jsonb,
  '{"encyclopedia":"Pi 是由 Mario Zechner 開發的極簡終端機程式代理框架，採 MIT 授權，官方網站為 pi.dev。核心只提供讀取、寫入、編輯與執行指令四個工具，其他功能可透過擴充套件、技能與提示範本加入。","guide":"適合喜歡精簡工具、希望自己決定功能與流程的開發者。建議先熟悉基本操作，再依工作需求安裝或撰寫擴充功能。","strategy":"如果你偏好從最小核心開始，逐步建立自己的代理工作流程，Pi 會比功能齊全的編碼助手更有彈性。適合做為研究代理架構或客製化工具的起點。","inspiration":["撰寫一個自訂擴充功能，讓代理自動執行專案的測試流程","把常用的程式審查步驟整理成可重複使用的技能","以列印模式把代理串接進既有的 Shell 腳本"]}'::jsonb,
  '[]'::jsonb,
  ARRAY['Coding Agent','Terminal','Open Source','Extensible','Minimal'],
  'https://pi.dev',
  '{}'::jsonb,
  '',
  'manual',
  50,
  false,
  'published'
),
(
  'Aider',
  '在終端機中與 AI 結對編程的開源工具，會直接修改本機程式檔並自動建立 Git 提交紀錄。',
  '{"purpose":["Application Oriented"],"difficulty":"Developer","tech_layer":["AI Layer","Processing Layer"],"data_flow_role":["Processing","Output"],"common_pairings":["OpenAI Codex","Claude Code"],"functional_role":["Code Assistant","AI Assistant"],"application_field":["Software Development","Developer Tools"]}'::jsonb,
  '{"encyclopedia":"Aider 是開源的終端機 AI 結對編程工具，可連接多種大型語言模型。它會讀取指定的檔案，套用修改並以 Git 記錄每次變更，方便檢視與回復。","guide":"適合已經使用 Git 管理專案、想用對話方式逐步修改程式的開發者。建議每次只加入需要的檔案，讓模型聚焦在相關範圍。","strategy":"Aider 的優勢在於修改透明且容易回復。適合用於功能調整、小型重構與測試補強，大型變更則建議拆成數個小任務。","inspiration":["用自然語言描述需求，直接在既有專案中新增一個功能","依照錯誤訊息逐步修正測試，並保留每次提交紀錄","為舊程式補上註解與型別標註"]}'::jsonb,
  '[]'::jsonb,
  ARRAY['Coding Agent','Terminal','Open Source','Git','Pair Programming'],
  'https://aider.chat',
  '{}'::jsonb,
  '',
  'manual',
  50,
  false,
  'published'
),
(
  'Free Claude Code (FCC)',
  '獨立的第三方開源專案，可讓 Claude Code、Codex、Pi、OpenCode、Cline、Hermes、Aider 等多種程式代理透過同一個服務連接不同模型供應商。',
  '{"purpose":["System Oriented","Application Oriented"],"difficulty":"Developer","tech_layer":["Integration Layer","AI Layer"],"data_flow_role":["Input","Processing"],"common_pairings":["Claude Code","Pi Coding Agent","Hermes Agent"],"functional_role":["API Gateway","Integration"],"application_field":["Developer Tools","AI Applications"]}'::jsonb,
  '{"encyclopedia":"Free Claude Code（FCC）是獨立的開源專案，採 AGPL-3.0 授權，與 Anthropic 無隸屬關係。它在本機提供代理服務，讓多種程式代理可以路由到不同模型供應商，並提供管理介面與多種整合方式。","guide":"適合想比較不同模型、測試各種供應商免費或試用額度，或希望在多個程式代理間共用同一組模型設定的開發者。使用前請自行確認各供應商的服務條款與費用。","strategy":"FCC 適合需要彈性切換模型與降低單一供應商依賴的團隊。由於它是第三方專案，建議先在非正式專案中測試，並留意模型供應商的使用限制。","inspiration":["在 Claude Code 中切換到另一家供應商的模型，比較修改結果","讓 Hermes Agent 與 Pi 共用同一組模型設定","依任務難度為不同代理指定適合的模型"]}'::jsonb,
  '[]'::jsonb,
  ARRAY['Open Source','Model Routing','Third-party','Multi-model','Coding Agent'],
  'https://github.com/Alishahryar1/free-claude-code',
  '{}'::jsonb,
  '',
  'manual',
  50,
  false,
  'published'
)
ON CONFLICT (tool_name) DO NOTHING;

INSERT INTO tool_stacks (stack_key, name_en, name_zh_tw, description_en, description_zh_tw, difficulty, tool_ids, flow_map, diagram_url, integration_method, setup_complexity, estimated_time)
VALUES
(
  'ai-coding-agent-website',
  'AI Coding Agent Website Build',
  'AI 程式代理開發網站',
  'Use a terminal coding agent to plan, build and verify a website.',
  '使用終端機程式代理規劃、建置並驗證一個網站。',
  'beginner',
  jsonb_build_array(
    (SELECT id::text FROM tools WHERE tool_name = 'Claude Code'),
    (SELECT id::text FROM tools WHERE tool_name = 'Cline'),
    (SELECT id::text FROM tools WHERE tool_name = 'Aider')
  ),
  'Describe the goal -> agent plans -> agent edits files -> run and review -> iterate',
  '',
  'Terminal or VS Code',
  'low',
  '1-2 hours'
),
(
  'hermes-mcp-research-pipeline',
  'Hermes and MCP Research Pipeline',
  'Hermes 與 MCP 定期研究流程',
  'Schedule a long-running agent to collect, summarize and report research on a recurring basis.',
  '讓常駐代理依排程收集、整理並回報研究資料。',
  'intermediate',
  jsonb_build_array(
    (SELECT id::text FROM tools WHERE tool_name = 'Hermes Agent'),
    (SELECT id::text FROM tools WHERE tool_name = 'Pi Coding Agent')
  ),
  'Schedule -> agent calls MCP sources -> summarize -> store notes -> send report',
  '',
  'Server with scheduled tasks and MCP servers',
  'medium',
  '2-4 hours'
),
(
  'multi-agent-collaboration',
  'Multi-agent Collaboration',
  '多代理協作完成複雜工作',
  'Split a complex project across several coding agents and merge their results.',
  '將複雜專案拆分給多個程式代理處理，最後整合結果。',
  'advanced',
  jsonb_build_array(
    (SELECT id::text FROM tools WHERE tool_name = 'OpenAI Codex'),
    (SELECT id::text FROM tools WHERE tool_name = 'Claude Code'),
    (SELECT id::text FROM tools WHERE tool_name = 'OpenCode'),
    (SELECT id::text FROM tools WHERE tool_name = 'Free Claude Code (FCC)')
  ),
  'Plan -> split tasks -> parallel agents -> review -> merge -> test',
  '',
  'Multiple terminals with Git branches',
  'high',
  '1-2 days'
)
ON CONFLICT (stack_key) DO NOTHING;

INSERT INTO inspirations (inspiration_key, title_en, title_zh_tw, description_en, description_zh_tw, stack_id, difficulty, steps, estimated_time, learning_focus, expected_skills, resource_links, outcome_demo, visual_hint, display_order)
VALUES
(
  'ai-coding-agent-website',
  'Build a Website with an AI Coding Agent',
  '利用 AI 程式代理開發網站',
  'Describe a website in plain language and let a coding agent build, test and refine it step by step.',
  '用一般語言描述網站需求，讓程式代理逐步建置、測試並修改網站。',
  (SELECT id FROM tool_stacks WHERE stack_key = 'ai-coding-agent-website'),
  'beginner',
  '["Write a short brief: audience, pages and key actions","Ask the agent to propose a plan before editing any file","Let it build the first page and run the project locally","Review each change, ask for fixes, and keep the good versions in Git","Finish with a checklist for content, mobile layout and links"]'::jsonb,
  '1-2 hours',
  '["Writing clear project briefs","Reviewing AI-generated code","Iterating with small changes"]'::jsonb,
  '["Basic web concepts","A terminal or VS Code","A Git account for saving versions"]'::jsonb,
  '[{"name":"Claude Code documentation","url":"https://code.claude.com/docs/en/overview"},{"name":"Cline","url":"https://cline.bot"}]'::jsonb,
  'A working multi-page website built from one written brief.',
  'Terminal window beside a browser preview.',
  1
),
(
  'hermes-mcp-research-pipeline',
  'Scheduled Research with Hermes and MCP',
  '使用 Hermes 與 MCP 建立定期資料研究流程',
  'Set up a long-running agent that gathers sources through MCP, summarizes findings and reports on a schedule.',
  '建立常駐代理，透過 MCP 收集資料來源、整理重點，並依排程產生報告。',
  (SELECT id FROM tool_stacks WHERE stack_key = 'hermes-mcp-research-pipeline'),
  'intermediate',
  '["Install Hermes Agent on a server or local machine and confirm a basic chat works","Connect one MCP data source and test a single lookup","Write a research brief with topics, sources and report format","Create a scheduled task that runs the brief every day or week","Review the first two reports and tighten the instructions"]'::jsonb,
  '2-4 hours',
  '["Scheduling automated tasks","Connecting MCP tools","Checking AI research quality"]'::jsonb,
  '["Command line basics","Understanding of API keys and permissions","Reading simple configuration files"]'::jsonb,
  '[{"name":"Hermes Agent on GitHub","url":"https://github.com/NousResearch/hermes-agent"},{"name":"Hermes Agent documentation","url":"https://hermes-agent.nousresearch.com/docs"}]'::jsonb,
  'A recurring report that summarizes new sources on a fixed schedule.',
  'Calendar-style schedule feeding into a written report.',
  2
),
(
  'multi-agent-collaboration',
  'Multi-agent Collaboration for Complex Work',
  '使用多代理協作完成複雜工作',
  'Divide a large project between several coding agents, run them in parallel and merge the results with review.',
  '將大型專案分派給多個程式代理並行處理，再經審查後整合。',
  (SELECT id FROM tool_stacks WHERE stack_key = 'multi-agent-collaboration'),
  'advanced',
  '["Write a project spec and split it into independent tasks","Assign each task to a different agent on its own Git branch","Run the agents in parallel and collect their change summaries","Review each branch and resolve conflicts manually","Merge the approved branches and run the full test suite"]'::jsonb,
  '1-2 days',
  '["Task decomposition","Parallel workflows","Code review and merging"]'::jsonb,
  '["Git branching and merging","Reading and testing code","Writing clear task specifications"]'::jsonb,
  '[{"name":"Free Claude Code (FCC)","url":"https://github.com/Alishahryar1/free-claude-code"},{"name":"OpenAI Codex","url":"https://github.com/openai/codex"}]'::jsonb,
  'A larger feature completed by several agents and merged after review.',
  'Several terminal panes converging into one branch.',
  3
)
ON CONFLICT (inspiration_key) DO NOTHING;
