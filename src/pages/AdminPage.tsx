import { useState, useEffect } from 'react';
import { Shield, Plus, Save, LogOut } from 'lucide-react';
import { Button } from '../components/ui/Button';
import { Input } from '../components/ui/Input';
import { db } from '../lib/database';
import { storage } from '../lib/localStorage';

export function AdminPage() {
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [password, setPassword] = useState('');
  const [rememberMe, setRememberMe] = useState(false);
  const [formData, setFormData] = useState({
    tool_name: '',
    summary: '',
    website_url: '',
    logo_url: '',
    categories: {
      functional_role: [],
      tech_layer: [],
      difficulty: 'intermediate'
    }
  });

  useEffect(() => {
    if (storage.isAdminAuthenticated()) {
      setIsAuthenticated(true);
    }
  }, []);

  const handleLogin = () => {
    if (password === 'admin123') {
      setIsAuthenticated(true);

      if (rememberMe) {
        storage.setAdminToken('admin_session', 24);
      }
    } else {
      alert('密碼錯誤');
    }
  };

  const handleLogout = () => {
    storage.clearAdminToken();
    setIsAuthenticated(false);
    setPassword('');
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      await db.createTool(formData);
      alert('✅ 工具新增成功！');
      setFormData({ ...formData, tool_name: '', summary: '' });
    } catch (error) {
      alert('❌ 新增失敗，請檢查 Console');
      console.error(error);
    }
  };

  if (!isAuthenticated) {
    return (
      <div className="min-h-screen pt-24 flex items-center justify-center bg-gradient-to-br from-blue-50 via-white to-purple-50">
        <div className="bg-white p-8 rounded-xl shadow-lg w-full max-w-md">
          <div className="text-center mb-6">
            <div className="w-16 h-16 bg-gradient-sky rounded-2xl flex items-center justify-center mx-auto mb-4">
              <Shield className="w-10 h-10 text-white" />
            </div>
            <h2 className="text-2xl font-bold text-gray-900">管理員登入</h2>
            <p className="text-gray-600 mt-2 text-sm">輸入密碼以存取管理面板</p>
          </div>

          <div className="space-y-4">
            <Input
              type="password"
              placeholder="請輸入密碼"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              onKeyPress={(e) => e.key === 'Enter' && handleLogin()}
            />

            <label className="flex items-center gap-2 text-sm text-gray-700 cursor-pointer">
              <input
                type="checkbox"
                checked={rememberMe}
                onChange={(e) => setRememberMe(e.target.checked)}
                className="w-4 h-4 text-blue-600 rounded focus:ring-2 focus:ring-blue-500"
              />
              <span>記住我（24小時內免登入）</span>
            </label>

            <Button onClick={handleLogin} className="w-full">
              登入管理面板
            </Button>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen pt-24 pb-12 bg-gray-50">
      <div className="container mx-auto px-4 max-w-2xl">
        <div className="bg-white p-8 rounded-xl shadow-sm">
          <div className="flex items-center justify-between mb-6">
            <h1 className="text-2xl font-bold text-gray-900 flex items-center gap-2">
              <Plus className="w-6 h-6 text-indigo-600" />
              新增工具 (Admin Mode)
            </h1>
            <Button variant="outline" onClick={handleLogout} icon={LogOut}>
              登出
            </Button>
          </div>

          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">工具名稱 *</label>
              <Input value={formData.tool_name} onChange={e => setFormData({...formData, tool_name: e.target.value})} required />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">簡介 (Summary) *</label>
              <textarea 
                className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 min-h-[100px]"
                value={formData.summary}
                onChange={e => setFormData({...formData, summary: e.target.value})}
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">網站連結</label>
              <Input value={formData.website_url} onChange={e => setFormData({...formData, website_url: e.target.value})} />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Logo 連結</label>
              <Input value={formData.logo_url} onChange={e => setFormData({...formData, logo_url: e.target.value})} />
            </div>
            <div className="pt-4">
              <Button type="submit" className="w-full" icon={Save}>儲存到資料庫</Button>
            </div>
          </form>
        </div>
      </div>
    </div>
  );
}