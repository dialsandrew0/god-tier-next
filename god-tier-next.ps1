# Create-GodTierNext.ps1
# Usage: .\Create-GodTierNext.ps1 -ProjectName god-tier-next -GitHubUser dialsandrew0

param(
    [string]$ProjectName = "god-tier-next",
    [string]$GitHubUser = "dialsandrew0"
)

$ErrorActionPreference = "Stop"

Write-Host "Creating Next.js + Tailwind project: $ProjectName" -ForegroundColor Cyan

# 1. Create Next.js app with App Router, Tailwind, TypeScript, ESLint
npx create-next-app@latest $ProjectName --typescript --tailwind --eslint --app --src-dir --import-alias "@/*" --use-npm

Set-Location $ProjectName

# 2. Ensure we have a clean git repo
if (Test-Path ".git") {
    Remove-Item -Recurse -Force ".git"
    Write-Host "Removed existing .git folder" -ForegroundColor Yellow
}

git init
git checkout -b main

# 3. Create folder structure
$uiPath = "app\ui"
if (-not (Test-Path $uiPath)) {
    New-Item -ItemType Directory -Force $uiPath | Out-Null
}

# 4. Create fonts.ts (Inter + Geist ready)
$fontsContent = @"
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
"@

Set-Content -Path "app\ui\fonts.ts" -Value $fontsContent -Encoding UTF8

# 5. Create app/layout.tsx (clean, working, god-tier)
$layoutContent = @"
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
"@

Set-Content -Path "app\layout.tsx" -Value $layoutContent -Encoding UTF8

# 6. Create app/page.tsx (simple demo page)
$pageContent = @"
export default function Home() {
  return (
    <main className="min-h-screen p-8 font-sans">
      <h1 className="text-4xl font-bold mb-4">God-tier Next.js Starter</h1>
      <p className="text-lg text-gray-700">
        Inter font, Tailwind, App Router – ready to ship.
      </p>
    </main>
  );
}
"@

Set-Content -Path "app\page.tsx" -Value $pageContent -Encoding UTF8

# 7. Update tailwind.config.ts to use Inter (and optionally Geist later)
$tailwindConfigPath = "tailwind.config.ts"
if (-not (Test-Path $tailwindConfigPath)) {
    $tailwindConfigPath = "tailwind.config.js"
}

if (Test-Path $tailwindConfigPath) {
    $tailwindContent = Get-Content $tailwindConfigPath -Raw

    # Replace existing fontFamily block with our version
    $newTailwindContent = $tailwindContent -replace `
        'fontFamily:\s*{[^}]*}',
        @"
fontFamily: {
  sans: ['var(--font-inter)', 'system-ui', 'sans-serif'],
  mono: ['ui-monospace', 'SFMono-Regular', 'Menlo', 'monospace'],
  // If you add Geist later:
  // geist: ['var(--font-geist-sans)', 'system-ui', 'sans-serif'],
  // geistMono: ['var(--font-geist-mono)', 'ui-monospace', 'monospace'],
}
"@

    Set-Content -Path $tailwindConfigPath -Value $newTailwindContent -Encoding UTF8
    Write-Host "Updated $tailwindConfigPath" -ForegroundColor Green
} else {
    Write-Host "Tailwind config not found – skipping" -ForegroundColor Yellow
}

# 8. Ensure .gitignore is solid
$gitignorePath = ".gitignore"
if (Test-Path $gitignorePath) {
    $gitignore = Get-Content $gitignorePath -Raw
    if (-not ($gitignore -match "^\s*\.DS_Store")) {
        $gitignore = $gitignore.TrimEnd() + "`n.DS_Store`n.env.local`n"
        Set-Content -Path $gitignorePath -Value $gitignore -Encoding UTF8
    }
}

# 9. Commit everything
git add .
git commit -m "Initial commit: god-tier Next.js + Tailwind starter (Inter font)"

# 10. Create GitHub repo and push (using gh CLI)
$repoName = $ProjectName

Write-Host "Creating GitHub repo: $repoName" -ForegroundColor Cyan

# Check if gh CLI is available
$ghVersion = gh --version 2>$null
if (-not $ghVersion) {
    Write-Host "GitHub CLI (gh) not found. Please install gh and run 'gh auth login', then re-run this script." -ForegroundColor Red
    exit 1
}

# Create repo and push
gh repo create "$repoName" --public --source=. --remote=origin --push

Write-Host "Done! Your god-tier Next.js starter is live at:" -ForegroundColor Green
Write-Host "https://github.com/$GitHubUser/$repoName" -ForegroundColor Cyan