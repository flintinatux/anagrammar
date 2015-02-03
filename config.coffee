exports.config =
  conventions:
    assets: /(assets|font)/

  files:
    javascripts:
      joinTo:
        'scripts/app.js': /^app\/scripts/
        'scripts/vendor.js': /^(bower_components|vendor\/scripts)/

    stylesheets:
      joinTo:
        'styles/app.css': /^app\/styles/

    templates:
      joinTo:
        'scripts/app.js': /^app\/scripts/

  modules:
    nameCleaner: (path) ->
      path.replace /^app\/scripts\//, ''

  server:
    port: 3000

  plugins:
    digest:
      precision: 32
