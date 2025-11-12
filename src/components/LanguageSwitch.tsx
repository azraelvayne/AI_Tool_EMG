import { useTranslation } from 'react-i18next';
import { Globe } from 'lucide-react';

export function LanguageSwitch() {
  const { i18n, t } = useTranslation();

  const handleLanguageSwitch = () => {
    const newLang = i18n.language === 'zh-TW' ? 'en' : 'zh-TW';
    i18n.changeLanguage(newLang);
    localStorage.setItem('lang', newLang);
  };

  return (
    <button
      onClick={handleLanguageSwitch}
      title={
        i18n.language === 'zh-TW'
          ? t('language.switch_to_english')
          : t('language.switch_to_chinese')
      }
      className="flex items-center gap-2 px-3 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 hover:border-gray-400 transition-all duration-200 shadow-sm hover:shadow"
      aria-label={
        i18n.language === 'zh-TW'
          ? 'Switch to English'
          : '切換至繁體中文'
      }
    >
      <Globe size={16} className="text-gray-600" />
      <span className="font-semibold">
        {i18n.language === 'zh-TW' ? 'EN' : '中'}
      </span>
    </button>
  );
}
