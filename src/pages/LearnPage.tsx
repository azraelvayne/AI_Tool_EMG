import { BookOpen, Layers, Download, Zap, Users, Target } from 'lucide-react';
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
    {
      id: 'filters',
      icon: Layers,
      title: language === 'zh-TW' ? '如何使用篩選' : 'How to Use Filters',
      description: language === 'zh-TW'
        ? '我們的多軸篩選系統讓你從不同角度探索工具生態。'
        : 'Our multi-axis filtering system allows you to explore the tool ecosystem from different perspectives.',
      content: [
        language === 'zh-TW' ? '目的分類：學習導向、應用導向、系統導向' : 'Purpose: Learning, Application, System Oriented',
        language === 'zh-TW' ? '功能角色：資料庫、API、自動化、前端等' : 'Functional Role: Database, API, Automation, Frontend, etc.',
        language === 'zh-TW' ? '技術層級：資料層、處理層、前端層、AI 層' : 'Tech Layer: Data, Processing, Frontend, AI Layer',
        language === 'zh-TW' ? '難度級別：No-code、Low-code、Code' : 'Difficulty: No-code, Low-code, Code'
      ]
    },
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
    },
    {
      id: 'use-cases',
      icon: Zap,
      title: language === 'zh-TW' ? '創意用例' : 'Creative Use Cases',
      description: language === 'zh-TW'
        ? '探索跨領域的創意應用場景，找到適合你的工作流靈感。'
        : 'Explore cross-domain creative application scenarios and find workflow inspiration.',
      content: [
        language === 'zh-TW' ? '10+ 精選跨領域應用範例' : '10+ curated cross-domain application examples',
        language === 'zh-TW' ? '逐步工作流程說明與視覺化' : 'Step-by-step workflow instructions and visualization',
        language === 'zh-TW' ? '一鍵套用工具堆疊到探索頁' : 'One-click apply tool stack to explorer',
        language === 'zh-TW' ? '難度分級與預估設置時間' : 'Difficulty levels and estimated setup time'
      ]
    },
    {
      id: 'pairings',
      icon: Users,
      title: language === 'zh-TW' ? '工具配對概念' : 'Tool Pairing Concepts',
      description: language === 'zh-TW'
        ? '理解工具間的協同效應，建立更強大的自動化解決方案。'
        : 'Understand synergies between tools to build more powerful automation solutions.',
      content: [
        language === 'zh-TW' ? '整合關係：工具間的原生整合能力' : 'Integration: Native integration capabilities between tools',
        language === 'zh-TW' ? '互補關係：功能互補的工具組合' : 'Complementary: Functionally complementary tool combinations',
        language === 'zh-TW' ? '替代關係：相似功能的不同選擇' : 'Alternative: Different choices for similar functions',
        language === 'zh-TW' ? '配對強度：0-100 的連接緊密度評分' : 'Pairing Strength: 0-100 connection strength score'
      ]
    },
    {
      id: 'personas',
      icon: Target,
      title: language === 'zh-TW' ? '人物角色引導' : 'Persona-Guided Learning',
      description: language === 'zh-TW'
        ? '根據你的角色與目標，找到最適合的學習路徑與工具組合。'
        : 'Find the most suitable learning path and tool combinations based on your role and goals.',
      content: [
        language === 'zh-TW' ? '選擇符合你身份的學習人物角色' : 'Choose a learning persona that matches your identity',
        language === 'zh-TW' ? '探索針對性的學習目標與技能樹' : 'Explore targeted learning goals and skill trees',
        language === 'zh-TW' ? '獲得個人化的工具堆疊建議' : 'Get personalized tool stack recommendations',
        language === 'zh-TW' ? '追蹤你的學習進度與收藏' : 'Track your learning progress and favorites'
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
    },
    {
      q: language === 'zh-TW' ? '如何找到適合我的工具組合？' : 'How do I find the right tool combination for me?',
      a: language === 'zh-TW'
        ? '使用篩選器根據難度、用途、技術層級篩選工具；查看工具詳情頁的「常見配對」建議；或從創意用例中找到類似場景。'
        : 'Use filters to screen tools by difficulty, purpose, and tech layer; check "common pairings" in tool details; or find similar scenarios in creative use cases.'
    },
    {
      q: language === 'zh-TW' ? 'AI 推薦功能如何使用？' : 'How do I use the AI recommendation feature?',
      a: language === 'zh-TW'
        ? '點擊「AI 生成」按鈕，描述你想達成的目標，系統會根據工具的分類和配對關係推薦 3 組工具堆疊。'
        : 'Click the "AI Generate" button, describe your goal, and the system will recommend 3 tool stacks based on tool classifications and pairings.'
    }
  ];

  return (
    <PageTransition className="min-h-screen bg-gradient-to-br from-teal-50 via-white to-green-50">
      <div className="bg-gradient-header text-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
          <Breadcrumb
            items={[
              {
                label: language === 'zh-TW' ? '首頁' : 'Home',
                onClick: onBackToHome
              },
              {
                label: language === 'zh-TW' ? '學習中心' : 'Learn',
                isCurrentPage: true
              }
            ]}
            className="text-white/90 mb-6"
          />

          <div className="flex items-start gap-6">
            <div className="w-20 h-20 bg-white/10 backdrop-blur-sm rounded-2xl flex items-center justify-center">
              <BookOpen className="w-10 h-10" />
            </div>
            <div className="flex-1">
              <h1 className="text-4xl font-bold mb-3">
                {language === 'zh-TW' ? '學習中心' : 'Learning Center'}
              </h1>
              <p className="text-xl text-blue-100">
                {language === 'zh-TW'
                  ? '了解如何使用 AI Mapper 探索工具生態、建立工作流、匯出配置'
                  : 'Learn how to use AI Mapper to explore tool ecosystems, build workflows, and export configurations'}
              </p>
            </div>
          </div>
        </div>
      </div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-12">
          {sections.map((section) => (
            <Card key={section.id} className="p-6">
              <div className="flex items-start gap-4 mb-4">
                <div className="w-12 h-12 bg-gradient-to-br from-blue-500 to-primary-500 rounded-lg flex items-center justify-center flex-shrink-0">
                  <section.icon className="w-6 h-6 text-white" />
                </div>
                <div className="flex-1">
                  <h3 className="text-xl font-semibold text-gray-900 mb-2">
                    {section.title}
                  </h3>
                  <p className="text-gray-600 mb-4">
                    {section.description}
                  </p>
                </div>
              </div>
              <ul className="space-y-2">
                {section.content.map((item, index) => (
                  <li key={index} className="flex items-start gap-2 text-gray-700">
                    <span className="text-primary-500 mt-1">•</span>
                    <span>{item}</span>
                  </li>
                ))}
              </ul>
            </Card>
          ))}
        </div>

        <div className="bg-white rounded-xl border border-gray-200 p-8 mb-12">
          <h2 className="text-2xl font-bold text-gray-900 mb-6">
            {language === 'zh-TW' ? '常見問題' : 'Frequently Asked Questions'}
          </h2>
          <div className="space-y-6">
            {faqs.map((faq, index) => (
              <div key={index} className="border-b border-gray-200 last:border-0 pb-6 last:pb-0">
                <h4 className="text-lg font-semibold text-gray-900 mb-2">
                  {faq.q}
                </h4>
                <p className="text-gray-600">
                  {faq.a}
                </p>
              </div>
            ))}
          </div>
        </div>

        <div className="bg-gradient-to-r from-teal-50 to-green-50 rounded-xl border border-primary-200 p-8 text-center">
          <h3 className="text-2xl font-bold text-gray-900 mb-3">
            {language === 'zh-TW' ? '準備好開始了嗎？' : 'Ready to Get Started?'}
          </h3>
          <p className="text-gray-600 mb-6 max-w-2xl mx-auto">
            {language === 'zh-TW'
              ? '探索工具目錄、發現創意用例、建立你的專屬工具堆疊'
              : 'Explore the tool directory, discover creative use cases, and build your custom tool stack'}
          </p>
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
