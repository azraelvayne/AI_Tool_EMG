import { useState, useEffect, useCallback } from 'react';
import { Shield, Plus, LogOut, List, BarChart3, CreditCard as Edit3, Search, Trash2, Copy, Eye, EyeOff, ChevronLeft, ChevronRight, FileText, CheckCircle, Archive, Save, X } from 'lucide-react';
import { Button } from '../components/ui/Button';
import { Input } from '../components/ui/Input';
import { Badge } from '../components/ui/Badge';
import { Modal } from '../components/ui/Modal';
import { ToastContainer, showToast } from '../components/ui/Toast';
import { db } from '../lib/database';
import { storage } from '../lib/localStorage';
import type { Tool, ToolStatus } from '../types';

type AdminTab = 'list' | 'add' | 'edit';
type StatusFilter = 'all' | ToolStatus;

interface AdminStats {
  total: number;
  published: number;
  draft: number;
  archived: number;
}

const emptyFormData = {
  tool_name: '',
  summary: '',
  website_url: '',
  logo_url: '',
  tool_description: '',
  categories: {
    purpose: [] as string[],
    functional_role: [] as string[],
    tech_layer: [] as string[],
    data_flow_role: [] as string[],
    application_field: [] as string[],
    difficulty: 'intermediate',
    common_pairings: [] as string[]
  },
  description_styles: {
    encyclopedia: '',
    guide: '',
    strategy: '',
    inspiration: [] as string[]
  },
  use_case_templates: [] as any[],
  display_priority: 0,
  is_verified: false,
  status: 'draft' as ToolStatus
};

export function AdminPage() {
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [password, setPassword] = useState('');
  const [rememberMe, setRememberMe] = useState(false);
  const [activeTab, setActiveTab] = useState<AdminTab>('list');
  const [tools, setTools] = useState<Tool[]>([]);
  const [stats, setStats] = useState<AdminStats>({ total: 0, published: 0, draft: 0, archived: 0 });
  const [searchQuery, setSearchQuery] = useState('');
  const [statusFilter, setStatusFilter] = useState<StatusFilter>('all');
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [totalItems, setTotalItems] = useState(0);
  const [loading, setLoading] = useState(false);
  const [editingTool, setEditingTool] = useState<Tool | null>(null);
  const [deleteTarget, setDeleteTarget] = useState<Tool | null>(null);
  const [formData, setFormData] = useState(emptyFormData);

  const perPage = 15;

  useEffect(() => {
    if (storage.isAdminAuthenticated()) {
      setIsAuthenticated(true);
    }
  }, []);

  const fetchTools = useCallback(async () => {
    setLoading(true);
    try {
      const result = await db.getAdminTools({
        search: searchQuery,
        status: statusFilter,
        page: currentPage,
        perPage
      });
      setTools(result.tools);
      setTotalItems(result.total);
      setTotalPages(Math.ceil(result.total / perPage) || 1);
    } catch (error) {
      console.error('Failed to fetch tools:', error);
      showToast('error', '載入工具列表失敗');
    } finally {
      setLoading(false);
    }
  }, [searchQuery, statusFilter, currentPage]);

  const fetchStats = useCallback(async () => {
    try {
      const s = await db.getAdminStats();
      setStats(s);
    } catch (error) {
      console.error('Failed to fetch stats:', error);
    }
  }, []);

  useEffect(() => {
    if (isAuthenticated) {
      fetchTools();
      fetchStats();
    }
  }, [isAuthenticated, fetchTools, fetchStats]);

  const handleLogin = () => {
    if (password === 'admin123') {
      setIsAuthenticated(true);
      if (rememberMe) {
        storage.setAdminToken('admin_session', 24);
      }
      showToast('success', '登入成功！');
    } else {
      showToast('error', '密碼錯誤');
    }
  };

  const handleLogout = () => {
    storage.clearAdminToken();
    setIsAuthenticated(false);
    setPassword('');
    setActiveTab('list');
  };

  const handleSearch = (value: string) => {
    setSearchQuery(value);
    setCurrentPage(1);
  };

  const handleStatusFilterChange = (status: StatusFilter) => {
    setStatusFilter(status);
    setCurrentPage(1);
  };

  const handleEdit = (tool: Tool) => {
    setEditingTool(tool);
    setFormData({
      tool_name: tool.tool_name || '',
      summary: tool.summary || '',
      website_url: tool.website_url || '',
      logo_url: tool.logo_url || tool.icon_url || '',
      tool_description: tool.tool_description || '',
      categories: tool.categories || emptyFormData.categories,
      description_styles: tool.description_styles || emptyFormData.description_styles,
      use_case_templates: tool.use_case_templates || [],
      display_priority: tool.display_priority || 0,
      is_verified: tool.is_verified || false,
      status: tool.status || 'published'
    });
    setActiveTab('edit');
  };

  const handleAddNew = () => {
    setEditingTool(null);
    setFormData(emptyFormData);
    setActiveTab('add');
  };

  const handleDelete = async (tool: Tool) => {
    try {
      await db.deleteTool(tool.id!);
      showToast('success', `已刪除「${tool.tool_name}」`);
      setDeleteTarget(null);
      fetchTools();
      fetchStats();
    } catch (error) {
      console.error('Delete failed:', error);
      showToast('error', '刪除失敗');
    }
  };

  const handleToggleStatus = async (tool: Tool) => {
    const newStatus: ToolStatus = tool.status === 'published' ? 'archived' : 'published';
    try {
      await db.updateTool(tool.id!, { status: newStatus });
      showToast('success', newStatus === 'published' ? `已發布「${tool.tool_name}」` : `已封存「${tool.tool_name}」`);
      fetchTools();
      fetchStats();
    } catch (error) {
      console.error('Status toggle failed:', error);
      showToast('error', '狀態切換失敗');
    }
  };

  const handleDuplicate = async (tool: Tool) => {
    try {
      const { id, created_at, updated_at, ...rest } = tool;
      await db.createTool({
        ...rest,
        tool_name: `${tool.tool_name} (副本)`,
        status: 'draft',
        popularity_score: 0
      } as any);
      showToast('success', `已複製「${tool.tool_name}」為草稿`);
      fetchTools();
      fetchStats();
    } catch (error) {
      console.error('Duplicate failed:', error);
      showToast('error', '複製失敗');
    }
  };

  const handleSubmitForm = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!formData.tool_name.trim()) {
      showToast('error', '請輸入工具名稱');
      return;
    }

    try {
      const payload: any = {
        tool_name: formData.tool_name,
        summary: formData.summary,
        website_url: formData.website_url,
        icon_url: formData.logo_url,
        tool_description: formData.tool_description,
        categories: formData.categories,
        description_styles: formData.description_styles,
        use_case_templates: formData.use_case_templates,
        display_priority: formData.display_priority,
        is_verified: formData.is_verified,
        status: formData.status,
        generation_source: 'manual'
      };

      if (activeTab === 'edit' && editingTool?.id) {
        await db.updateTool(editingTool.id, payload);
        showToast('success', `已更新「${formData.tool_name}」`);
      } else {
        await db.createTool(payload);
        showToast('success', `已新增「${formData.tool_name}」`);
      }

      setActiveTab('list');
      setEditingTool(null);
      setFormData(emptyFormData);
      fetchTools();
      fetchStats();
    } catch (error: any) {
      console.error('Save failed:', error);
      showToast('error', `儲存失敗：${error.message || '未知錯誤'}`);
    }
  };

  // ==========================================================================
  // LOGIN SCREEN
  // ==========================================================================
  if (!isAuthenticated) {
    return (
      <>
        <div className="min-h-screen pt-24 flex items-center justify-center bg-gradient-to-br from-blue-50 via-white to-cyan-50">
          <div className="bg-white p-8 rounded-2xl shadow-xl w-full max-w-md border border-gray-100">
            <div className="text-center mb-6">
              <div className="w-16 h-16 bg-gradient-to-br from-blue-500 to-cyan-500 rounded-2xl flex items-center justify-center mx-auto mb-4 shadow-lg">
                <Shield className="w-9 h-9 text-white" />
              </div>
              <h2 className="text-2xl font-bold text-gray-900">管理員登入</h2>
              <p className="text-gray-500 mt-2 text-sm">輸入密碼以存取管理後台</p>
            </div>
            <div className="space-y-4">
              <Input
                type="password"
                placeholder="請輸入密碼"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                onKeyPress={(e) => e.key === 'Enter' && handleLogin()}
              />
              <label className="flex items-center gap-2 text-sm text-gray-600 cursor-pointer">
                <input
                  type="checkbox"
                  checked={rememberMe}
                  onChange={(e) => setRememberMe(e.target.checked)}
                  className="w-4 h-4 text-blue-600 rounded focus:ring-2 focus:ring-blue-500"
                />
                <span>記住我（24小時內免登入）</span>
              </label>
              <Button onClick={handleLogin} className="w-full" icon={Shield}>登入管理後台</Button>
            </div>
          </div>
        </div>
        <ToastContainer />
      </>
    );
  }

  // ==========================================================================
  // MAIN ADMIN LAYOUT
  // ==========================================================================
  return (
    <>
      <div className="min-h-screen pt-24 pb-12 bg-gray-50">
        <div className="container mx-auto px-4 max-w-6xl">
          {/* Header */}
          <div className="flex items-center justify-between mb-6">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 bg-gradient-to-br from-blue-500 to-cyan-500 rounded-xl flex items-center justify-center shadow-md">
                <Shield className="w-6 h-6 text-white" />
              </div>
              <div>
                <h1 className="text-2xl font-bold text-gray-900">管理後台</h1>
                <p className="text-sm text-gray-500">工具內容管理系統</p>
              </div>
            </div>
            <Button variant="outline" size="sm" onClick={handleLogout} icon={LogOut}>登出</Button>
          </div>

          {/* Stats Cards */}
          <div className="grid grid-cols-2 md:grid-cols-4 gap-3 mb-6">
            <StatCard label="全部工具" value={stats.total} icon={BarChart3} color="blue" />
            <StatCard label="已發布" value={stats.published} icon={CheckCircle} color="green" />
            <StatCard label="草稿" value={stats.draft} icon={FileText} color="amber" />
            <StatCard label="已封存" value={stats.archived} icon={Archive} color="gray" />
          </div>

          {/* Tab Navigation */}
          <div className="flex gap-2 mb-6">
            <TabButton active={activeTab === 'list'} onClick={() => { setActiveTab('list'); setEditingTool(null); }} icon={List}>
              工具列表
            </TabButton>
            <TabButton active={activeTab === 'add'} onClick={handleAddNew} icon={Plus}>
              新增工具
            </TabButton>
            {activeTab === 'edit' && (
              <TabButton active={true} onClick={() => {}} icon={Edit3}>
                編輯工具
              </TabButton>
            )}
          </div>

          {/* Content Area */}
          {activeTab === 'list' && (
            <ToolListSection
              tools={tools}
              loading={loading}
              searchQuery={searchQuery}
              onSearch={handleSearch}
              statusFilter={statusFilter}
              onStatusFilterChange={handleStatusFilterChange}
              currentPage={currentPage}
              totalPages={totalPages}
              totalItems={totalItems}
              onPageChange={setCurrentPage}
              onEdit={handleEdit}
              onDelete={setDeleteTarget}
              onToggleStatus={handleToggleStatus}
              onDuplicate={handleDuplicate}
            />
          )}

          {(activeTab === 'add' || activeTab === 'edit') && (
            <ToolFormSection
              formData={formData}
              setFormData={setFormData}
              onSubmit={handleSubmitForm}
              onCancel={() => { setActiveTab('list'); setEditingTool(null); setFormData(emptyFormData); }}
              isEdit={activeTab === 'edit'}
            />
          )}
        </div>
      </div>

      {/* Delete Confirmation Modal */}
      <Modal
        isOpen={!!deleteTarget}
        onClose={() => setDeleteTarget(null)}
        title="確認刪除"
        size="sm"
      >
        <div className="space-y-4">
          <p className="text-gray-700">
            確定要刪除「<span className="font-semibold">{deleteTarget?.tool_name}</span>」嗎？
          </p>
          <p className="text-sm text-gray-500">此操作無法復原。</p>
          <div className="flex gap-3 justify-end">
            <Button variant="outline" onClick={() => setDeleteTarget(null)}>取消</Button>
            <Button onClick={() => deleteTarget && handleDelete(deleteTarget)} className="!bg-red-600 hover:!bg-red-700">
              <Trash2 className="w-4 h-4" /> 確認刪除
            </Button>
          </div>
        </div>
      </Modal>

      <ToastContainer />
    </>
  );
}

// ==========================================================================
// STAT CARD
// ==========================================================================
function StatCard({ label, value, icon: Icon, color }: { label: string; value: number; icon: any; color: string }) {
  const colors: Record<string, string> = {
    blue: 'from-blue-500 to-blue-600',
    green: 'from-green-500 to-green-600',
    amber: 'from-amber-500 to-amber-600',
    gray: 'from-gray-500 to-gray-600'
  };
  return (
    <div className="bg-white rounded-xl shadow-sm border border-gray-100 p-4 flex items-center gap-3">
      <div className={`w-10 h-10 bg-gradient-to-br ${colors[color]} rounded-lg flex items-center justify-center flex-shrink-0`}>
        <Icon className="w-5 h-5 text-white" />
      </div>
      <div>
        <p className="text-2xl font-bold text-gray-900">{value}</p>
        <p className="text-xs text-gray-500">{label}</p>
      </div>
    </div>
  );
}

// ==========================================================================
// TAB BUTTON
// ==========================================================================
function TabButton({ active, onClick, icon: Icon, children }: { active: boolean; onClick: () => void; icon: any; children: React.ReactNode }) {
  return (
    <button
      onClick={onClick}
      className={`inline-flex items-center gap-2 px-4 py-2 rounded-lg font-medium text-sm transition-all ${
        active
          ? 'bg-blue-600 text-white shadow-md'
          : 'bg-white text-gray-600 hover:bg-gray-50 border border-gray-200'
      }`}
    >
      <Icon className="w-4 h-4" />
      {children}
    </button>
  );
}

// ==========================================================================
// TOOL LIST SECTION
// ==========================================================================
function ToolListSection({
  tools, loading, searchQuery, onSearch, statusFilter, onStatusFilterChange,
  currentPage, totalPages, totalItems, onPageChange,
  onEdit, onDelete, onToggleStatus, onDuplicate
}: {
  tools: Tool[];
  loading: boolean;
  searchQuery: string;
  onSearch: (v: string) => void;
  statusFilter: StatusFilter;
  onStatusFilterChange: (s: StatusFilter) => void;
  currentPage: number;
  totalPages: number;
  totalItems: number;
  onPageChange: (p: number) => void;
  onEdit: (t: Tool) => void;
  onDelete: (t: Tool) => void;
  onToggleStatus: (t: Tool) => void;
  onDuplicate: (t: Tool) => void;
}) {
  const statusBadge = (status?: string) => {
    switch (status) {
      case 'published': return <Badge variant="primary" className="!bg-green-100 !text-green-700 !border-green-200">已發布</Badge>;
      case 'draft': return <Badge variant="primary" className="!bg-amber-100 !text-amber-700 !border-amber-200">草稿</Badge>;
      case 'archived': return <Badge variant="secondary">已封存</Badge>;
      default: return <Badge variant="primary" className="!bg-green-100 !text-green-700 !border-green-200">已發布</Badge>;
    }
  };

  return (
    <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
      {/* Search & Filter Bar */}
      <div className="p-4 border-b border-gray-100 flex flex-col sm:flex-row gap-3">
        <div className="flex-1">
          <Input
            value={searchQuery}
            onChange={(e) => onSearch(e.target.value)}
            placeholder="搜尋工具名稱或簡介..."
            icon={Search}
          />
        </div>
        <div className="flex gap-2">
          {(['all', 'published', 'draft', 'archived'] as StatusFilter[]).map(s => (
            <button
              key={s}
              onClick={() => onStatusFilterChange(s)}
              className={`px-3 py-2 rounded-lg text-sm font-medium transition-all whitespace-nowrap ${
                statusFilter === s
                  ? 'bg-blue-600 text-white'
                  : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
              }`}
            >
              {s === 'all' ? '全部' : s === 'published' ? '已發布' : s === 'draft' ? '草稿' : '已封存'}
            </button>
          ))}
        </div>
      </div>

      {/* Table */}
      <div className="overflow-x-auto">
        <table className="w-full">
          <thead>
            <tr className="bg-gray-50 border-b border-gray-100">
              <th className="text-left px-4 py-3 text-xs font-semibold text-gray-500 uppercase">工具名稱</th>
              <th className="text-left px-4 py-3 text-xs font-semibold text-gray-500 uppercase hidden md:table-cell">簡介</th>
              <th className="text-left px-4 py-3 text-xs font-semibold text-gray-500 uppercase">狀態</th>
              <th className="text-left px-4 py-3 text-xs font-semibold text-gray-500 uppercase hidden sm:table-cell">更新時間</th>
              <th className="text-right px-4 py-3 text-xs font-semibold text-gray-500 uppercase">操作</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-100">
            {loading ? (
              <tr><td colSpan={5} className="text-center py-12 text-gray-400">載入中...</td></tr>
            ) : tools.length === 0 ? (
              <tr><td colSpan={5} className="text-center py-12 text-gray-400">找不到工具</td></tr>
            ) : (
              tools.map(tool => (
                <tr key={tool.id} className="hover:bg-gray-50 transition-colors">
                  <td className="px-4 py-3">
                    <div className="flex items-center gap-3">
                      <div className="w-9 h-9 rounded-lg bg-gray-100 flex items-center justify-center overflow-hidden flex-shrink-0">
                        {(tool.logo_url || tool.icon_url) ? (
                          <img src={tool.logo_url || tool.icon_url} alt={tool.tool_name} className="w-full h-full object-contain" onError={(e) => { (e.target as HTMLImageElement).style.display = 'none'; }} />
                        ) : (
                          <FileText className="w-4 h-4 text-gray-400" />
                        )}
                      </div>
                      <span className="font-medium text-gray-900 text-sm">{tool.tool_name}</span>
                    </div>
                  </td>
                  <td className="px-4 py-3 hidden md:table-cell">
                    <p className="text-sm text-gray-500 line-clamp-1 max-w-xs">{tool.summary}</p>
                  </td>
                  <td className="px-4 py-3">{statusBadge(tool.status)}</td>
                  <td className="px-4 py-3 hidden sm:table-cell">
                    <span className="text-xs text-gray-400">
                      {tool.updated_at ? new Date(tool.updated_at).toLocaleDateString('zh-TW') : '-'}
                    </span>
                  </td>
                  <td className="px-4 py-3">
                    <div className="flex items-center justify-end gap-1">
                      <ActionButton onClick={() => onEdit(tool)} icon={Edit3} title="編輯" />
                      <ActionButton onClick={() => onDuplicate(tool)} icon={Copy} title="複製" />
                      <ActionButton
                        onClick={() => onToggleStatus(tool)}
                        icon={tool.status === 'published' ? EyeOff : Eye}
                        title={tool.status === 'published' ? '封存' : '發布'}
                      />
                      <ActionButton onClick={() => onDelete(tool)} icon={Trash2} title="刪除" danger />
                    </div>
                  </td>
                </tr>
              ))
            )}
          </tbody>
        </table>
      </div>

      {/* Pagination */}
      {totalPages > 1 && (
        <div className="px-4 py-3 border-t border-gray-100 flex items-center justify-between">
          <p className="text-sm text-gray-500">共 {totalItems} 項</p>
          <div className="flex gap-1">
            <button
              onClick={() => onPageChange(currentPage - 1)}
              disabled={currentPage === 1}
              className="p-2 rounded-lg hover:bg-gray-100 disabled:opacity-30 disabled:cursor-not-allowed transition-colors"
            >
              <ChevronLeft className="w-4 h-4" />
            </button>
            <span className="px-3 py-2 text-sm text-gray-600">{currentPage} / {totalPages}</span>
            <button
              onClick={() => onPageChange(currentPage + 1)}
              disabled={currentPage === totalPages}
              className="p-2 rounded-lg hover:bg-gray-100 disabled:opacity-30 disabled:cursor-not-allowed transition-colors"
            >
              <ChevronRight className="w-4 h-4" />
            </button>
          </div>
        </div>
      )}
    </div>
  );
}

// ==========================================================================
// ACTION BUTTON (small icon button in table)
// ==========================================================================
function ActionButton({ onClick, icon: Icon, title, danger }: { onClick: () => void; icon: any; title: string; danger?: boolean }) {
  return (
    <button
      onClick={onClick}
      title={title}
      className={`p-1.5 rounded-lg transition-colors ${
        danger ? 'text-gray-400 hover:text-red-600 hover:bg-red-50' : 'text-gray-400 hover:text-blue-600 hover:bg-blue-50'
      }`}
    >
      <Icon className="w-4 h-4" />
    </button>
  );
}

// ==========================================================================
// TOOL FORM SECTION (Add / Edit)
// ==========================================================================
function ToolFormSection({
  formData, setFormData, onSubmit, onCancel, isEdit
}: {
  formData: typeof emptyFormData;
  setFormData: React.Dispatch<React.SetStateAction<typeof emptyFormData>>;
  onSubmit: (e: React.FormEvent) => void;
  onCancel: () => void;
  isEdit: boolean;
}) {
  const update = (field: string, value: any) => {
    setFormData(prev => ({ ...prev, [field]: value }));
  };

  const updateCategory = (field: string, value: string) => {
    setFormData(prev => {
      const arr = prev.categories[field as keyof typeof prev.categories] as string[];
      if (Array.isArray(arr)) {
        const newArr = arr.includes(value) ? arr.filter(v => v !== value) : [...arr, value];
        return { ...prev, categories: { ...prev.categories, [field]: newArr } };
      } else {
        return { ...prev, categories: { ...prev.categories, [field]: value } };
      }
    });
  };

  const addUseCase = () => {
    setFormData(prev => ({
      ...prev,
      use_case_templates: [...prev.use_case_templates, { goal: '', method: '', tool_stack: [], steps: [] }]
    }));
  };

  const updateUseCase = (index: number, field: string, value: any) => {
    setFormData(prev => {
      const cases = [...prev.use_case_templates];
      cases[index] = { ...cases[index], [field]: value };
      return { ...prev, use_case_templates: cases };
    });
  };

  const removeUseCase = (index: number) => {
    setFormData(prev => ({
      ...prev,
      use_case_templates: prev.use_case_templates.filter((_, i) => i !== index)
    }));
  };

  return (
    <form onSubmit={onSubmit} className="space-y-6">
      {/* Basic Info */}
      <FormCard title="基本資訊">
        <FormField label="工具名稱" required>
          <Input value={formData.tool_name} onChange={e => update('tool_name', e.target.value)} required placeholder="e.g. OpenAI, Notion" />
        </FormField>
        <FormField label="簡介 (Summary)">
          <textarea
            className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 min-h-[80px] text-sm"
            value={formData.summary}
            onChange={e => update('summary', e.target.value)}
            placeholder="一句話描述這個工具"
          />
        </FormField>
        <FormField label="詳細描述 (Description)">
          <textarea
            className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 min-h-[100px] text-sm"
            value={formData.tool_description}
            onChange={e => update('tool_description', e.target.value)}
            placeholder="更詳細的工具描述"
          />
        </FormField>
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <FormField label="網站連結">
            <Input value={formData.website_url} onChange={e => update('website_url', e.target.value)} placeholder="https://..." />
          </FormField>
          <FormField label="Logo 連結">
            <Input value={formData.logo_url} onChange={e => update('logo_url', e.target.value)} placeholder="https://.../logo.png" />
          </FormField>
        </div>
      </FormCard>

      {/* Categories */}
      <FormCard title="分類標籤">
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <TagInput label="Purpose (目的)" values={formData.categories.purpose} onChange={v => updateCategory('purpose', v)} placeholder="輸入後按 Enter" />
          <TagInput label="Functional Role (功能角色)" values={formData.categories.functional_role} onChange={v => updateCategory('functional_role', v)} placeholder="輸入後按 Enter" />
          <TagInput label="Tech Layer (技術層)" values={formData.categories.tech_layer} onChange={v => updateCategory('tech_layer', v)} placeholder="輸入後按 Enter" />
          <TagInput label="Data Flow Role" values={formData.categories.data_flow_role} onChange={v => updateCategory('data_flow_role', v)} placeholder="輸入後按 Enter" />
          <TagInput label="Application Field (應用領域)" values={formData.categories.application_field} onChange={v => updateCategory('application_field', v)} placeholder="輸入後按 Enter" />
          <TagInput label="Common Pairings (常見組合)" values={formData.categories.common_pairings} onChange={v => updateCategory('common_pairings', v)} placeholder="輸入後按 Enter" />
        </div>
        <FormField label="難度">
          <select
            value={formData.categories.difficulty}
            onChange={e => setFormData(prev => ({ ...prev, categories: { ...prev.categories, difficulty: e.target.value } }))}
            className="w-full p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 text-sm bg-white"
          >
            <option value="beginner">Beginner</option>
            <option value="intermediate">Intermediate</option>
            <option value="advanced">Advanced</option>
          </select>
        </FormField>
      </FormCard>

      {/* Description Styles */}
      <FormCard title="描述風格">
        <FormField label="Encyclopedia (百科式)">
          <textarea
            className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 min-h-[80px] text-sm"
            value={formData.description_styles.encyclopedia}
            onChange={e => setFormData(prev => ({ ...prev, description_styles: { ...prev.description_styles, encyclopedia: e.target.value } }))}
            placeholder="客觀、中立的百科全書式描述"
          />
        </FormField>
        <FormField label="Guide (指南式)">
          <textarea
            className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 min-h-[80px] text-sm"
            value={formData.description_styles.guide}
            onChange={e => setFormData(prev => ({ ...prev, description_styles: { ...prev.description_styles, guide: e.target.value } }))}
            placeholder="step-by-step 指南式描述"
          />
        </FormField>
        <FormField label="Strategy (策略式)">
          <textarea
            className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 min-h-[80px] text-sm"
            value={formData.description_styles.strategy}
            onChange={e => setFormData(prev => ({ ...prev, description_styles: { ...prev.description_styles, strategy: e.target.value } }))}
            placeholder="策略建議式描述"
          />
        </FormField>
        <TagInput
          label="Inspiration (靈感啟發)"
          values={formData.description_styles.inspiration}
          onChange={v => setFormData(prev => {
            const arr = prev.description_styles.inspiration;
            const newArr = arr.includes(v) ? arr.filter(x => x !== v) : [...arr, v];
            return { ...prev, description_styles: { ...prev.description_styles, inspiration: newArr } };
          })}
          placeholder="輸入靈感要點後按 Enter"
        />
      </FormCard>

      {/* Use Case Templates */}
      <FormCard title="使用案例模板">
        {formData.use_case_templates.map((uc, index) => (
          <div key={index} className="border border-gray-200 rounded-lg p-4 space-y-3 relative">
            <div className="flex items-center justify-between">
              <span className="text-sm font-medium text-gray-700">案例 {index + 1}</span>
              <button type="button" onClick={() => removeUseCase(index)} className="text-gray-400 hover:text-red-500">
                <Trash2 className="w-4 h-4" />
              </button>
            </div>
            <FormField label="Goal (目標)">
              <Input value={uc.goal || ''} onChange={e => updateUseCase(index, 'goal', e.target.value)} placeholder="使用者想達成什麼？" />
            </FormField>
            <FormField label="Method (方法)">
              <Input value={uc.method || ''} onChange={e => updateUseCase(index, 'method', e.target.value)} placeholder="如何達成？" />
            </FormField>
            <TagInput
              label="Tool Stack (工具組合)"
              values={uc.tool_stack || []}
              onChange={v => {
                const arr = uc.tool_stack || [];
                const newArr = arr.includes(v) ? arr.filter(x => x !== v) : [...arr, v];
                updateUseCase(index, 'tool_stack', newArr);
              }}
              placeholder="輸入工具名稱後按 Enter"
            />
            <FormField label="Steps (步驟)">
              <textarea
                className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 min-h-[80px] text-sm"
                value={(uc.steps || []).join('\n')}
                onChange={e => updateUseCase(index, 'steps', e.target.value.split('\n').filter(s => s.trim()))}
                placeholder="每行一個步驟"
              />
            </FormField>
          </div>
        ))}
        <button
          type="button"
          onClick={addUseCase}
          className="w-full py-2 border-2 border-dashed border-gray-300 rounded-lg text-sm text-gray-500 hover:border-blue-400 hover:text-blue-500 transition-colors"
        >
          + 新增使用案例
        </button>
      </FormCard>

      {/* Settings */}
      <FormCard title="發布設定">
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <FormField label="狀態">
            <select
              value={formData.status}
              onChange={e => update('status', e.target.value as ToolStatus)}
              className="w-full p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 text-sm bg-white"
            >
              <option value="draft">草稿 (Draft)</option>
              <option value="published">發布 (Published)</option>
              <option value="archived">封存 (Archived)</option>
            </select>
          </FormField>
          <FormField label="顯示優先順序">
            <Input
              type="number"
              value={formData.display_priority}
              onChange={e => update('display_priority', parseInt(e.target.value) || 0)}
            />
          </FormField>
        </div>
        <label className="flex items-center gap-2 text-sm text-gray-600 cursor-pointer">
          <input
            type="checkbox"
            checked={formData.is_verified}
            onChange={e => update('is_verified', e.target.checked)}
            className="w-4 h-4 text-blue-600 rounded focus:ring-2 focus:ring-blue-500"
          />
          <span>已驗證 (Verified)</span>
        </label>
      </FormCard>

      {/* Action Buttons */}
      <div className="flex gap-3 justify-end sticky bottom-4 bg-white p-4 rounded-xl shadow-lg border border-gray-100">
        <Button variant="outline" onClick={onCancel}>取消</Button>
        <Button type="submit" icon={Save}>{isEdit ? '更新工具' : '儲存工具'}</Button>
      </div>
    </form>
  );
}

// ==========================================================================
// FORM CARD (section container)
// ==========================================================================
function FormCard({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <div className="bg-white rounded-xl shadow-sm border border-gray-100 p-6">
      <h3 className="text-base font-semibold text-gray-900 mb-4 pb-2 border-b border-gray-100">{title}</h3>
      <div className="space-y-4">{children}</div>
    </div>
  );
}

// ==========================================================================
// FORM FIELD
// ==========================================================================
function FormField({ label, required, children }: { label: string; required?: boolean; children: React.ReactNode }) {
  return (
    <div>
      <label className="block text-sm font-medium text-gray-700 mb-1">
        {label} {required && <span className="text-red-500">*</span>}
      </label>
      {children}
    </div>
  );
}

// ==========================================================================
// TAG INPUT (multi-value input with Enter to add)
// ==========================================================================
function TagInput({ label, values, onChange, placeholder }: { label: string; values: string[]; onChange: (v: string) => void; placeholder?: string }) {
  const [input, setInput] = useState('');

  const handleKeyDown = (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === 'Enter' && input.trim()) {
      e.preventDefault();
      onChange(input.trim());
      setInput('');
    }
  };

  return (
    <div>
      <label className="block text-sm font-medium text-gray-700 mb-1">{label}</label>
      <div className="flex flex-wrap gap-1.5 mb-2">
        {values.map((v, i) => (
          <span key={i} className="inline-flex items-center gap-1 px-2 py-1 bg-blue-50 text-blue-700 rounded-md text-xs border border-blue-100">
            {v}
            <button type="button" onClick={() => onChange(v)} className="text-blue-400 hover:text-blue-600">
              <X className="w-3 h-3" />
            </button>
          </span>
        ))}
      </div>
      <Input
        value={input}
        onChange={e => setInput(e.target.value)}
        onKeyDown={handleKeyDown}
        placeholder={placeholder}
      />
    </div>
  );
}


