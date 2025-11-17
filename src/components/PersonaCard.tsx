import { Card } from './ui/Card';
import { motion } from 'framer-motion';
import { ArrowRight } from 'lucide-react';
import { useState } from 'react';
import type { Persona } from '../types';

interface PersonaCardProps {
  persona: Persona;
  language: 'en' | 'zh-TW';
  onClick: () => void;
}

export function PersonaCard({ persona, language, onClick }: PersonaCardProps) {
  const name = language === 'zh-TW' ? persona.name_zh_tw : persona.name_en;
  const description = language === 'zh-TW' ? persona.description_zh_tw : persona.description_en;
  const [imageError, setImageError] = useState(false);
  const [imageLoaded, setImageLoaded] = useState(false);

  const personaColors: Record<string, { gradient: string; hoverGradient: string }> = {
    ai_tool_designer: {
      gradient: 'from-purple-50 to-indigo-50',
      hoverGradient: 'from-purple-100 to-indigo-100'
    },
    creative_builder: {
      gradient: 'from-orange-50 to-pink-50',
      hoverGradient: 'from-orange-100 to-pink-100'
    },
    data_analyst: {
      gradient: 'from-blue-50 to-cyan-50',
      hoverGradient: 'from-blue-100 to-cyan-100'
    },
    knowledge_manager: {
      gradient: 'from-green-50 to-emerald-50',
      hoverGradient: 'from-green-100 to-emerald-100'
    },
    business_developer: {
      gradient: 'from-red-50 to-orange-50',
      hoverGradient: 'from-red-100 to-orange-100'
    },
    workflow_architect: {
      gradient: 'from-cyan-50 to-blue-50',
      hoverGradient: 'from-cyan-100 to-blue-100'
    }
  };

  const colors = personaColors[persona.persona_key] || personaColors.ai_tool_designer;

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
        <div className={`absolute inset-0 bg-gradient-to-br ${colors.gradient} opacity-0 group-hover:opacity-100 transition-opacity duration-300`} />

        <div className="relative flex flex-col items-center text-center p-6">
          {persona.icon_url && !imageError ? (
            <motion.div
              className="relative w-32 h-32 mb-4 rounded-2xl overflow-hidden"
              whileHover={{ scale: 1.08 }}
              transition={{ duration: 0.3 }}
            >
              {!imageLoaded && (
                <div className="absolute inset-0 bg-gradient-to-br from-gray-200 to-gray-300 animate-pulse rounded-2xl" />
              )}
              <img
                src={persona.icon_url}
                alt={name}
                className={`w-full h-full object-cover transition-opacity duration-300 ${imageLoaded ? 'opacity-100' : 'opacity-0'}`}
                onLoad={() => setImageLoaded(true)}
                onError={() => setImageError(true)}
                loading="lazy"
              />
            </motion.div>
          ) : (
            <motion.div
              className="text-6xl mb-4"
              whileHover={{ scale: 1.15, rotate: [0, -5, 5, 0] }}
              transition={{ duration: 0.3 }}
            >
              {persona.icon}
            </motion.div>
          )}

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
              {language === 'zh-TW' ? '學習重點' : 'Learning Focus'}
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
            <span>{language === 'zh-TW' ? '探索更多' : 'Explore'}</span>
            <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform duration-300" />
          </motion.div>
        </div>
      </Card>
    </motion.div>
  );
}
