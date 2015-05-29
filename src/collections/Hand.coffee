class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    initialScore = 0
    i = 0

    while i < array.length
      initialScore += array[i].get("value")  if array[i].get("rankName") isnt "Ace"
      initialScore += 11  if array[i].get("rankName") is "Ace"
      i++
    alert "PLAYER BLACKJACK :)"  if initialScore is 21 and !@isDealer
    alert "DEALER BLACKJACK :(" if initialScore is 21 and @isDealer

  hit: ->
    @add(@deck.pop())

    if @scores()[0] is 21 or @scores()[1] is 21 then alert("21, recommended you stay unless you like losing money!") # 21 case
    if @scores()[0] >= 21 then alert("BUSTED :(")

  stand: ->
    console.log("Player standing.");

  play: -> # Only for dealer
    @.at(0).flip()
    while @scores()[0] < 17 or @scores()[1] < 17
      @hit()

  hasAce: ->
    filtered = undefined
    counter = 0
    filtered = @filter (card) ->
      if card.get('rankName') == 'Ace'
        counter++
      card.get('rankName') == 'Ace'
    counter

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]


