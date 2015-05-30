class window.CardView extends Backbone.View
  #className: "card rank-" + @get 'rankName' + " spades"

  # template: _.template '<div class="card <% if(revealed){print("rank-" + rankName);} %> \
  #                         <%=suitName%> <% if(!revealed){print("back")}%> \
  #                         <% if(revealingFirstHalf){print("reveal")}%> \
  #                         <% if(revealingSecondHalf){}%> \
  #                         "> \
  #                         <span class="rank"><% print(new String(rankName).toUpperCase()) %></span> \
  #                         <span class="suit">&nbsp;</span> \
  #                       </div>'

  template: _.template '<div class="card <% if(revealed){print("rank-" + rankName);} %> \
                          <%=suitName%> <% if(!revealed){print("back")}%> \
                         "> \
                          <span class="rank"><% print(new String(rankName).toUpperCase()) %></span> \
                          <span class="suit">&nbsp;</span> \
                        </div>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    #debugger
    # @$el.addClass 'covered' unless @model.get 'revealed'
    #@$el.children().first().addClass 'reveal', 500 if @model.get 'revealingFirstHalf'
    # @$el.children().first().removeClass 'back', 1000 if @model.get 'revealingFirstHalf'
    # @$el.addClass 'reveal-last-half' if @model.get 'revealingLastHalf'
    # console.log(@el.html)
    # debugger
