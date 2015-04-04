$ = require 'jquery'

module.exports =

  start: () ->

    atom.config.set('.gfm.source', 'editor.softWrap', true)
    atom.config.set('.html.mediawiki.text', 'editor.softWrap', true)

    editor = atom.workspace.getActiveTextEditor()

    if editor isnt undefined # e.g. settings-view
      console.log editor.getRootScopeDescriptor().scopes[0]
      $('[data-grammar="source gfm"] /deep/ .editor--private').css 'max-width', editor.getDefaultCharWidth() * atom.config.get(['.gfm.source'],'editor.preferredLineLength')
      $('[data-grammar="text html mediawiki"] /deep/ .editor--private').css 'max-width', editor.getDefaultCharWidth() * atom.config.get(['.text.html.mediawiki'],'editor.preferredLineLength')

      if editor.getRootScopeDescriptor().scopes[0] is 'source.gfm'
        atom.views.getView(editor).setAttribute('data-typewriter', true)
      if editor.getRootScopeDescriptor().scopes[0] is 'text.html.mediawiki'
        atom.views.getView(editor).setAttribute('data-typewriter', true)


  stop: () ->
    $('[data-grammar="source gfm"] /deep/ .editor--private').css 'max-width', ''
    $('[data-grammar="text html mediawiki"] /deep/ .editor--private').css 'max-width', ''
