import { Info, Target, Workflow, Lightbulb, Rocket, X, ChevronDown, ChevronUp } from 'lucide-react';
import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Modal } from './ui/Modal';

interface AboutModalProps {
  isOpen: boolean;
  onClose: () => void;
}

export function AboutModal({ isOpen, onClose }: AboutModalProps) {
  const { t } = useTranslation();
  const [expandedFaq, setExpandedFaq] = useState<number | null>(null);

  const toggleFaq = (index: number) => {
    setExpandedFaq(expandedFaq === index ? null : index);
  };

  const features = [
    {
      icon: Target,
      title: t('about.features.discovery.title'),
      description: t('about.features.discovery.desc'),
      color: 'from-blue-500 to-cyan-500'
    },
    {
      icon: Workflow,
      title: t('about.features.combinations.title'),
      description: t('about.features.combinations.desc'),
      color: 'from-purple-500 to-pink-500'
    },
    {
      icon: Lightbulb,
      title: t('about.features.insights.title'),
      description: t('about.features.insights.desc'),
      color: 'from-yellow-500 to-orange-500'
    },
    {
      icon: Rocket,
      title: t('about.features.export.title'),
      description: t('about.features.export.desc'),
      color: 'from-green-500 to-teal-500'
    }
  ];

  const faqs = [
    {
      question: t('about.faq.q1'),
      answer: t('about.faq.a1')
    },
    {
      question: t('about.faq.q2'),
      answer: t('about.faq.a2')
    },
    {
      question: t('about.faq.q3'),
      answer: t('about.faq.a3')
    },
    {
      question: t('about.faq.q4'),
      answer: t('about.faq.a4')
    }
  ];

  return (
    <Modal isOpen={isOpen} onClose={onClose} title="" size="xl">
      <div className="flex items-center justify-between mb-6 pb-4 border-b border-gray-200">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 bg-gradient-to-br from-green-500 to-teal-500 rounded-lg flex items-center justify-center">
            <Info size={20} className="text-white" />
          </div>
          <div>
            <h2 className="text-2xl font-bold text-gray-900">{t('about.title')}</h2>
            <p className="text-sm text-gray-600">{t('about.subtitle')}</p>
          </div>
        </div>
        <button
          onClick={onClose}
          className="p-2 hover:bg-gray-100 rounded-lg transition-colors"
        >
          <X size={20} className="text-gray-500" />
        </button>
      </div>

      <div className="max-h-[70vh] overflow-y-auto space-y-8">
        <section>
          <h3 className="text-lg font-semibold text-gray-900 mb-3">{t('about.what_is.title')}</h3>
          <p className="text-gray-600 leading-relaxed mb-4">
            {t('about.what_is.desc1')}
          </p>
          <p className="text-gray-600 leading-relaxed">
            {t('about.what_is.desc2')}
          </p>
        </section>

        <section>
          <h3 className="text-lg font-semibold text-gray-900 mb-4">{t('about.how_it_works.title')}</h3>
          <div className="space-y-3">
            <div className="flex gap-4">
              <div className="w-8 h-8 bg-blue-100 text-blue-600 rounded-full flex items-center justify-center font-bold text-sm flex-shrink-0">
                1
              </div>
              <div>
                <h4 className="font-medium text-gray-900 mb-1">{t('about.how_it_works.step1.title')}</h4>
                <p className="text-sm text-gray-600">{t('about.how_it_works.step1.desc')}</p>
              </div>
            </div>
            <div className="flex gap-4">
              <div className="w-8 h-8 bg-purple-100 text-purple-600 rounded-full flex items-center justify-center font-bold text-sm flex-shrink-0">
                2
              </div>
              <div>
                <h4 className="font-medium text-gray-900 mb-1">{t('about.how_it_works.step2.title')}</h4>
                <p className="text-sm text-gray-600">{t('about.how_it_works.step2.desc')}</p>
              </div>
            </div>
            <div className="flex gap-4">
              <div className="w-8 h-8 bg-green-100 text-green-600 rounded-full flex items-center justify-center font-bold text-sm flex-shrink-0">
                3
              </div>
              <div>
                <h4 className="font-medium text-gray-900 mb-1">{t('about.how_it_works.step3.title')}</h4>
                <p className="text-sm text-gray-600">{t('about.how_it_works.step3.desc')}</p>
              </div>
            </div>
          </div>
        </section>

        <section>
          <h3 className="text-lg font-semibold text-gray-900 mb-4">{t('about.key_features')}</h3>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {features.map((feature, index) => (
              <div
                key={index}
                className="p-4 bg-white rounded-xl border border-gray-200 hover:border-blue-300 transition-all"
              >
                <div className={`w-10 h-10 bg-gradient-to-br ${feature.color} rounded-lg flex items-center justify-center mb-3`}>
                  <feature.icon size={20} className="text-white" />
                </div>
                <h4 className="font-semibold text-gray-900 mb-2">{feature.title}</h4>
                <p className="text-sm text-gray-600">{feature.description}</p>
              </div>
            ))}
          </div>
        </section>

        <section>
          <h3 className="text-lg font-semibold text-gray-900 mb-3">{t('about.use_cases.title')}</h3>
          <ul className="space-y-2">
            <li className="flex gap-3 text-sm text-gray-600">
              <span className="text-blue-500 mt-1">•</span>
              <span>{t('about.use_cases.case1')}</span>
            </li>
            <li className="flex gap-3 text-sm text-gray-600">
              <span className="text-blue-500 mt-1">•</span>
              <span>{t('about.use_cases.case2')}</span>
            </li>
            <li className="flex gap-3 text-sm text-gray-600">
              <span className="text-blue-500 mt-1">•</span>
              <span>{t('about.use_cases.case3')}</span>
            </li>
            <li className="flex gap-3 text-sm text-gray-600">
              <span className="text-blue-500 mt-1">•</span>
              <span>{t('about.use_cases.case4')}</span>
            </li>
          </ul>
        </section>

        <section>
          <h3 className="text-lg font-semibold text-gray-900 mb-4">{t('about.faq.title')}</h3>
          <div className="space-y-3">
            {faqs.map((faq, index) => (
              <div
                key={index}
                className="bg-white rounded-lg border border-gray-200 overflow-hidden"
              >
                <button
                  onClick={() => toggleFaq(index)}
                  className="w-full flex items-center justify-between p-4 text-left hover:bg-gray-50 transition-colors"
                >
                  <span className="font-medium text-gray-900">{faq.question}</span>
                  {expandedFaq === index ? (
                    <ChevronUp size={20} className="text-gray-500 flex-shrink-0" />
                  ) : (
                    <ChevronDown size={20} className="text-gray-500 flex-shrink-0" />
                  )}
                </button>
                {expandedFaq === index && (
                  <div className="px-4 pb-4 text-sm text-gray-600">
                    {faq.answer}
                  </div>
                )}
              </div>
            ))}
          </div>
        </section>

        <section className="bg-gradient-to-br from-blue-50 to-purple-50 rounded-xl p-6">
          <h3 className="text-lg font-semibold text-gray-900 mb-2">{t('about.get_started.title')}</h3>
          <p className="text-gray-600 mb-4">{t('about.get_started.desc')}</p>
          <div className="flex gap-3 text-sm text-gray-600">
            <span className="font-medium">1.</span>
            <span>{t('about.get_started.step1')}</span>
          </div>
          <div className="flex gap-3 text-sm text-gray-600 mt-2">
            <span className="font-medium">2.</span>
            <span>{t('about.get_started.step2')}</span>
          </div>
          <div className="flex gap-3 text-sm text-gray-600 mt-2">
            <span className="font-medium">3.</span>
            <span>{t('about.get_started.step3')}</span>
          </div>
        </section>
      </div>
    </Modal>
  );
}
