class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container playingCards fourColours rotateHand"></div>
    <div class="dealer-hand-container playingCards fourColors rotateHand" style="clear:both"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @playRound()

  playRound: ->
    @model.get('playerHand').stand()
    @model.get('dealerHand').play()
    # Compare results and announce winner
    playerScore = @model.get('playerHand').bestScore()
    dealerScore = @model.get('dealerHand').bestScore()
    if(playerScore == dealerScore) then console.log("TIE!")
    if(playerScore > dealerScore) then console.log("Player Wins :)")
    if(dealerScore > playerScore) then console.log("Dealer Wins :(")

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el


