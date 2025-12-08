import { useState } from 'react';
import { Shield, Plus, Save } from 'lucide-react';
import { Button } from '../components/ui/Button';
import { Input } from '../components/ui/Input';
import { db } from '../lib/database';

export function AdminPage() {
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [password, setPassword] = useState('');
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

  const handleLogin = () => {
    if (password === 'admin123') { // 簡易密碼鎖
      setIsAuthenticated(true);
    } else {
      alert('密碼錯誤');
    }
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
      <div className="min-h-screen pt-24 flex items-center justify-center bg-gray-50">
        <div className="bg-white p-8 rounded-xl shadow-md w-full max-w-md text-center">
          <Shield className="w-12 h-12 text-indigo-600 mx-auto mb-4" />
          <h2 className="text-2xl font-bold mb-6">管理員登入</h2>
          <Input type="password" placeholder="密碼 (admin123)" value={password} onChange={(e) => setPassword(e.target.value)} className="mb-4" />
          <Button onClick={handleLogin} className="w-full">登入</Button>
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
            <Button variant="outline" onClick={() => setIsAuthenticated(false)}>登出</Button>
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