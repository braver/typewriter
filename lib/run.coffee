module.exports =

  start: () ->
    requestAnimationFrame -> # wait for other dom changes
      scopes = atom.config.get('typewriter.scopes').split(',')
      showGutter = atom.config.get('typewriter.showGutter')
      showScrollbar = atom.config.get('typewriter.showScrollbar')
      showTextLeftAligned = atom.config.get('typewriter.showTextLeftAligned')
      enabledForAllScopes = atom.config.get('typewriter.enabledForAllScopes')
      editor = atom.workspace.getActiveTextEditor()

      if editor isnt undefined # e.g. settings-view
        currentScope = editor.getRootScopeDescriptor().scopes[0]

        if currentScope in scopes or enabledForAllScopes is true
          atom.views.getView(editor).setAttribute('data-typewriter', true)

          if showTextLeftAligned is false
            characterWidth = editor.getDefaultCharWidth()
            charactersPerLine = atom.config.get('editor.preferredLineLength', scope: [currentScope])

            atom.config.set('editor.softWrap', true, scopeSelector: currentScope)
            atom.views.getView(editor).style.maxWidth = characterWidth * (charactersPerLine + 4) + 'px'
            atom.views.getView(editor).style.paddingLeft = characterWidth * 2 + 'px'
            atom.views.getView(editor).style.paddingRight = characterWidth * 2 + 'px'

            console.log(atom.views.getView(editor))

          if showGutter is false
            atom.views.getView(editor).setAttribute('data-typewriter-hide-gutter', true)

          if showScrollbar is false
            atom.views.getView(editor).setAttribute('data-typewriter-hide-scrollbar', true)

  stop: () ->
    $ = require 'jquery'
    $('[data-typewriter]').attr('data-typewriter', false)
    $('[data-typewriter]').attr('data-typewriter-hide-gutter', false)
    $('[data-typewriter]').attr('data-typewriter-hide-scrollbar', false)
    $('atom-text-editor:not(.mini)').css 'max-width', ''
