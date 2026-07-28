// app/ui/fonts.ts
import { Inter } from 'next/font/google';
// If your Next version supports Geist via Google fonts, uncomment:
// import { Geist, Geist_Mono } from 'next/font/google';

export const inter = Inter({
  subsets: ['latin'],
  variable: '--font-inter',
});

// If you later want Geist, you can enable this:
// export const geistSans = Geist({
//   subsets: ['latin'],
//   variable: '--font-geist-sans',
// });
// export const geistMono = Geist_Mono({
//   subsets: ['latin'],
//   variable: '--font-geist-mono',
// });
