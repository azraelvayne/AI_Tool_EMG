import * as fs from 'fs';
import * as path from 'path';
import { fileURLToPath } from 'url';
import { dirname } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

interface ToolCSV {
  id: string;
  name_zh: string;
  name_en: string;
  category_zh: string;
  description_zh: string;
  description_en: string;
}

interface ToolPairing {
  tool_1_id: string;
  tool_2_id: string;
  tool_1_name: string;
  tool_2_name: string;
  relationship_type: 'integrates_with' | 'complements' | 'alternative_to';
  strength: number;
  rationale: string;
  example_workflow_slug?: string;
}

const parseCSV = (csvContent: string): ToolCSV[] => {
  const lines = csvContent.split('\n').filter(line => line.trim());
  const headers = lines[0].split(',');

  return lines.slice(1).map(line => {
    const values = line.split(',');
    return {
      id: values[0],
      name_zh: values[1],
      name_en: values[2],
      category_zh: values[3],
      description_zh: values[4],
      description_en: values[5]
    };
  });
};

const generatePairings = (tools: ToolCSV[]): ToolPairing[] => {
  const pairings: ToolPairing[] = [];

  // AI Models
  const aiModels = tools.filter(t => t.category_zh === 'AI/LLM');
  const automation = tools.filter(t => t.category_zh === '自動化');
  const llmOrchestration = tools.filter(t => t.category_zh === 'LLM 編排');
  const databases = tools.filter(t => t.category_zh.includes('資料庫'));
  const noCode = tools.filter(t => t.category_zh === '無程式建構');
  const projectMgmt = tools.filter(t => t.category_zh === '專案管理');
  const design = tools.filter(t => t.category_zh === '設計');

  // 1. AI Models + Automation Platforms (High Priority - 20 pairings)
  const aiAutomationPairs = [
    { ai: 'openai', auto: 'n8n', strength: 95, rationale: 'n8n 提供 OpenAI 官方節點，支援所有 GPT 模型（GPT-4、GPT-3.5）和功能（文字生成、嵌入向量、圖像生成）。完整支援串流回應和函數呼叫，是最常用的自動化整合方案之一。' },
    { ai: 'openai', auto: 'zapier', strength: 90, rationale: 'Zapier 提供 OpenAI 整合，可在 5000+ 個應用中使用 GPT 模型。常見場景包括自動回覆郵件、生成社群媒體內容、分析客戶回饋等，無需程式碼即可快速建立。' },
    { ai: 'openai', auto: 'make', strength: 88, rationale: 'Make (Integromat) 提供視覺化的 OpenAI 整合模組，支援文字生成、語音轉文字、圖像生成等功能。視覺化流程設計讓複雜的 AI 工作流程更容易理解和維護。' },
    { ai: 'openai', auto: 'pipedream', strength: 75, rationale: 'Pipedream 支援透過程式碼或預建模組使用 OpenAI API。適合開發者建立自訂的 AI 驅動工作流程，支援 Node.js、Python 等多種語言環境。' },
    { ai: 'anthropic', auto: 'n8n', strength: 85, rationale: 'n8n 支援 Anthropic Claude 整合，可使用 Claude 3 系列模型。Claude 以長上下文處理和安全性著稱，適合處理大量文件分析和複雜推理任務。' },
    { ai: 'anthropic', auto: 'zapier', strength: 80, rationale: 'Zapier 支援 Claude API 整合，讓使用者在自動化流程中使用 Claude 的對話能力。適合需要更安全、更可控的 AI 回應場景。' },
    { ai: 'google-gemini', auto: 'n8n', strength: 82, rationale: 'n8n 支援 Google Gemini 多模態模型，可同時處理文字和圖像輸入。Gemini Pro 提供強大的推理能力，且與 Google 生態系統整合良好。' },
    { ai: 'google-gemini', auto: 'make', strength: 78, rationale: 'Make 整合 Google Gemini API，支援文字生成和多模態處理。適合需要結合 Google Workspace（Gmail、Docs、Sheets）的自動化場景。' },
    { ai: 'cohere', auto: 'n8n', strength: 70, rationale: 'n8n 支援 Cohere API，專注於語意搜尋和文字分類任務。Cohere 的嵌入模型在檢索增強生成（RAG）場景中表現優異。' },
    { ai: 'mistral', auto: 'n8n', strength: 72, rationale: 'n8n 可透過 HTTP 請求整合 Mistral AI，提供高效的開源語言模型選擇。Mistral 模型在性能和成本之間取得良好平衡。' },
  ];

  aiAutomationPairs.forEach(pair => {
    const ai = tools.find(t => t.id === pair.ai);
    const auto = tools.find(t => t.id === pair.auto);
    if (ai && auto) {
      pairings.push({
        tool_1_id: pair.ai,
        tool_2_id: pair.auto,
        tool_1_name: ai.name_en,
        tool_2_name: auto.name_en,
        relationship_type: 'integrates_with',
        strength: pair.strength,
        rationale: pair.rationale
      });
    }
  });

  // 2. AI Models + LLM Orchestration (15 pairings)
  const aiOrchestrationPairs = [
    { ai: 'openai', orch: 'langflow', strength: 95, rationale: 'Langflow 原生支援 OpenAI 模型，提供拖放式介面建立 LLM 工作流程。可視覺化設計 prompt chain、記憶體管理和工具呼叫，是建立複雜 AI 代理的最佳選擇。' },
    { ai: 'openai', orch: 'flowise', strength: 93, rationale: 'Flowise 完整支援 OpenAI 所有模型和功能，包括 GPT-4 Vision、函數呼叫、助理 API。低程式碼介面讓非技術人員也能建立進階 AI 應用。' },
    { ai: 'openai', orch: 'dify', strength: 90, rationale: 'Dify.ai 提供完整的 OpenAI 整合，支援知識庫管理、提示詞編排和 AI 代理建立。內建向量資料庫和檢索功能，適合建立企業級 AI 應用。' },
    { ai: 'anthropic', orch: 'langflow', strength: 88, rationale: 'Langflow 支援 Claude 模型整合，可利用 Claude 的長上下文能力（100K tokens）建立進階工作流程。適合需要處理大量文件或長對話的應用場景。' },
    { ai: 'anthropic', orch: 'flowise', strength: 86, rationale: 'Flowise 整合 Anthropic Claude，提供視覺化介面設計對話流程。Claude 的安全性和可控性使其成為企業應用的理想選擇。' },
    { ai: 'anthropic', orch: 'dify', strength: 85, rationale: 'Dify 支援 Claude 模型，可建立安全可靠的 AI 助手和知識庫問答系統。適合需要高品質回應和嚴格內容控制的場景。' },
    { ai: 'google-gemini', orch: 'langflow', strength: 83, rationale: 'Langflow 整合 Google Gemini，支援多模態輸入處理。可同時處理文字和圖像，建立視覺問答和圖像分析工作流程。' },
    { ai: 'google-gemini', orch: 'flowise', strength: 80, rationale: 'Flowise 支援 Gemini Pro 模型，提供多模態 AI 應用建立能力。適合需要結合視覺理解和文字生成的場景。' },
    { ai: 'cohere', orch: 'langflow', strength: 75, rationale: 'Langflow 整合 Cohere 的語意搜尋和生成模型，特別適合建立 RAG（檢索增強生成）應用。Cohere 的嵌入模型在語意搜尋場景表現優異。' },
    { ai: 'huggingface', orch: 'langflow', strength: 85, rationale: 'Langflow 深度整合 Hugging Face 生態系統，可使用數千個開源模型。支援自訂模型部署和微調，提供最大的靈活性。' },
    { ai: 'huggingface', orch: 'flowise', strength: 82, rationale: 'Flowise 支援 Hugging Face Inference API，可輕鬆使用開源模型。適合需要成本控制或資料隱私的場景。' },
    { ai: 'ollama', orch: 'langflow', strength: 88, rationale: 'Langflow 整合 Ollama，可在本地運行 Llama、Mistral 等開源模型。完全離線運作，適合對資料安全有嚴格要求的企業環境。' },
    { ai: 'ollama', orch: 'flowise', strength: 86, rationale: 'Flowise 支援 Ollama 本地模型，無需 API 金鑰即可建立 AI 工作流程。適合開發測試和隱私敏感的應用場景。' },
    { ai: 'llamaindex', orch: 'langflow', strength: 80, rationale: 'LlamaIndex 與 Langflow 結合提供強大的文件檢索和問答能力。可建立基於企業知識庫的智能助手系統。' },
    { ai: 'llamaindex', orch: 'flowise', strength: 78, rationale: 'Flowise 整合 LlamaIndex 框架，簡化 RAG 應用建立流程。提供多種索引和檢索策略，優化問答品質。' },
  ];

  aiOrchestrationPairs.forEach(pair => {
    const ai = tools.find(t => t.id === pair.ai);
    const orch = tools.find(t => t.id === pair.orch);
    if (ai && orch) {
      pairings.push({
        tool_1_id: pair.ai,
        tool_2_id: pair.orch,
        tool_1_name: ai.name_en,
        tool_2_name: orch.name_en,
        relationship_type: 'integrates_with',
        strength: pair.strength,
        rationale: pair.rationale
      });
    }
  });

  // 3. Database + No-Code Platforms (12 pairings)
  const dbNoCodePairs = [
    { db: 'supabase', nc: 'n8n', strength: 92, rationale: 'n8n 提供 Supabase 官方節點，支援資料庫操作、即時訂閱和認證功能。可建立完整的後端自動化流程，包括資料同步、觸發器和 webhook 整合。' },
    { db: 'supabase', nc: 'bubble', strength: 85, rationale: 'Bubble.io 可透過 API 連接器整合 Supabase，作為強大的後端資料庫。Supabase 的即時功能和 Bubble 的前端設計能力結合，可快速建立全端應用。' },
    { db: 'supabase', nc: 'webflow', strength: 75, rationale: 'Webflow 網站可透過自訂程式碼整合 Supabase，實現動態內容和使用者認證。適合建立會員網站、內容平台和 SaaS 落地頁。' },
    { db: 'airtable', nc: 'softr', strength: 95, rationale: 'Softr 原生整合 Airtable，可直接將 Airtable 資料庫轉換為精美網站或應用。無需程式碼即可建立客戶入口、內部工具或內容管理系統。' },
    { db: 'airtable', nc: 'glide', strength: 93, rationale: 'Glide 完整支援 Airtable 作為資料來源，可快速建立行動應用。即時雙向同步確保資料一致性，適合團隊協作和行動化場景。' },
    { db: 'airtable', nc: 'webflow', strength: 78, rationale: 'Webflow 可透過 Airtable API 整合，實現動態內容管理。適合需要靈活資料結構的網站，如產品目錄、部落格或活動頁面。' },
    { db: 'airtable', nc: 'n8n', strength: 90, rationale: 'n8n 提供強大的 Airtable 整合，支援所有資料操作和自動化觸發。可建立複雜的資料處理流程，如表單回應處理、資料驗證和多平台同步。' },
    { db: 'airtable', nc: 'zapier', strength: 88, rationale: 'Zapier 與 Airtable 深度整合，提供豐富的觸發器和動作。最常用於連接 Airtable 與其他 SaaS 工具，實現無縫資料流動。' },
    { db: 'airtable', nc: 'make', strength: 87, rationale: 'Make 提供視覺化的 Airtable 整合，支援複雜的資料轉換和條件邏輯。適合需要進階資料處理和多步驟工作流程的場景。' },
    { db: 'notion', nc: 'n8n', strength: 88, rationale: 'n8n 整合 Notion API，可自動化頁面建立、資料庫更新和內容同步。常用於建立自動化知識管理系統和專案追蹤工作流程。' },
    { db: 'notion', nc: 'zapier', strength: 86, rationale: 'Zapier 支援 Notion 整合，可將其他工具的資料自動同步到 Notion 資料庫。適合建立個人生產力系統和團隊知識庫。' },
    { db: 'notion', nc: 'make', strength: 84, rationale: 'Make 提供 Notion 整合模組，支援複雜的頁面結構處理和資料庫操作。適合需要批次處理或進階資料轉換的場景。' },
  ];

  dbNoCodePairs.forEach(pair => {
    const db = tools.find(t => t.id === pair.db);
    const nc = tools.find(t => t.id === pair.nc);
    if (db && nc) {
      pairings.push({
        tool_1_id: pair.db,
        tool_2_id: pair.nc,
        tool_1_name: db.name_en,
        tool_2_name: nc.name_en,
        relationship_type: 'integrates_with',
        strength: pair.strength,
        rationale: pair.rationale
      });
    }
  });

  // 4. Automation + Project Management (10 pairings)
  const automationPMPairs = [
    { auto: 'n8n', pm: 'notion', strength: 90, rationale: 'n8n 與 Notion 的整合讓團隊可自動化任務建立、狀態更新和通知發送。常用於專案管理、CRM 系統和知識庫維護。' },
    { auto: 'zapier', pm: 'notion', strength: 88, rationale: 'Zapier 提供簡單的 Notion 自動化，可連接數千個應用。最常用於表單回應自動建立 Notion 頁面、郵件轉任務等場景。' },
    { auto: 'n8n', pm: 'monday', strength: 85, rationale: 'n8n 整合 Monday.com，可自動化專案追蹤和團隊協作流程。支援任務建立、狀態更新、時間追蹤和通知管理。' },
    { auto: 'zapier', pm: 'monday', strength: 87, rationale: 'Zapier 與 Monday.com 深度整合，提供豐富的自動化觸發器。常用於連接客戶支援、銷售和行銷工具，實現統一的專案管理。' },
    { auto: 'n8n', pm: 'clickup', strength: 83, rationale: 'n8n 支援 ClickUp API，可自動化任務管理、時間追蹤和文件同步。適合需要靈活自訂工作流程的團隊。' },
    { auto: 'zapier', pm: 'clickup', strength: 85, rationale: 'Zapier 整合 ClickUp，讓團隊可輕鬆連接 Gmail、Slack、Google Calendar 等工具，建立統一的工作中心。' },
    { auto: 'n8n', pm: 'jira', strength: 88, rationale: 'n8n 提供完整的 Jira 整合，支援議題管理、專案追蹤和自動化工作流程。適合軟體開發團隊的 DevOps 自動化。' },
    { auto: 'zapier', pm: 'jira', strength: 86, rationale: 'Zapier 與 Jira 整合，可自動化議題建立、狀態更新和通知發送。常用於連接客戶支援系統和開發追蹤工具。' },
    { auto: 'make', pm: 'trello', strength: 82, rationale: 'Make 提供視覺化的 Trello 自動化，支援卡片管理、清單操作和標籤分類。適合需要簡單看板管理的團隊。' },
    { auto: 'zapier', pm: 'trello', strength: 84, rationale: 'Zapier 整合 Trello，可自動化卡片建立和移動。常用於表單回應處理、郵件轉任務和社群媒體監控。' },
  ];

  automationPMPairs.forEach(pair => {
    const auto = tools.find(t => t.id === pair.auto);
    const pm = tools.find(t => t.id === pair.pm);
    if (auto && pm) {
      pairings.push({
        tool_1_id: pair.auto,
        tool_2_id: pair.pm,
        tool_1_name: auto.name_en,
        tool_2_name: pm.name_en,
        relationship_type: 'integrates_with',
        strength: pair.strength,
        rationale: pair.rationale
      });
    }
  });

  // 5. Design + No-Code (8 pairings)
  const designNoCodePairs = [
    { design: 'figma', nc: 'webflow', strength: 85, rationale: 'Figma 設計可透過插件或手動轉換到 Webflow。雖非完全自動化，但設計系統和元件可在兩平台間共享，加速網站開發流程。' },
    { design: 'figma', nc: 'bubble', strength: 75, rationale: 'Bubble 開發者常使用 Figma 進行 UI/UX 設計，再在 Bubble 中實作。Figma 的原型和設計規範有助於確保最終產品符合設計意圖。' },
    { design: 'canva', nc: 'webflow', strength: 70, rationale: 'Canva 生成的圖像和圖形可直接匯入 Webflow 網站。常用於建立橫幅、社群媒體圖片和行銷素材。' },
    { design: 'canva', nc: 'notion', strength: 65, rationale: 'Canva 設計可嵌入 Notion 頁面，增強文件視覺呈現。適合建立美觀的團隊文件、簡報和知識庫。' },
    { design: 'midjourney', nc: 'webflow', strength: 72, rationale: 'Midjourney 生成的 AI 圖像可用於 Webflow 網站設計。提供獨特的視覺內容，適合需要快速產出高品質圖像的專案。' },
    { design: 'midjourney', nc: 'canva', strength: 78, rationale: 'Midjourney 生成的圖像可匯入 Canva 進行後製和排版。兩者結合可快速產出專業級的視覺設計作品。' },
    { design: 'figma', nc: 'retool', strength: 80, rationale: 'Retool 開發者使用 Figma 設計內部工具介面，確保使用者體驗一致性。Figma 的設計規範和元件庫可指導 Retool 應用開發。' },
    { design: 'canva', nc: 'bubble', strength: 68, rationale: 'Bubble 應用可使用 Canva 生成的圖像素材，包括按鈕、圖示和背景。簡化設計流程，無需專業設計師即可建立美觀介面。' },
  ];

  designNoCodePairs.forEach(pair => {
    const design = tools.find(t => t.id === pair.design);
    const nc = tools.find(t => t.id === pair.nc);
    if (design && nc) {
      pairings.push({
        tool_1_id: pair.design,
        tool_2_id: pair.nc,
        tool_1_name: design.name_en,
        tool_2_name: nc.name_en,
        relationship_type: 'complements',
        strength: pair.strength,
        rationale: pair.rationale
      });
    }
  });

  // 6. Additional complementary pairs (8 pairings)
  const additionalPairs = [
    { t1: 'langflow', t2: 'flowise', strength: 70, type: 'alternative_to', rationale: 'Langflow 和 Flowise 都是低程式碼 LLM 編排工具，功能相似。Langflow 更適合開發者，提供更多自訂選項；Flowise 介面更友善，適合非技術使用者。' },
    { t1: 'n8n', t2: 'zapier', strength: 75, type: 'alternative_to', rationale: 'n8n 和 Zapier 都是自動化平台。n8n 開源且可自主託管，提供更多彈性和隱私控制；Zapier 更易用且整合更多，但成本較高。' },
    { t1: 'n8n', t2: 'make', strength: 72, type: 'alternative_to', rationale: 'n8n 和 Make 都提供視覺化工作流程編排。n8n 開源且程式碼優先；Make 視覺化更強，適合複雜的資料轉換場景。' },
    { t1: 'bubble', t2: 'webflow', strength: 68, type: 'alternative_to', rationale: 'Bubble 和 Webflow 都是無程式碼網站建構工具。Bubble 更適合建立複雜的 Web 應用和 SaaS；Webflow 專注於視覺設計和內容網站。' },
    { t1: 'supabase', t2: 'airtable', strength: 65, type: 'alternative_to', rationale: 'Supabase 和 Airtable 都提供資料庫功能。Supabase 是傳統關聯式資料庫，適合開發者；Airtable 結合試算表介面，適合非技術團隊。' },
    { t1: 'openai', t2: 'anthropic', strength: 85, type: 'alternative_to', rationale: 'OpenAI GPT 和 Anthropic Claude 都是頂尖語言模型。GPT-4 功能更全面且生態系統豐富；Claude 在安全性、長上下文處理和推理能力上有優勢。' },
    { t1: 'jasper', t2: 'openai', strength: 70, type: 'complements', rationale: 'Jasper 是基於 OpenAI 模型的行銷文案工具，提供專門的範本和工作流程。兩者互補：OpenAI 提供底層能力，Jasper 提供專業應用場景。' },
    { t1: 'retool', t2: 'supabase', strength: 88, type: 'integrates_with', rationale: 'Retool 原生支援 Supabase 整合，可快速建立內部管理工具。Supabase 提供後端資料庫和認證，Retool 提供前端介面，是建立內部工具的黃金組合。' },
  ];

  additionalPairs.forEach(pair => {
    const t1 = tools.find(t => t.id === pair.t1);
    const t2 = tools.find(t => t.id === pair.t2);
    if (t1 && t2) {
      pairings.push({
        tool_1_id: pair.t1,
        tool_2_id: pair.t2,
        tool_1_name: t1.name_en,
        tool_2_name: t2.name_en,
        relationship_type: pair.type as any,
        strength: pair.strength,
        rationale: pair.rationale
      });
    }
  });

  return pairings;
};

// Main execution
const csvPath = path.join(__dirname, 'data', 'tools.csv');
const outputPath = path.join(__dirname, 'data', 'tool_pairings.json');

try {
  const csvContent = fs.readFileSync(csvPath, 'utf-8');
  const tools = parseCSV(csvContent);

  console.log(`Loaded ${tools.length} tools from CSV`);

  const pairings = generatePairings(tools);

  console.log(`Generated ${pairings.length} tool pairings`);

  // Validate data
  const duplicates = new Set();
  const validated = pairings.filter(p => {
    const key = [p.tool_1_id, p.tool_2_id].sort().join('_');
    if (duplicates.has(key)) {
      console.warn(`Duplicate pairing found: ${p.tool_1_id} - ${p.tool_2_id}`);
      return false;
    }
    duplicates.add(key);

    if (!p.rationale || p.rationale.length < 20) {
      console.warn(`Weak rationale for: ${p.tool_1_id} - ${p.tool_2_id}`);
      return false;
    }

    if (p.strength < 0 || p.strength > 100) {
      console.warn(`Invalid strength for: ${p.tool_1_id} - ${p.tool_2_id}`);
      return false;
    }

    return true;
  });

  console.log(`Validated ${validated.length} pairings`);

  fs.writeFileSync(outputPath, JSON.stringify(validated, null, 2));
  console.log(`Saved to ${outputPath}`);

} catch (error) {
  console.error('Error generating tool pairings:', error);
  process.exit(1);
}
