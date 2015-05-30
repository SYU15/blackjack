class window.CardView extends Backbone.View
  #className: "card rank-" + @get 'rankName' + " spades"

  #template: _.template '<%= rankName %> of <%= suitName %>'
  template: _.template '<div class="card rank-<%=rankName%> <%=suitName%> <% if(!revealed){print("back")}%>"><span class="rank"><% print(new String(rankName).toUpperCase()) %></span><span class="suit">&nbsp;</span></div>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'
