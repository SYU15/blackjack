# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @newHand()

  defaults:
    wins: 0
    losses: 0
    chips: 1000

  playerEvents: (event, hand) ->
    switch event
      when 'bust' then @dealerWins()
      when 'stand' then @get('dealerHand').play()

  dealerEvents: (event, hand) ->
    switch event
      when 'bust' then @playerWins()
      when 'stand' then @compareScore()

  compareScore: ->
    playerScore = @get('playerHand').bestScore()
    dealerScore = @get('dealerHand').bestScore()
    playerBlackjack = @get('playerHand').hasBlackjack()
    dealerBlackjack = @get('dealerHand').hasBlackjack()

    console.log("Player Blackjack:", playerBlackjack);
    console.log("Dealer Blackjack:", dealerBlackjack);

    if(playerBlackjack && !dealerBlackjack)
      alert("Player blackjack!")
      @playerWins()
    else if(!playerBlackjack && dealerBlackjack)
      alert("Dealer blackjack!")
      @dealerWins()
    else if(playerBlackjack && dealerBlackjack)
      alert("What kinda luck! You both have blackjacks!")
      @newHand()

    else if(playerScore == dealerScore)
      alert("TIE!")
      @newHand()
    else if(playerScore > dealerScore) then @playerWins()
    else if(dealerScore > playerScore) then @dealerWins()

  playerWins: ->
    alert("Player Wins :)")
    @set('wins', @get('wins')+1)
    console.log("Wins:", @get('wins'))

    playerBlackjack = @get('playerHand').hasBlackjack()

    if(playerBlackjack) then @set 'chips', @get('chips') + ( @get('currentBet') * 2 )
    else @set 'chips', @get('chips') + @get('currentBet')

    @newHand()

  dealerWins: ->
    alert("Dealer Wins :(")
    @set('losses', @get('losses')+1)
    console.log("Losses:", @get('losses'))
    @set 'chips', @get('chips') - @get('currentBet')
    @newHand()

  newHand: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'all', @playerEvents, @
    @get('dealerHand').on 'all', @dealerEvents, @
    @set 'currentBet', parseInt(prompt('How much would you like to bet?')) || 0

    @trigger 'newHand', @
