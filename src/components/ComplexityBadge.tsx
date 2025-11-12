import { Feather, Cog, Brain } from 'lucide-react';
import { motion } from 'framer-motion';
import { useState } from 'react';
import type { SkillLevel } from '../types';

interface ComplexityBadgeProps {
  level: SkillLevel;
  language: 'en' | 'zh-TW';
  showHint?: boolean;
  className?: string;
}

const complexityConfig = {
  beginner: {
    icon: Feather,
    label: {
      en: 'Foundation Experience',
      zh: '入門體驗'
    },
    hint: {
      en: 'Perfect for quick hands-on start with immediate results',
      zh: '適合想快速上手、立即看到成果的探索者'
    },
    color: 'bg-green-100 text-green-700 border-green-200',
    hoverColor: 'group-hover:bg-green-200 group-hover:border-green-300'
  },
  intermediate: {
    icon: Cog,
    label: {
      en: 'Integrated Flow',
      zh: '流程整合'
    },
    hint: {
      en: 'Experience tool integration and workflow automation',
      zh: '涉及多個工具串接，體驗數據流與自動化邏輯'
    },
    color: 'bg-amber-100 text-amber-700 border-amber-200',
    hoverColor: 'group-hover:bg-amber-200 group-hover:border-amber-300'
  },
  advanced: {
    icon: Brain,
    label: {
      en: 'Systemic Design',
      zh: '系統設計'
    },
    hint: {
      en: 'Challenge yourself with full system architecture and optimization',
      zh: '挑戰完整系統架構，探索優化與擴展思維'
    },
    color: 'bg-blue-100 text-blue-700 border-blue-200',
    hoverColor: 'group-hover:bg-blue-200 group-hover:border-blue-300'
  }
};

export function ComplexityBadge({ level, language, showHint = false, className = '' }: ComplexityBadgeProps) {
  const [isHovered, setIsHovered] = useState(false);
  const config = complexityConfig[level];
  const Icon = config.icon;
  const label = language === 'zh-TW' ? config.label.zh : config.label.en;
  const hint = language === 'zh-TW' ? config.hint.zh : config.hint.en;

  return (
    <div
      className={`inline-block group relative ${className}`}
      onMouseEnter={() => setIsHovered(true)}
      onMouseLeave={() => setIsHovered(false)}
    >
      <motion.div
        className={`flex items-center gap-1.5 px-3 py-1.5 rounded-full text-sm font-medium border ${config.color} ${config.hoverColor} transition-all duration-300`}
        whileHover={{ scale: 1.05 }}
        whileTap={{ scale: 0.95 }}
      >
        <motion.div
          animate={isHovered ? { rotate: [0, -15, 15, 0] } : {}}
          transition={{ duration: 0.5 }}
        >
          <Icon className="w-4 h-4" />
        </motion.div>
        <span>{label}</span>
      </motion.div>

      {showHint && (
        <motion.div
          initial={{ opacity: 0, y: 10, scale: 0.9 }}
          animate={isHovered ? { opacity: 1, y: 0, scale: 1 } : { opacity: 0, y: 10, scale: 0.9 }}
          transition={{ duration: 0.2 }}
          className="absolute z-10 bottom-full left-1/2 transform -translate-x-1/2 mb-2 w-64 px-3 py-2 text-sm bg-gray-900 text-white rounded-lg shadow-xl pointer-events-none"
        >
          {hint}
          <div className="absolute top-full left-1/2 transform -translate-x-1/2 -mt-1 border-4 border-transparent border-t-gray-900"></div>
        </motion.div>
      )}
    </div>
  );
}
