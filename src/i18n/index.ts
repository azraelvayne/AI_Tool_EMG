import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import en from '../locales/en/common.json';
import zhTW from '../locales/zh-TW/common.json';

const detectLanguage = (): string => {
  const saved = localStorage.getItem('lang');
  if (saved) return saved;

  const browserLang = navigator.language || (navigator.languages && navigator.languages[0]);

  if (browserLang) {
    if (browserLang.startsWith('zh')) {
      return browserLang.includes('TW') || browserLang.includes('HK') || browserLang.includes('MO')
        ? 'zh-TW'
        : 'zh-TW';
    }
  }

  return 'zh-TW';
};

i18n
  .use(initReactI18next)
  .init({
    resources: {
      en: { translation: en },
      'zh-TW': { translation: zhTW },
    },
    lng: detectLanguage(),
    fallbackLng: 'zh-TW',
    interpolation: {
      escapeValue: false,
    },
  });

export default i18n;
