import { useEffect } from 'react';

interface ScrollPosition {
  x: number;
  y: number;
}

const scrollPositions = new Map<string, ScrollPosition>();

export function useScrollRestoration(key: string) {
  useEffect(() => {
    const savedPosition = scrollPositions.get(key);

    if (savedPosition) {
      window.scrollTo({
        left: savedPosition.x,
        top: savedPosition.y,
        behavior: 'instant' as ScrollBehavior
      });
    } else {
      window.scrollTo(0, 0);
    }

    const saveScrollPosition = () => {
      scrollPositions.set(key, {
        x: window.scrollX,
        y: window.scrollY
      });
    };

    window.addEventListener('scroll', saveScrollPosition, { passive: true });

    return () => {
      window.removeEventListener('scroll', saveScrollPosition);
    };
  }, [key]);
}
