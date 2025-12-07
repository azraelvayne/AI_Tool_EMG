import { Card } from './ui/Card';
import { motion } from 'framer-motion';
import { ArrowRight } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import type { Persona } from '../types';

interface PersonaCardProps {
  persona: Persona;
  language: 'en' | 'zh-TW';
  onClick: () => void;
}

export function PersonaCard({ persona, language, onClick }: PersonaCardProps) {
  const { t } = useTranslation();
  const name = language === 'zh-TW' ? persona.name_zh_tw : persona.name_en;
  const description = language === 'zh-TW' ? persona.description_zh_tw : persona.description_en;

  return (
    <motion.div
      whileHover={{ y: -8, scale: 1.02 }}
      whileTap={{ scale: 0.98 }}
      transition={{ type: 'spring', stiffness: 300, damping: 20 }}
    >
      <Card
        onClick={onClick}
        className="cursor-pointer hover:shadow-2xl transition-all duration-300 group relative overflow-hidden"
      >
        <div className="absolute inset-0 bg-gradient-to-br from-blue-50 to-indigo-50 opacity-0 group-hover:opacity-100 transition-opacity duration-300" />

        <div className="relative flex flex-col items-center text-center p-6">
          <motion.div
            className="w-32 h-32 mb-4 rounded-2xl overflow-hidden bg-gradient-to-br from-blue-50 to-indigo-50 flex items-center justify-center shadow-md group-hover:shadow-xl transition-shadow duration-300"
            whileHover={{ scale: 1.05 }}
            transition={{ duration: 0.3 }}
          >
            {persona.icon_url && (
              <img
                src={persona.icon_url}
                alt={name}
                className="w-full h-full object-cover"
              />
            )}
          </motion.div>

          <h3 className="text-xl font-bold mb-2 text-gray-900 group-hover:text-blue-600 transition-colors duration-300">
            {name}
          </h3>

          <div className="inline-block px-3 py-1 bg-blue-100 text-blue-800 text-sm rounded-full mb-3 group-hover:bg-blue-600 group-hover:text-white transition-colors duration-300">
            {persona.skill_level}
          </div>

          <p className="text-gray-600 text-sm leading-relaxed mb-4 line-clamp-3">
            {description}
          </p>

          <div className="mt-auto pt-4 border-t border-gray-100 w-full">
            <p className="text-xs text-gray-500 font-medium mb-2">
              {t('persona.learning_focus')}
            </p>
            <div className="flex flex-wrap gap-2 justify-center">
              {persona.learning_focus.slice(0, 3).map((focus, index) => (
                <motion.span
                  key={index}
                  initial={{ opacity: 0, scale: 0.8 }}
                  animate={{ opacity: 1, scale: 1 }}
                  transition={{ delay: index * 0.1 }}
                  className="text-xs px-2 py-1 bg-gray-100 text-gray-700 rounded group-hover:bg-blue-50 group-hover:text-blue-700 transition-colors duration-300"
                >
                  {focus}
                </motion.span>
              ))}
            </div>
          </div>

          <motion.div
            className="flex items-center gap-2 text-sm text-blue-600 font-medium mt-4 opacity-0 group-hover:opacity-100 transition-opacity duration-300"
            initial={{ x: -10 }}
            whileHover={{ x: 0 }}
          >
            <span>{t('persona.explore')}</span>
            <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform duration-300" />
          </motion.div>
        </div>
      </Card>
    </motion.div>
  );
}
