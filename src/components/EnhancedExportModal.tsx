import { useState } from 'react';
import { Download, Copy, Check, ExternalLink, Play } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { Modal } from './ui/Modal';
import { Button } from './ui/Button';
import type { Tool } from '../types';
import { exportUtils } from '../lib/export';
import { storage } from '../lib/localStorage';
import { db } from '../lib/database';

interface EnhancedExportModalProps {
  tool: Tool;
  isOpen: boolean;
  onClose: () => void;
}

type Platform = 'n8n' | 'langflow' | 'zapier';

export function EnhancedExportModal({ tool, isOpen, onClose }: EnhancedExportModalProps) {
  const { t, i18n } = useTranslation();
  const [selectedPlatform, setSelectedPlatform] = useState<Platform>('n8n');
  const [copied, setCopied] = useState(false);
  const [validationResult, setValidationResult] = useState<{ valid: boolean; error?: string } | null>(null);

  const language = i18n.language as 'en' | 'zh-TW';

  const platforms = [
    {
      id: 'n8n' as Platform,
      name: 'n8n',
      description: language === 'zh-TW' ? '可直接匯入的 workflow JSON' : 'Importable workflow JSON',
      color: '#EA4B71',
      icon: Play
    },
    {
      id: 'langflow' as Platform,
      name: 'Langflow',
      description: language === 'zh-TW' ? '可直接匯入的 flow JSON' : 'Importable flow JSON',
      color: '#7C3AED',
      icon: Play
    },
    {
      id: 'zapier' as Platform,
      name: 'Zapier',
      description: language === 'zh-TW' ? '模板連結與操作指南' : 'Template link and setup guide',
      color: '#FF4A00',
      icon: ExternalLink
    }
  ];

  const getExportContent = (): string | object => {
    switch (selectedPlatform) {
      case 'n8n':
        return exportUtils.generateN8nWorkflow(tool);
      case 'langflow':
        return exportUtils.generateLangflowWorkflow(tool);
      case 'zapier':
        return exportUtils.generateZapierTemplate(tool);
      default:
        return '';
    }
  };

  const getFileName = (): string => {
    const toolSlug = tool.tool_name.toLowerCase().replace(/\s+/g, '-');
    switch (selectedPlatform) {
      case 'n8n':
        return `${toolSlug}-n8n-workflow.json`;
      case 'langflow':
        return `${toolSlug}-langflow.json`;
      case 'zapier':
        return `${toolSlug}-zapier-guide.json`;
      default:
        return `${toolSlug}.json`;
    }
  };

  const handleValidate = () => {
    if (selectedPlatform === 'zapier') {
      setValidationResult({ valid: true });
      return;
    }

    const content = getExportContent() as string;
    const result = exportUtils.validateWorkflowJSON(content, selectedPlatform);
    setValidationResult(result);
  };

  const handleCopy = async () => {
    const content = getExportContent();
    const textContent = typeof content === 'string' ? content : JSON.stringify(content, null, 2);
    exportUtils.copyToClipboard(textContent);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);

    if (tool.id) {
      const sessionId = storage.generateSessionId();
      await db.trackGenerate(tool.id, sessionId);
    }
  };

  const handleDownload = async () => {
    const content = getExportContent();
    const textContent = typeof content === 'string' ? content : JSON.stringify(content, null, 2);
    const filename = getFileName();
    exportUtils.downloadFile(textContent, filename, 'application/json');

    if (tool.id) {
      const sessionId = storage.generateSessionId();
      await db.trackGenerate(tool.id, sessionId);
    }
  };

  const renderZapierContent = () => {
    const zapierData = getExportContent() as any;
    return (
      <div className="space-y-6">
        <div className="bg-orange-50 border-l-4 border-orange-500 p-4 rounded">
          <h4 className="font-semibold text-orange-900 mb-2">
            {language === 'zh-TW' ? '快速開始' : 'Quick Start'}
          </h4>
          <p className="text-sm text-orange-800 mb-3">{zapierData.description}</p>
          <a
            href={zapierData.template_url}
            target="_blank"
            rel="noopener noreferrer"
            className="inline-flex items-center gap-2 text-orange-600 hover:text-orange-700 font-medium"
          >
            <ExternalLink size={16} />
            {language === 'zh-TW' ? '在 Zapier 開啟' : 'Open in Zapier'}
          </a>
        </div>

        <div>
          <h4 className="font-semibold text-gray-900 mb-3">
            {language === 'zh-TW' ? '設定步驟' : 'Setup Steps'}
          </h4>
          <div className="space-y-4">
            {zapierData.steps?.map((step: any) => (
              <div key={step.step} className="border border-gray-200 rounded-lg p-4">
                <div className="flex items-start gap-3 mb-2">
                  <div className="w-8 h-8 bg-orange-500 text-white rounded-full flex items-center justify-center font-bold flex-shrink-0">
                    {step.step}
                  </div>
                  <div className="flex-1">
                    <h5 className="font-semibold text-gray-900">{step.type}: {step.app}</h5>
                    <p className="text-sm text-gray-600 mt-1">{step.description}</p>
                  </div>
                </div>
                <ul className="ml-11 space-y-1">
                  {step.setup?.map((item: string, idx: number) => (
                    <li key={idx} className="text-sm text-gray-700">• {item}</li>
                  ))}
                </ul>
              </div>
            ))}
          </div>
        </div>

        {zapierData.common_pairings && zapierData.common_pairings.length > 0 && (
          <div>
            <h4 className="font-semibold text-gray-900 mb-2">
              {language === 'zh-TW' ? '常見配對工具' : 'Common Pairings'}
            </h4>
            <div className="flex flex-wrap gap-2">
              {zapierData.common_pairings.map((pairing: string) => (
                <span key={pairing} className="px-3 py-1 bg-gray-100 text-gray-700 text-sm rounded-full">
                  {pairing}
                </span>
              ))}
            </div>
          </div>
        )}

        {zapierData.tips && zapierData.tips.length > 0 && (
          <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
            <h4 className="font-semibold text-blue-900 mb-2">
              {language === 'zh-TW' ? '專業提示' : 'Pro Tips'}
            </h4>
            <ul className="space-y-1">
              {zapierData.tips.map((tip: string, idx: number) => (
                <li key={idx} className="text-sm text-blue-800">• {tip}</li>
              ))}
            </ul>
          </div>
        )}
      </div>
    );
  };

  const renderWorkflowPreview = () => {
    if (selectedPlatform === 'zapier') {
      return renderZapierContent();
    }

    const content = getExportContent() as string;
    return (
      <div className="space-y-4">
        <div className="flex items-center justify-between">
          <h4 className="font-semibold text-gray-900">
            {language === 'zh-TW' ? 'JSON 預覽' : 'JSON Preview'}
          </h4>
          <button
            onClick={handleValidate}
            className="text-sm text-blue-600 hover:text-blue-700 font-medium"
          >
            {language === 'zh-TW' ? '驗證格式' : 'Validate Format'}
          </button>
        </div>

        {validationResult && (
          <div
            className={`p-3 rounded-lg text-sm ${
              validationResult.valid
                ? 'bg-green-50 text-green-800 border border-green-200'
                : 'bg-red-50 text-red-800 border border-red-200'
            }`}
          >
            {validationResult.valid
              ? (language === 'zh-TW' ? '✓ 格式驗證通過' : '✓ Format validation passed')
              : `✗ ${validationResult.error}`}
          </div>
        )}

        <div className="bg-gray-900 text-gray-100 rounded-lg p-4 max-h-96 overflow-auto font-mono text-xs">
          <pre className="whitespace-pre-wrap break-words">{content}</pre>
        </div>

        <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
          <h5 className="font-semibold text-blue-900 mb-2">
            {language === 'zh-TW' ? '如何使用' : 'How to Use'}
          </h5>
          <ol className="text-sm text-blue-800 space-y-1">
            {selectedPlatform === 'n8n' && (
              <>
                <li>1. {language === 'zh-TW' ? '複製或下載此 JSON 檔案' : 'Copy or download this JSON file'}</li>
                <li>2. {language === 'zh-TW' ? '開啟 n8n 工作流程編輯器' : 'Open n8n workflow editor'}</li>
                <li>3. {language === 'zh-TW' ? '點擊「Import from File」或「Import from Clipboard」' : 'Click "Import from File" or "Import from Clipboard"'}</li>
                <li>4. {language === 'zh-TW' ? '配置節點參數與 API 憑證' : 'Configure node parameters and API credentials'}</li>
                <li>5. {language === 'zh-TW' ? '測試並啟用工作流程' : 'Test and activate workflow'}</li>
              </>
            )}
            {selectedPlatform === 'langflow' && (
              <>
                <li>1. {language === 'zh-TW' ? '複製或下載此 JSON 檔案' : 'Copy or download this JSON file'}</li>
                <li>2. {language === 'zh-TW' ? '開啟 Langflow 介面' : 'Open Langflow interface'}</li>
                <li>3. {language === 'zh-TW' ? '點擊「Import」按鈕' : 'Click "Import" button'}</li>
                <li>4. {language === 'zh-TW' ? '選擇或貼上 JSON 檔案' : 'Select or paste JSON file'}</li>
                <li>5. {language === 'zh-TW' ? '配置 LLM 模型與 API keys' : 'Configure LLM model and API keys'}</li>
                <li>6. {language === 'zh-TW' ? '測試流程' : 'Test the flow'}</li>
              </>
            )}
          </ol>
        </div>
      </div>
    );
  };

  return (
    <Modal
      isOpen={isOpen}
      onClose={onClose}
      title={`${language === 'zh-TW' ? '匯出' : 'Export'} ${tool.tool_name}`}
      size="xl"
    >
      <div className="space-y-6">
        <div>
          <h3 className="text-sm font-semibold text-gray-700 mb-3">
            {language === 'zh-TW' ? '選擇平台' : 'Select Platform'}
          </h3>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
            {platforms.map((platform) => (
              <button
                key={platform.id}
                onClick={() => {
                  setSelectedPlatform(platform.id);
                  setValidationResult(null);
                }}
                className={`flex items-start gap-3 p-4 rounded-lg border-2 transition-all text-left ${
                  selectedPlatform === platform.id
                    ? 'border-blue-500 bg-blue-50'
                    : 'border-gray-200 hover:border-gray-300 hover:bg-gray-50'
                }`}
              >
                <div
                  className="w-10 h-10 rounded-lg flex items-center justify-center flex-shrink-0"
                  style={{ backgroundColor: platform.color + '20' }}
                >
                  <platform.icon size={20} style={{ color: platform.color }} />
                </div>
                <div className="flex-1 min-w-0">
                  <div className="font-semibold text-gray-900 mb-1">{platform.name}</div>
                  <div className="text-sm text-gray-600">{platform.description}</div>
                </div>
              </button>
            ))}
          </div>
        </div>

        {renderWorkflowPreview()}

        <div className="flex gap-3 pt-4 border-t border-gray-200">
          {selectedPlatform !== 'zapier' && (
            <Button
              icon={copied ? Check : Copy}
              onClick={handleCopy}
              variant={copied ? 'primary' : 'outline'}
              className="flex-1"
            >
              {copied
                ? (language === 'zh-TW' ? '已複製' : 'Copied')
                : (language === 'zh-TW' ? '複製 JSON' : 'Copy JSON')}
            </Button>
          )}
          {selectedPlatform !== 'zapier' && (
            <Button
              icon={Download}
              onClick={handleDownload}
              variant="primary"
              className="flex-1"
            >
              {language === 'zh-TW' ? '下載檔案' : 'Download File'}
            </Button>
          )}
          {selectedPlatform === 'zapier' && (
            <Button
              icon={ExternalLink}
              onClick={() => {
                const zapierData = getExportContent() as any;
                window.open(zapierData.template_url, '_blank');
              }}
              variant="primary"
              className="flex-1"
            >
              {language === 'zh-TW' ? '在 Zapier 開啟' : 'Open in Zapier'}
            </Button>
          )}
        </div>
      </div>
    </Modal>
  );
}
