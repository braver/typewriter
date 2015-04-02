module.exports =

  activate: (state) ->
    Run = require './run'
    Run.start()

    # Listen config changes
    @fontChanged = atom.config.onDidChange 'editor.fontSize', ->
      requestAnimationFrame ->
        Run.start()

    @widthChanged = atom.config.onDidChange 'editor.preferredLineLength', ->
      requestAnimationFrame ->
        Run.start()

    # And to tab switching, opening files, etc.
    @paneChanged = atom.workspace.onDidChangeActivePaneItem ->
      requestAnimationFrame ->
        Run.start()

  deactivate: (state) ->
    Run = require './run'
    Run.stop()
    @fontChanged?.dispose()
    @widthChanged?.dispose()
    @paneChanged?.dispose()
