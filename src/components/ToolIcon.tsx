import { Box } from 'lucide-react';

interface ToolIconProps {
  iconUrl?: string;
  toolName: string;
  size?: number;
  className?: string;
  backgroundColor?: string;
}

export function ToolIcon({
  iconUrl,
  toolName,
  size = 24,
  className = '',
  backgroundColor = '#14b8a6'
}: ToolIconProps) {
  if (iconUrl) {
    return (
      <img
        src={iconUrl}
        alt={`${toolName} icon`}
        className={`${className}`}
        style={{ width: size, height: size }}
        onError={(e) => {
          const target = e.target as HTMLImageElement;
          target.style.display = 'none';
          const parent = target.parentElement;
          if (parent) {
            const fallbackIcon = document.createElement('div');
            fallbackIcon.className = 'flex items-center justify-center';
            fallbackIcon.innerHTML = `<svg width="${size}" height="${size}" viewBox="0 0 24 24" fill="none" stroke="${backgroundColor}" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path><polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline><line x1="12" y1="22.08" x2="12" y2="12"></line></svg>`;
            parent.appendChild(fallbackIcon);
          }
        }}
      />
    );
  }

  return (
    <Box
      size={size}
      style={{ color: backgroundColor }}
      className={className}
    />
  );
}
