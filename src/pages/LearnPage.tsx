import { BookOpen, Layers, Download, Zap, Users, Target, Database, Workflow, ShieldCheck } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { PageTransition } from '../components/animations/PageTransition';
import { Breadcrumb } from '../components/navigation/Breadcrumb';
import { Card } from '../components/ui/Card';
import { Badge } from '../components/ui/Badge';
import { Button } from '../components/ui/Button';

interface LearnPageProps {
  language: 'en' | 'zh-TW';
  onBackToHome: () => void;
}

export function LearnPage({ language, onBackToHome }: LearnPageProps) {
  const { t } = useTranslation();

  const sections = [
    {
      id: 'overview',
      icon: BookOpen,
      title: language === 'zh-TW' ? '平台概覽' : 'Platform Overview',
      description: language === 'zh-TW'
        ? 'AI Mapper 是一個智能工具生態系統探索平台，幫助你發現、理解和組合各種 AI 與自動化工具。'
        : 'AI Mapper is an intelligent tool ecosystem exploration platform that helps you discover, understand, and combine various AI and automation tools.',
      content: [
        language === 'zh-TW' ? '探索 100+ 精選工具的詳細資訊' : 'Explore detailed information on 100+ curated tools',
        language === 'zh-TW' ? '多維度分類系統幫助精準找到合適工具' : 'Multi-dimensional classification system for precise tool discovery',
        language === 'zh-TW' ? '視覺化工具配對與整合建議' : 'Visual tool pairing and integration recommendations',
        language === 'zh-TW' ? '可直接匯出的工作流模板' : 'Ready-to-use exportable workflow templates'
      ]
    },
    // ... 其他原有的 section 保留 ...
    {
      id: 'export',
      icon: Download,
      title: language === 'zh-TW' ? '匯出指南' : 'Export Guide',
      description: language === 'zh-TW'
        ? '將你的工具組合匯出到各種平台，快速開始自動化工作流。'
        : 'Export your tool combinations to various platforms to quickly start automation workflows.',
      content: [
        language === 'zh-TW' ? 'n8n：可直接匯入的工作流 JSON 檔案' : 'n8n: Directly importable workflow JSON files',
        language === 'zh-TW' ? 'Langflow：完整的流程節點配置' : 'Langflow: Complete flow node configurations',
        language === 'zh-TW' ? 'Zapier：模板連結與欄位映射指南' : 'Zapier: Template links and field mapping guides',
        language === 'zh-TW' ? 'JSON/CSV：資料格式用於備份與分享' : 'JSON/CSV: Data formats for backup and sharing'
      ]
    }
  ];

  const faqs = [
    {
      q: language === 'zh-TW' ? '如何開始使用 AI Mapper？' : 'How do I get started with AI Mapper?',
      a: language === 'zh-TW'
        ? '從首頁的三個入口開始：選擇人物角色進入引導式學習、瀏覽工具目錄進行自由探索、或查看創意用例獲取靈感。'
        : 'Start from the homepage with three entry points: choose a persona for guided learning, browse the tool directory for free exploration, or check out creative use cases for inspiration.'
    },
    {
      q: language === 'zh-TW' ? '匯出的工作流模板可以直接使用嗎？' : 'Can exported workflow templates be used directly?',
      a: language === 'zh-TW'
        ? 'n8n 和 Langflow 的模板可以直接匯入並使用，但你需要填入你自己的 API 金鑰和帳號資訊。Zapier 提供模板連結和設置指南。'
        : 'n8n and Langflow templates can be imported and used directly, but you need to fill in your own API keys and account information. Zapier provides template links and setup guides.'
    },
    {
      q: language === 'zh-TW' ? '收藏功能如何運作？' : 'How does the favorites feature work?',
      a: language === 'zh-TW'
        ? '所有收藏都儲存在你的瀏覽器本地，你可以建立多個收藏集、拖曳排序、批次匯出，並生成分享連結給他人。'
        : 'All favorites are stored locally in your browser. You can create multiple collections, drag to reorder, batch export, and generate shareable links.'
    }
  ];

  return (
    <PageTransition className="min-h-screen bg-gradient-to-br from-blue-50 via-white to-teal-50">
      <div className="bg-gradient-to-r from-blue-600 to-teal-600 text-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
          <Breadcrumb
            items={[
              { label: language === 'zh-TW' ? '首頁' : 'Home', onClick: onBackToHome },
              { label: language === 'zh-TW' ? '學習中心' : 'Learn', isCurrentPage: true }
            ]}
            className="text-white/90 mb-6"
          />

          <div className="flex items-start gap-6">
            <div className="w-20 h-20 bg-white/10 backdrop-blur-sm rounded-2xl flex items-center justify-center">
              <BookOpen className="w-10 h-10" />
            </div>
            <div className="flex-1">
              <h1 className="text-4xl font-bold mb-3">{language === 'zh-TW' ? '學習中心' : 'Learning Center'}</h1>
              <p className="text-xl text-blue-100">
                {language === 'zh-TW' ? '深入了解 6D 生態架構與平台使用指南' : 'Learn about the 6D ecosystem architecture and platform guide'}
              </p>
            </div>
          </div>
        </div>
      </div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        {/* 1. 原有的卡片區塊 */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-12">
          {sections.map((section) => (
            <Card key={section.id} className="p-6">
              <div className="flex items-start gap-4 mb-4">
                <div className="w-12 h-12 bg-gradient-to-br from-blue-500 to-teal-500 rounded-lg flex items-center justify-center flex-shrink-0">
                  <section.icon className="w-6 h-6 text-white" />
                </div>
                <div className="flex-1">
                  <h3 className="text-xl font-semibold text-gray-900 mb-2">{section.title}</h3>
                  <p className="text-gray-600 mb-4">{section.description}</p>
                </div>
              </div>
              <ul className="space-y-2">
                {section.content.map((item, index) => (
                  <li key={index} className="flex items-start gap-2 text-gray-700">
                    <span className="text-blue-500 mt-1">•</span><span>{item}</span>
                  </li>
                ))}
              </ul>
            </Card>
          ))}
        </div>

        {/* 2. 新增：6D 架構表格區塊 (這就是你要的新內容！) */}
        <div className="bg-white rounded-xl border border-gray-200 p-8 mb-12 shadow-sm">
          <div className="flex items-center gap-3 mb-6">
            <Layers className="w-8 h-8 text-purple-600" />
            <h2 className="text-2xl font-bold text-gray-900">
              {language === 'zh-TW' ? '6D 生態系架構詳解' : '6D Ecosystem Architecture'}
            </h2>
          </div>
          
          <div className="overflow-x-auto">
            <table className="w-full text-left border-collapse">
              <thead>
                <tr className="bg-gray-50 border-b border-gray-200">
                  <th className="p-4 font-bold text-gray-700 w-24">維度</th>
                  <th className="p-4 font-bold text-gray-700 w-32">層級名稱</th>
                  <th className="p-4 font-bold text-gray-700 w-48">核心問題</th>
                  <th className="p-4 font-bold text-gray-700">定義與範例</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {/* 使用者導向 */}
                <tr className="hover:bg-blue-50/30 transition-colors">
                  <td rowSpan={3} className="p-4 font-bold text-blue-600 bg-blue-50/50 align-top border-r border-gray-100">使用者<br/>導向</td>
                  <td className="p-4 flex items-center gap-2 font-medium text-gray-900"><Users className="w-4 h-4 text-blue-500" /> 1. 角色層</td>
                  <td className="p-4 text-gray-600 italic">"我是誰？"</td>
                  <td className="p-4 text-gray-600">使用者的身分與動機。例如：創意開發者、自動化經理。</td>
                </tr>
                <tr className="hover:bg-blue-50/30 transition-colors">
                  <td className="p-4 flex items-center gap-2 font-medium text-gray-900"><Target className="w-4 h-4 text-blue-500" /> 2. 目標層</td>
                  <td className="p-4 text-gray-600 italic">"我要做什麼？"</td>
                  <td className="p-4 text-gray-600">具體的任務與應用場景。例如：建立 AI 客服、行銷漏斗。</td>
                </tr>
                <tr className="hover:bg-blue-50/30 transition-colors">
                  <td className="p-4 flex items-center gap-2 font-medium text-gray-900"><Layers className="w-4 h-4 text-blue-500" /> 3. 工具層</td>
                  <td className="p-4 text-gray-600 italic">"我用什麼工具？"</td>
                  <td className="p-4 text-gray-600">實現目標的具體軟體堆疊。例如：Notion + n8n。</td>
                </tr>
                {/* 系統導向 */}
                <tr className="hover:bg-green-50/30 transition-colors">
                  <td rowSpan={3} className="p-4 font-bold text-green-600 bg-green-50/50 align-top border-r border-gray-100">系統<br/>導向</td>
                  <td className="p-4 flex items-center gap-2 font-medium text-gray-900"><Database className="w-4 h-4 text-green-500" /> 4. 創作層</td>
                  <td className="p-4 text-gray-600 italic">"我生產什麼？"</td>
                  <td className="p-4 text-gray-600">內容生成與創意產出。例如：AI 影片、素材、海報。</td>
                </tr>
                <tr className="hover:bg-green-50/30 transition-colors">
                  <td className="p-4 flex items-center gap-2 font-medium text-gray-900"><Workflow className="w-4 h-4 text-green-500" /> 5. 營運層</td>
                  <td className="p-4 text-gray-600 italic">"怎麼推廣維運？"</td>
                  <td className="p-4 text-gray-600">行銷自動化與客戶關係管理。例如：自動寄信、CRM 管理。</td>
                </tr>
                <tr className="hover:bg-green-50/30 transition-colors">
                  <td className="p-4 flex items-center gap-2 font-medium text-gray-900"><ShieldCheck className="w-4 h-4 text-green-500" /> 6. 管理層</td>
                  <td className="p-4 text-gray-600 italic">"怎麼統整監控？"</td>
                  <td className="p-4 text-gray-600">專案進度與資料流管理。例如：專案管理、資料同步。</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        {/* 3. 原有的 FAQ 區塊 */}
        <div className="bg-white rounded-xl border border-gray-200 p-8 mb-12">
          <h2 className="text-2xl font-bold text-gray-900 mb-6">
            {language === 'zh-TW' ? '常見問題' : 'Frequently Asked Questions'}
          </h2>
          <div className="space-y-6">
            {faqs.map((faq, index) => (
              <div key={index} className="border-b border-gray-200 last:border-0 pb-6 last:pb-0">
                <h4 className="text-lg font-semibold text-gray-900 mb-2">{faq.q}</h4>
                <p className="text-gray-600">{faq.a}</p>
              </div>
            ))}
          </div>
        </div>

        <div className="bg-gradient-to-r from-blue-50 to-teal-50 rounded-xl border border-blue-200 p-8 text-center">
          <h3 className="text-2xl font-bold text-gray-900 mb-3">
            {language === 'zh-TW' ? '準備好開始了嗎？' : 'Ready to Get Started?'}
          </h3>
          <div className="flex justify-center gap-4">
            <Button variant="primary" size="lg" onClick={onBackToHome}>
              {language === 'zh-TW' ? '返回首頁' : 'Back to Home'}
            </Button>
          </div>
        </div>
      </div>
    </PageTransition>
  );
}