AtCdnSnippetsView = require './at-cdn-snippets-view'
{CompositeDisposable} = require 'atom'

module.exports = AtCdnSnippets =
  atCdnSnippetsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atCdnSnippetsView = new AtCdnSnippetsView(state.atCdnSnippetsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atCdnSnippetsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'at-cdn-snippets:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atCdnSnippetsView.destroy()

  serialize: ->
    atCdnSnippetsViewState: @atCdnSnippetsView.serialize()

  toggle: ->
    console.log 'AtCdnSnippets was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
