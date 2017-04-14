{CompositeDisposable} = require 'atom'

module.exports =

  config:
    enabledForAllScopes:
      description: 'Ignores file scopes and enables typewriter mode for all files.'
      type: 'boolean'
      default: true
    showTextLeftAligned:
      description: 'Draw your text left aligned instead of centering text in a column as wide as your preferred line length.'
      type: 'boolean'
      default: false
    showGutter:
      type: 'boolean'
      default: false
    showScrollbar:
      type: 'boolean'
      default: false
    scopes:
      description: 'Comma seperated, no spaces. Find the scope for each language in its package.'
      type: 'string'
      default: 'text.md,source.gfm,text.html.mediawiki,text.tex.latex'

  activate: (state) ->
    @disposables = new CompositeDisposable
    Run = require './run'
    Run.start()

    # Reset, start() will run again when pane is switched (e.g. away from settings)
    @disposables.add atom.config.onDidChange 'typewriter.scopes', ->
      Run.stop()

    @disposables.add atom.config.onDidChange 'typewriter.showTextLeftAligned', ->
      Run.stop()

    @disposables.add atom.config.onDidChange 'typewriter.showGutter', ->
      Run.stop()

    @disposables.add atom.config.onDidChange 'typewriter.showScrollbar', ->
      Run.stop()

    @disposables.add atom.config.onDidChange 'typewriter.enabledForAllScopes', ->
      Run.stop()

    @disposables.add atom.config.onDidChange 'editor.fontSize', ->
      Run.start()

    @disposables.add atom.config.onDidChange 'editor.preferredLineLength', ->
      Run.start()

    @disposables.add atom.workspace.onDidChangeActivePaneItem =>
      Run.start()
      # Listen to grammar changes
      editor = atom.workspace.getActiveTextEditor()
      if editor isnt undefined
        @disposables.add editor.onDidChangeGrammar ->
          # Reset first
          atom.views.getView(editor).setAttribute('style', '')
          atom.views.getView(editor).setAttribute('data-typewriter', false)
          # Then decide if the new grammar needs to be in typewriter mode
          Run.start()

  deactivate: (state) ->
    Run = require './run'
    Run.stop()
    @disposables.dispose()
