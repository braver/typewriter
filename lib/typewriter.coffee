module.exports =

  activate: (state) ->
    Run = require './run'
    Run.run()

    # Listen config changes
    @fontChanged = atom.config.onDidChange 'editor.fontSize', ->
      requestAnimationFrame ->
        Run.run()

    @widthChanged = atom.config.onDidChange 'editor.preferredLineLength', ->
      requestAnimationFrame ->
        Run.run()

    # And to tab switching, opening files, etc.
    @paneChanged = atom.workspace.onDidChangeActivePaneItem ->
      requestAnimationFrame ->
        Run.run()

  deactivate: (state) ->
    @fontChanged?.dispose()
    @widthChanged?.dispose()
    @paneChanged?.dispose()
