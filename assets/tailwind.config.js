/* ./assets/tailwind.config.js */

module.exports = {
  mode: 'jit',
  purge: [
    './js/**/*.js',
    './css/**/*.css',
    '../lib/*_web/**/*.*ex',
  ],
  darkMode: false,
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
};
