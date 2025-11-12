import { useState } from 'react';
import { Download, Copy, Check, FileJson, FileSpreadsheet, MessageSquare, Workflow, Palette } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { Modal } from './ui/Modal';
import { Button } from './ui/Button';
import type { Tool } from '../types';
import { exportUtils } from '../lib/export';
import { storage } from '../lib/localStorage';
import { db } from '../lib/database';

interface ExportModalProps {
  tool: Tool;
  isOpen: boolean;
  onClose: () => void;
}

type ExportFormat = 'json-pretty' | 'json-minified' | 'csv' | 'notion-csv' | 'claude-prompt' | 'universal-prompt' | 'n8n' | 'canva';

export function ExportModal({ tool, isOpen, onClose }: ExportModalProps) {
  const { t } = useTranslation();
  const [selectedFormat, setSelectedFormat] = useState<ExportFormat>('json-pretty');
  const [copied, setCopied] = useState(false);

  const formats = [
    {
      id: 'json-pretty' as ExportFormat,
      name: t('export.json_pretty'),
      description: t('export.json_pretty_desc'),
      icon: FileJson,
      color: '#3B82F6'
    },
    {
      id: 'json-minified' as ExportFormat,
      name: t('export.json_minified'),
      description: t('export.json_minified_desc'),
      icon: FileJson,
      color: '#0EA5E9'
    },
    {
      id: 'csv' as ExportFormat,
      name: t('export.csv_standard'),
      description: t('export.csv_standard_desc'),
      icon: FileSpreadsheet,
      color: '#10B981'
    },
    {
      id: 'notion-csv' as ExportFormat,
      name: t('export.notion_database'),
      description: t('export.notion_database_desc'),
      icon: FileSpreadsheet,
      color: '#6B7280'
    },
    {
      id: 'claude-prompt' as ExportFormat,
      name: t('export.claude_prompt'),
      description: t('export.claude_prompt_desc'),
      icon: MessageSquare,
      color: '#F59E0B'
    },
    {
      id: 'universal-prompt' as ExportFormat,
      name: t('export.universal_prompt'),
      description: t('export.universal_prompt_desc'),
      icon: MessageSquare,
      color: '#14B8A6'
    },
    {
      id: 'n8n' as ExportFormat,
      name: t('export.n8n_workflow'),
      description: t('export.n8n_workflow_desc'),
      icon: Workflow,
      color: '#EC4899'
    },
    {
      id: 'canva' as ExportFormat,
      name: t('export.canva_markdown'),
      description: t('export.canva_markdown_desc'),
      icon: Palette,
      color: '#8B5CF6'
    }
  ];

  const getExportContent = (): string => {
    switch (selectedFormat) {
      case 'json-pretty':
        return exportUtils.exportJSON(tool, true);
      case 'json-minified':
        return exportUtils.exportJSON(tool, false);
      case 'csv':
        return exportUtils.exportCSV([tool]);
      case 'notion-csv':
        return exportUtils.exportNotionCSV([tool]);
      case 'claude-prompt':
        return exportUtils.generateClaudePrompt(tool);
      case 'universal-prompt':
        return exportUtils.generateUniversalPrompt();
      case 'n8n':
        return exportUtils.generateN8NWorkflowPrompt(tool);
      case 'canva':
        return exportUtils.generateCanvaMarkdown(tool);
      default:
        return '';
    }
  };

  const getFileName = (): string => {
    const toolName = tool.tool_name.toLowerCase().replace(/\s+/g, '-');
    switch (selectedFormat) {
      case 'json-pretty':
      case 'json-minified':
        return `${toolName}.json`;
      case 'csv':
      case 'notion-csv':
        return `${toolName}.csv`;
      case 'claude-prompt':
        return `${toolName}-claude-prompt.txt`;
      case 'universal-prompt':
        return `universal-prompt-template.txt`;
      case 'n8n':
        return `${toolName}-n8n-workflow.md`;
      case 'canva':
        return `${toolName}-presentation.md`;
      default:
        return `${toolName}.txt`;
    }
  };

  const getMimeType = (): string => {
    if (selectedFormat.includes('json')) return 'application/json';
    if (selectedFormat.includes('csv')) return 'text/csv';
    return 'text/plain';
  };

  const handleCopy = async () => {
    const content = getExportContent();
    exportUtils.copyToClipboard(content);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);

    if (tool.id) {
      const sessionId = storage.generateSessionId();
      await db.trackGenerate(tool.id, sessionId);
    }
  };

  const handleDownload = async () => {
    const content = getExportContent();
    const filename = getFileName();
    const mimeType = getMimeType();
    exportUtils.downloadFile(content, filename, mimeType);

    if (tool.id) {
      const sessionId = storage.generateSessionId();
      await db.trackGenerate(tool.id, sessionId);
    }
  };

  return (
    <Modal isOpen={isOpen} onClose={onClose} title={t('export.modal_title', { name: tool.tool_name })} size="xl">
      <div className="space-y-6">
        <div>
          <h3 className="text-sm font-semibold text-gray-700 mb-3">{t('export.select_format')}</h3>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
            {formats.map((format) => (
              <button
                key={format.id}
                onClick={() => setSelectedFormat(format.id)}
                className={`flex items-start gap-3 p-4 rounded-lg border-2 transition-all text-left ${
                  selectedFormat === format.id
                    ? 'border-blue-500 bg-blue-50'
                    : 'border-gray-200 hover:border-gray-300 hover:bg-gray-50'
                }`}
              >
                <div
                  className="w-10 h-10 rounded-lg flex items-center justify-center flex-shrink-0"
                  style={{ backgroundColor: format.color + '20' }}
                >
                  <format.icon size={20} style={{ color: format.color }} />
                </div>
                <div className="flex-1 min-w-0">
                  <div className="font-semibold text-gray-900 mb-1">{format.name}</div>
                  <div className="text-sm text-gray-600">{format.description}</div>
                </div>
              </button>
            ))}
          </div>
        </div>

        <div>
          <h3 className="text-sm font-semibold text-gray-700 mb-3">{t('export.preview')}</h3>
          <div className="bg-gray-900 text-gray-100 rounded-lg p-4 max-h-96 overflow-auto font-mono text-sm">
            <pre className="whitespace-pre-wrap break-words">{getExportContent()}</pre>
          </div>
        </div>

        <div className="flex gap-3">
          <Button
            icon={copied ? Check : Copy}
            onClick={handleCopy}
            variant={copied ? 'primary' : 'outline'}
            className="flex-1"
          >
            {copied ? t('export.copied') : t('export.copy')}
          </Button>
          <Button
            icon={Download}
            onClick={handleDownload}
            variant="primary"
            className="flex-1"
          >
            {t('export.download_file')}
          </Button>
        </div>

        <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
          <h4 className="font-semibold text-blue-900 mb-2">💡 {t('export.usage_tips')}</h4>
          <ul className="text-sm text-blue-800 space-y-1">
            {selectedFormat.includes('prompt') && (
              <>
                <li>• {t('export.tips.prompt_1')}</li>
                <li>• {t('export.tips.prompt_2')}</li>
              </>
            )}
            {selectedFormat.includes('json') && (
              <>
                <li>• {t('export.tips.json_1')}</li>
                <li>• {t('export.tips.json_2')}</li>
              </>
            )}
            {selectedFormat.includes('csv') && (
              <>
                <li>• {t('export.tips.csv_1')}</li>
                <li>• {t('export.tips.csv_2')}</li>
              </>
            )}
            {selectedFormat === 'n8n' && (
              <>
                <li>• {t('export.tips.n8n_1')}</li>
                <li>• {t('export.tips.n8n_2')}</li>
              </>
            )}
            {selectedFormat === 'canva' && (
              <>
                <li>• {t('export.tips.canva_1')}</li>
                <li>• {t('export.tips.canva_2')}</li>
              </>
            )}
          </ul>
        </div>
      </div>
    </Modal>
  );
}
