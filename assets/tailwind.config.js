// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin")
const fs = require("fs")
const path = require("path")

module.exports = {
  darkMode: 'class',
  variants: {
    extend: {
      maskImage: ['hover', 'focus'],
    },
  },
  content: [
    "./js/**/*.js",
    "../lib/front_end_web.ex",
    "../lib/front_end_web/**/*.{heex,ex,exs}",
    "./js/**/*.js",
    "./css/*.css"
  ],
  safelist: [
    {
      pattern: /bg-(orange|blue|pink)-100/,
    },
    {
      pattern: /text-(orange|blue|pink)-800/,
    },
    {
      pattern: /bg-(selected|selected-dark)/
    }
  ],
  theme: {
    extend: {
      keyframes: {
        'bg-shift': {
          '0%': { backgroundPosition: '100% 0' },
          '100%': { backgroundPosition: '0 0' },
        },
      },
      animation: {
        'bg-shift': 'bg-shift 0.7s ease-in-out forwards',
      },
      fontFamily: {
        poppins: ["Poppins", "sans-serif"],
        roboto: ["Roboto", "sans-serif"], 
        rubik: ["Rubik", "sans-serif"],
        inter: ["Inter", "sans-serif"],  
      },
      fontSize: {
        xxxs: '5px',
        xxs: '10px',
        xxss: ['10px', '18px'],
        myxl: ['42px','28px']
      },
      colors: {
        selected: {
          DEFAULT: "#FB3F4A",
          dark: "#589C5F"
        },
        'gray': {
          50: "#EFEFEF",
          100: "#FAFAFA",
          200: "#EFF0F6",
          300: "#B2B2B2",
          400: "#E0E0E0",
          500: "#686868",
          600: "#A0A3BD",
          700: "#6F6C90",
          800: "#303030"
        },
        'orange': {
          100: "#FFEFE7",
          500: "#FF3951",
          800: "#FF5151"
        },
        'blue': {
          100: "#E8F0FB",
          500: "#4A3AFF",
          800: "#3786F1"
        },
        'pink': {
          100: "#FDEBF9",
          800: "#EE61CF"
        },
        'jean': {
          400: "#1B204A",
          500: "#161E54"
        },
        'coal': "#1E1F25",
        'primary': "#333333",
        'secondary': "#666666",
        'secondary-dark':"#CCCCCC",
        'percent-fill': "#FFEFE7"
      },
      spacing: {
        '18': '72px'
      },
      maskImage: ['responsive'],
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    // Allows prefixing tailwind classes with LiveView classes to add rules
    // only when LiveView classes are applied, for example:
    //
    //     <div class="phx-click-loading:animate-ping">
    //
    plugin(({addVariant}) => addVariant("phx-click-loading", [".phx-click-loading&", ".phx-click-loading &"])),
    plugin(({addVariant}) => addVariant("phx-submit-loading", [".phx-submit-loading&", ".phx-submit-loading &"])),
    plugin(({addVariant}) => addVariant("phx-change-loading", [".phx-change-loading&", ".phx-change-loading &"])),

    // Embeds Heroicons (https://heroicons.com) into your app.css bundle
    // See your `CoreComponents.icon/1` for more information.
    //
    plugin(function({matchComponents, theme}) {
      let iconsDir = path.join(__dirname, "../deps/heroicons/optimized")
      let values = {}
      let icons = [
        ["", "/24/outline"],
        ["-solid", "/24/solid"],
        ["-mini", "/20/solid"],
        ["-micro", "/16/solid"]
      ]
      icons.forEach(([suffix, dir]) => {
        fs.readdirSync(path.join(iconsDir, dir)).forEach(file => {
          let name = path.basename(file, ".svg") + suffix
          values[name] = {name, fullPath: path.join(iconsDir, dir, file)}
        })
      })
      matchComponents({
        "hero": ({name, fullPath}) => {
          let content = fs.readFileSync(fullPath).toString().replace(/\r?\n|\r/g, "")
          let size = theme("spacing.6")
          if (name.endsWith("-mini")) {
            size = theme("spacing.5")
          } else if (name.endsWith("-micro")) {
            size = theme("spacing.4")
          }
          return {
            [`--hero-${name}`]: `url('data:image/svg+xml;utf8,${content}')`,
            "-webkit-mask": `var(--hero-${name})`,
            "mask": `var(--hero-${name})`,
            "mask-repeat": "no-repeat",
            "background-color": "currentColor",
            "vertical-align": "middle",
            "display": "inline-block",
            "width": size,
            "height": size
          }
        }
      }, {values})
    })
  ]
}
