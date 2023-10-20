const defaultTheme = require("tailwindcss/defaultTheme")

module.exports = {
  content: [
    "./public/*.html",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,haml,html,slim}"
  ],
  darkMode: "class",
  theme: {
    extend: {
      fontFamily: {
        sans: ["Inter var", ...defaultTheme.fontFamily.sans]
      },
      colors: {
        nepal: {
          50: "#f6f8f9",
          100: "#ebf1f3",
          200: "#d3e0e4",
          300: "#acc7cd",
          400: "#91b5bc",
          500: "#5f8e98",
          600: "#4b747e",
          700: "#3d5e67",
          800: "#365056",
          900: "#30444a"
        }
      },
      boxShadow: {
        hardened: "3px 3px 0 rgb(0,0,0)"
      },
      keyframes: {
        fadeOut: {
          from: { opacity: 1 },
          to: { opacity: 0 }
        }
      },
      animation: {
        fadeOut: "fadeOut 1s ease-in-out"
      }
    }
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/container-queries")
  ]
}
