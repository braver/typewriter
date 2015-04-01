module.exports =
  activate: (state) ->
    # code in separate file so deferral keeps activation time down
    atom.themes.onDidChangeActiveThemes ->
      Run = require './run'
      Run.run()

    deactivate: (state) ->
      @fontChanged?.dispose()
      @widthChanged?.dispose()
      @paneChanged?.dispose()
