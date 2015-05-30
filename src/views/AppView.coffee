class window.AppView extends Backbone.View
  template: _.template '<div class="game-bar"> \
                          <button class="hit-button btn">Hit</button> \
                          <button class="stand-button btn">Stand</button> \
                          <div class="player-losses"> <%= losses %> </div> \
                          <div class="player-wins"> <%= wins %> </div> \
                          <div class="player-chips"> <img src = "./img/chips.png" width="64px"> <span class="chip-count"><%= chips %></span></div> \
                        </div>
                        <div class="playingCards fourColours rotateHand player-hand-container "></div> \
                        <div class="playingCards fourColors rotateHand dealer-hand-container" style="clear:both"></div>'
  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'change': -> @render()

  initialize: ->
    @render()
    @model.get('playerHand').on 'stand', @playerStand, @
    # @model.get('playerHand').on 'newHand', @render, @
    @listenTo(@model, 'newHand', @render)

  playerStand: (event, hand) ->
    $('.btn').prop("disabled", true)

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el


