/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: ["class"],
  content: [
    "./index.html",
    "./src-react/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        background: "#121314",
        foreground: "#ffffff",
        primary: {
          DEFAULT: "#3b82f6",
          foreground: "#ffffff",
        },
        muted: {
          DEFAULT: "#27272a",
          foreground: "#a1a1aa",
        },
        accent: {
          DEFAULT: "#27272a",
          foreground: "#ffffff",
        },
        border: "#27272a",
      },
    },
  },
  plugins: [],
}
