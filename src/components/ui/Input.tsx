import { LucideIcon } from 'lucide-react';

interface InputProps {
  value: string;
  onChange: (value: string) => void;
  placeholder?: string;
  icon?: LucideIcon;
  className?: string;
  type?: string;
}

export function Input({
  value,
  onChange,
  placeholder = '',
  icon: Icon,
  className = '',
  type = 'text'
}: InputProps) {
  return (
    <div className={`relative ${className}`}>
      {Icon && (
        <div className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400">
          <Icon size={20} />
        </div>
      )}
      <input
        type={type}
        value={value}
        onChange={(e) => onChange(e.target.value)}
        placeholder={placeholder}
        className={`w-full rounded-lg border border-gray-300 bg-white px-4 py-2.5 text-gray-900 placeholder-gray-400 transition-all focus:border-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500/20 ${
          Icon ? 'pl-10' : ''
        }`}
      />
    </div>
  );
}
