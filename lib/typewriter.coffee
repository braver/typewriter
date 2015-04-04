module.exports =

  config:
    scopes:
      description: 'Comma seperated, no spaces. Find the scope for each language in its package.'
      type: 'string'
      default: 'source.gfm,text.html.mediawiki'

  activate: (state) ->
    Run = require './run'
    Run.start()

    @configChanged = atom.config.onDidChange 'typewriter.scopes', ->
      # Reset, start will run again when pane is switched (e.g. away from settings)
      Run.stop()

    @fontChanged = atom.config.onDidChange 'editor.fontSize', ->
      requestAnimationFrame ->
        Run.start()

    @widthChanged = atom.config.onDidChange 'editor.preferredLineLength', ->
      requestAnimationFrame ->
        Run.start()

    @paneChanged = atom.workspace.onDidChangeActivePaneItem ->
      requestAnimationFrame ->
        Run.start()

  deactivate: (state) ->
    Run = require './run'
    Run.stop()
    @configChanged?.dispose()
    @fontChanged?.dispose()
    @widthChanged?.dispose()
    @paneChanged?.dispose()
