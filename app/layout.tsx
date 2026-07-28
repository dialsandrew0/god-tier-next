import type { Metadata } from 'next';
import './globals.css';
import { inter } from './ui/fonts';

export const metadata: Metadata = {
  title: 'God-tier Next App',
  description: 'Stable font setup for serious projects',
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" className={inter.variable}>
      <body>{children}</body>
    </html>
  );
}
