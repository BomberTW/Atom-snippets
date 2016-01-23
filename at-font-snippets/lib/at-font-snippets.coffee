AtFontSnippetsView = require './at-font-snippets-view'
{CompositeDisposable} = require 'atom'

module.exports = AtFontSnippets =
  atFontSnippetsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atFontSnippetsView = new AtFontSnippetsView(state.atFontSnippetsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atFontSnippetsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'at-font-snippets:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atFontSnippetsView.destroy()

  serialize: ->
    atFontSnippetsViewState: @atFontSnippetsView.serialize()

  toggle: ->
    console.log 'AtFontSnippets was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
