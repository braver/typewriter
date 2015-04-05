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
      Run.start()

    @widthChanged = atom.config.onDidChange 'editor.preferredLineLength', ->
      Run.start()

    @paneChanged = atom.workspace.onDidChangeActivePaneItem ->
      Run.start()
      editor = atom.workspace.getActiveTextEditor()
      if editor isnt undefined
        @grammarChange = editor.onDidChangeGrammar -> #needs disposal
          console.log 1
          atom.views.getView(editor).setAttribute('style', '')
          atom.views.getView(editor).setAttribute('data-typewriter', false)
          Run.start()

  deactivate: (state) ->
    Run = require './run'
    Run.stop()
    @configChanged?.dispose()
    @fontChanged?.dispose()
    @widthChanged?.dispose()
    @paneChanged?.dispose()
