import { Clock, TrendingUp, Zap, Sparkles } from 'lucide-react';
import { motion } from 'framer-motion';
import { useTranslation } from 'react-i18next';
import { Card } from './ui/Card';
import { Badge } from './ui/Badge';
import { ComplexityBadge } from './ComplexityBadge';
import type { Inspiration } from '../types';

interface InspirationCardProps {
  inspiration: Inspiration;
  language: 'en' | 'zh-TW';
  onClick: () => void;
}

export function InspirationCard({ inspiration, language, onClick }: InspirationCardProps) {
  const { t } = useTranslation();
  const title = language === 'zh-TW' ? inspiration.title_zh_tw : inspiration.title_en;
  const description = language === 'zh-TW' ? inspiration.description_zh_tw : inspiration.description_en;

  return (
    <motion.div
      whileHover={{ y: -6, scale: 1.015 }}
      whileTap={{ scale: 0.99 }}
      transition={{ type: 'spring', stiffness: 350, damping: 25 }}
    >
      <Card
        onClick={onClick}
        className="cursor-pointer hover:shadow-xl transition-all duration-300 group overflow-hidden relative"
      >
        <div className="absolute top-0 right-0 w-32 h-32 bg-gradient-to-br from-purple-100 to-blue-100 rounded-full -mr-16 -mt-16 opacity-0 group-hover:opacity-100 transition-opacity duration-500" />
        <motion.div
          className="absolute top-4 right-4 opacity-0 group-hover:opacity-100"
          initial={{ scale: 0, rotate: -180 }}
          whileHover={{ scale: 1, rotate: 0 }}
          transition={{ duration: 0.3 }}
        >
          <Sparkles className="w-5 h-5 text-purple-400" />
        </motion.div>

        <div className="p-6 relative">
          <div className="flex items-start justify-between mb-3">
            <h3 className="text-lg font-bold text-gray-900 group-hover:text-purple-600 transition-colors flex-1 pr-2">
              {title}
            </h3>
            <ComplexityBadge level={inspiration.difficulty} language={language} />
          </div>

          <p className="text-gray-600 text-sm leading-relaxed mb-4 line-clamp-2">
            {description}
          </p>

          <div className="flex items-center gap-4 text-sm text-gray-500 mb-4">
            <motion.div
              className="flex items-center gap-1"
              whileHover={{ scale: 1.05 }}
            >
              <Clock className="w-4 h-4 text-blue-500" />
              <span>{inspiration.estimated_time}</span>
            </motion.div>
            <motion.div
              className="flex items-center gap-1"
              whileHover={{ scale: 1.05 }}
            >
              <Zap className="w-4 h-4 text-yellow-500" />
              <span>{inspiration.steps.length} {language === 'zh-TW' ? '步驟' : 'steps'}</span>
            </motion.div>
          </div>

          {inspiration.learning_focus.length > 0 && (
            <div className="pt-4 border-t border-gray-100">
              <p className="text-xs text-gray-500 font-medium mb-2">
                {language === 'zh-TW' ? '你將學到' : 'What You\'ll Learn'}
              </p>
              <div className="flex flex-wrap gap-2">
                {inspiration.learning_focus.slice(0, 3).map((focus, index) => (
                  <motion.div
                    key={index}
                    initial={{ opacity: 0, y: 10 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: index * 0.05 }}
                  >
                    <Badge variant="secondary" className="text-xs group-hover:bg-purple-50 group-hover:text-purple-700 group-hover:border-purple-200 transition-colors duration-300">
                      {focus}
                    </Badge>
                  </motion.div>
                ))}
              </div>
            </div>
          )}
        </div>

        <motion.div
          className="bg-gradient-to-r from-purple-50 to-blue-50 px-6 py-3 flex items-center justify-between group-hover:from-purple-100 group-hover:to-blue-100 transition-all duration-300"
          whileHover={{ backgroundColor: 'rgba(147, 51, 234, 0.1)' }}
        >
          <span className="text-sm font-medium text-purple-900">
            {t('creative_use_cases.view_details')}
          </span>
          <motion.div
            animate={{ x: [0, 4, 0] }}
            transition={{ repeat: Infinity, duration: 1.5, ease: 'easeInOut' }}
          >
            <TrendingUp className="w-4 h-4 text-purple-600" />
          </motion.div>
        </motion.div>
      </Card>
    </motion.div>
  );
}
