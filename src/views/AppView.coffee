class window.AppView extends Backbone.View
  template: _.template '<div class="game-bar"> \
                          <button class="hit-button btn">Hit</button> \
                          <button class="stand-button btn">Stand</button> \
                          <div class="player-wins"> \
                            <span class="win-box"> \
                              Wins: 2 \
                            </span> \
                          </div> \
                          <div class="player-losses"> \
                            <span class="loss-box"> \
                               Losses: 3 \
                            </span> \
                          </div> \
                        </div>
                          <div class="playingCards fourColours rotateHand player-hand-container "></div> \
                          <div class="playingCards fourColors rotateHand dealer-hand-container" style="clear:both"></div>'
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


