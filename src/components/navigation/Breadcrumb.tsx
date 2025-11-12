import { ChevronRight, Home } from 'lucide-react';
import { motion } from 'framer-motion';

export interface BreadcrumbItem {
  label: string;
  onClick?: () => void;
  isCurrentPage?: boolean;
}

interface BreadcrumbProps {
  items: BreadcrumbItem[];
  className?: string;
}

export function Breadcrumb({ items, className = '' }: BreadcrumbProps) {
  return (
    <nav aria-label="Breadcrumb" className={`flex items-center gap-2 text-sm ${className}`}>
      <motion.ol
        className="flex items-center gap-2 flex-wrap"
        initial="hidden"
        animate="visible"
        variants={{
          visible: {
            transition: {
              staggerChildren: 0.05
            }
          }
        }}
      >
        {items.map((item, index) => {
          const isLast = index === items.length - 1;

          return (
            <motion.li
              key={index}
              className="flex items-center gap-2"
              variants={{
                hidden: { opacity: 0, x: -10 },
                visible: { opacity: 1, x: 0 }
              }}
            >
              {index === 0 && (
                <Home className="w-4 h-4" aria-hidden="true" />
              )}

              {item.onClick && !isLast ? (
                <button
                  onClick={item.onClick}
                  className="hover:text-blue-600 transition-colors focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 rounded px-1"
                  aria-current={item.isCurrentPage ? 'page' : undefined}
                >
                  {item.label}
                </button>
              ) : (
                <span
                  className={isLast ? 'font-semibold text-gray-900' : 'text-gray-600'}
                  aria-current={item.isCurrentPage || isLast ? 'page' : undefined}
                >
                  {item.label}
                </span>
              )}

              {!isLast && (
                <ChevronRight className="w-4 h-4 text-gray-400" aria-hidden="true" />
              )}
            </motion.li>
          );
        })}
      </motion.ol>
    </nav>
  );
}
