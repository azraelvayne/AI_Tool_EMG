import { LucideIcon } from 'lucide-react';

interface BadgeProps {
  children: React.ReactNode;
  color?: string;
  icon?: LucideIcon;
  size?: 'sm' | 'md' | 'lg';
  onClick?: () => void;
  className?: string;
}

export function Badge({ children, color = '#3B82F6', icon: Icon, size = 'md', onClick, className = '' }: BadgeProps) {
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

  const hasCustomColors = className.includes('bg-') || className.includes('text-');

  return (
    <span
      className={`inline-flex items-center gap-1.5 rounded-full font-medium transition-all ${sizeClasses[size]} ${onClick ? 'cursor-pointer hover:scale-105' : ''} ${className}`}
      style={hasCustomColors ? undefined : {
        backgroundColor: lightenColor(color, 200),
        color: color,
        border: `1px solid ${lightenColor(color, 150)}`
      }}
      onClick={onClick}
    >
      {Icon && <Icon size={size === 'sm' ? 12 : size === 'md' ? 14 : 16} />}
      {children}
    </span>
  );
}
