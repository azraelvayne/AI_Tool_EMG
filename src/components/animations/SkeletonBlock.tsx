interface SkeletonBlockProps {
  className?: string;
  height?: string;
  width?: string;
}

export function SkeletonBlock({ className = '', height = 'h-4', width = 'w-full' }: SkeletonBlockProps) {
  return (
    <div className={`${height} ${width} bg-gray-200 rounded animate-pulse ${className}`} />
  );
}

export function SkeletonCard() {
  return (
    <div className="bg-white rounded-xl border border-gray-200 p-6 space-y-4">
      <SkeletonBlock height="h-6" width="w-3/4" />
      <SkeletonBlock height="h-4" width="w-full" />
      <SkeletonBlock height="h-4" width="w-5/6" />
      <div className="flex gap-2 pt-2">
        <SkeletonBlock height="h-6" width="w-20" />
        <SkeletonBlock height="h-6" width="w-24" />
      </div>
    </div>
  );
}

export function SkeletonHeader() {
  return (
    <div className="bg-gradient-to-r from-blue-600 to-indigo-600 text-white">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <SkeletonBlock height="h-8" width="w-48" className="mb-6 bg-white/20" />
        <SkeletonBlock height="h-12" width="w-full md:w-2/3" className="mb-4 bg-white/20" />
        <SkeletonBlock height="h-6" width="w-full md:w-3/4" className="mb-6 bg-white/20" />
        <div className="flex gap-3">
          <SkeletonBlock height="h-8" width="w-24" className="bg-white/20" />
          <SkeletonBlock height="h-8" width="w-32" className="bg-white/20" />
        </div>
      </div>
    </div>
  );
}

export function SkeletonSection({ cardCount = 3 }: { cardCount?: number }) {
  return (
    <section className="space-y-6">
      <div className="flex items-center gap-3">
        <SkeletonBlock height="h-7" width="w-7" className="rounded-full" />
        <SkeletonBlock height="h-8" width="w-48" />
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {Array.from({ length: cardCount }).map((_, i) => (
          <SkeletonCard key={i} />
        ))}
      </div>
    </section>
  );
}
