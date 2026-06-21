import { Video as LucideIcon } from 'lucide-react';

interface BadgeProps {
  children: React.ReactNode;
  color?: string;
  variant?: 'primary' | 'secondary' | 'outline' | 'ghost';
  icon?: LucideIcon;
  size?: 'sm' | 'md' | 'lg';
  onClick?: () => void;
  className?: string;
}

export function Badge({ children, color, variant, icon: Icon, size = 'md', onClick, className = '' }: BadgeProps) {
  const sizeClasses = {
    sm: 'text-xs px-2 py-0.5',
    md: 'text-sm px-3 py-1',
    lg: 'text-base px-4 py-1.5'
  };

  const lightenColor = (hex: string, amount: number) => {
    const num = parseInt(hex.slice(1), 16);
    const r = Math.min(255, ((num >> 16) & 255) + amount);
    const g = Math.min(255, ((num >> 8) & 255) + amount);
    const b = Math.min(255, (num & 255) + amount);
    return `rgb(${r}, ${g}, ${b})`;
  };

  const variantClasses = {
    primary: 'bg-blue-100 text-blue-700 border border-blue-200',
    secondary: 'bg-gray-100 text-gray-700 border border-gray-200',
    outline: 'bg-transparent border border-current',
    ghost: 'bg-transparent'
  };

  const hasCustomColors = className.includes('bg-') || className.includes('text-');
  const hasVariant = variant !== undefined;

  return (
    <span
      className={`inline-flex items-center gap-1.5 rounded-full font-medium transition-all ${sizeClasses[size]} ${onClick ? 'cursor-pointer hover:scale-105' : ''} ${hasVariant ? variantClasses[variant] : ''} ${className}`}
      style={!hasVariant && !hasCustomColors ? {
        backgroundColor: lightenColor(color || '#3B82F6', 200),
        color: color || '#3B82F6',
        border: `1px solid ${lightenColor(color || '#3B82F6', 150)}`
      } : undefined}
      onClick={onClick}
    >
      {Icon && <Icon size={size === 'sm' ? 12 : size === 'md' ? 14 : 16} />}
      {children}
    </span>
  );
}
