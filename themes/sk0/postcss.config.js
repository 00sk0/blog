module.exports = {
  parser: "postcss-scss",
  plugins: [
    require("postcss-import")(),
    require("postcss-inline-comment")(),
    require("postcss-simple-vars")(),
    require("postcss-mixins")(),
    require("postcss-nested")(),
    // require("cssnano")(),
    require("autoprefixer")(),
    require("postcss-extend")(),
    require("postcss-calc")(),
  ]
}