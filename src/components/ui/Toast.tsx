import { useEffect, useState } from 'react';
import { createPortal } from 'react-dom';
import { CheckCircle, AlertCircle, Info, X } from 'lucide-react';

export type ToastType = 'success' | 'error' | 'info';

export interface ToastMessage {
  id: string;
  type: ToastType;
  message: string;
}

let toastIdCounter = 0;
let externalAddToast: ((type: ToastType, message: string) => void) | null = null;

export function showToast(type: ToastType, message: string) {
  if (externalAddToast) {
    externalAddToast(type, message);
  }
}

export function ToastContainer() {
  const [toasts, setToasts] = useState<ToastMessage[]>([]);

  useEffect(() => {
    externalAddToast = (type: ToastType, message: string) => {
      const id = `toast-${++toastIdCounter}`;
      setToasts(prev => [...prev, { id, type, message }]);
      setTimeout(() => {
        setToasts(prev => prev.filter(t => t.id !== id));
      }, 3500);
    };
    return () => { externalAddToast = null; };
  }, []);

  const removeToast = (id: string) => {
    setToasts(prev => prev.filter(t => t.id !== id));
  };

  if (toasts.length === 0) return null;

  return createPortal(
    <div className="fixed bottom-6 right-6 z-[100] flex flex-col gap-3 pointer-events-none">
      {toasts.map(toast => {
        const config = {
          success: { icon: CheckCircle, bg: 'bg-green-50', border: 'border-green-200', text: 'text-green-800', iconColor: 'text-green-500' },
          error: { icon: AlertCircle, bg: 'bg-red-50', border: 'border-red-200', text: 'text-red-800', iconColor: 'text-red-500' },
          info: { icon: Info, bg: 'bg-blue-50', border: 'border-blue-200', text: 'text-blue-800', iconColor: 'text-blue-500' }
        }[toast.type];

        const Icon = config.icon;

        return (
          <div
            key={toast.id}
            className={`${config.bg} ${config.border} ${config.text} border rounded-xl shadow-lg px-4 py-3 flex items-center gap-3 max-w-sm pointer-events-auto animate-in slide-in-from-bottom-5 fade-in duration-300`}
          >
            <Icon className={`w-5 h-5 ${config.iconColor} flex-shrink-0`} />
            <span className="text-sm font-medium flex-1">{toast.message}</span>
            <button
              onClick={() => removeToast(toast.id)}
              className="text-gray-400 hover:text-gray-600 transition-colors flex-shrink-0"
            >
              <X className="w-4 h-4" />
            </button>
          </div>
        );
      })}
    </div>,
    document.body
  );
}
