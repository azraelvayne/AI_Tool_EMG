import { Video as LucideIcon } from 'lucide-react';
import { ChangeEvent, KeyboardEvent } from 'react';

interface InputProps {
  value: string;
  onChange: (e: ChangeEvent<HTMLInputElement>) => void;
  placeholder?: string;
  icon?: LucideIcon;
  className?: string;
  type?: string;
  onKeyPress?: (e: KeyboardEvent<HTMLInputElement>) => void;
  required?: boolean;
  disabled?: boolean;
  name?: string;
  id?: string;
  autoComplete?: string;
}

export function Input({
  value,
  onChange,
  placeholder = '',
  icon: Icon,
  className = '',
  type = 'text',
  onKeyPress,
  required = false,
  disabled = false,
  name,
  id,
  autoComplete
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
        onChange={onChange}
        onKeyPress={onKeyPress}
        placeholder={placeholder}
        required={required}
        disabled={disabled}
        name={name}
        id={id}
        autoComplete={autoComplete}
        className={`w-full rounded-lg border border-gray-300 bg-white px-4 py-2.5 text-gray-900 placeholder-gray-400 transition-all focus:border-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500/20 disabled:bg-gray-100 disabled:cursor-not-allowed ${
          Icon ? 'pl-10' : ''
        }`}
      />
    </div>
  );
}
