class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    initialScore = 0
    i = 0

    while i < array.length
      initialScore += array[i].get("value")  if array[i].get("rankName") isnt "a"
      initialScore += 11  if array[i].get("rankName") is "a"
      i++
    console.log("PLAYER BLACKJACK :)")  if initialScore is 21 and !@isDealer
    console.log("DEALER BLACKJACK :(") if initialScore is 21 and @isDealer

  hit: ->
    @add(@deck.pop())

    if @scores()[0] is 21 or @scores()[1] is 21 then alert("21, recommended you stay unless you like losing money!") # 21 case
    if @scores()[0] > 21
      console.log("BUSTED :(")
      # location.reload()

  stand: ->
    console.log("Player standing.");

  play: -> # Only for dealer
    @.at(0).flip()

    # $(".card").addClass "reveal", 5000, (->
    #   console.log('callback')
    #   @playHand()).bind(this)
    console.log('hello?')
    console.log(this.at(0))
    $(".card").addClass "reveal"

    # context = this

    # setTimeout context.playHand
    #   ,2000

    setTimeout (->
      this.playHand()).bind(this)
      ,2000

    # $(".card").addClass
    #   'reveal'
    # , 2000, (->
    #   @playHand()).bind(this)


    # result.pause = (->
    #   cachedValue = this()
    #   isPaused true)
    # .bind(result)

  playHand: ->
    console.log('playHand ran')
    while @scores()[0] < 17 or @scores()[1] < 17
      @hit()
      #setTimeout(@playHand.bind(this), 20000)

  hasAce: ->
    filtered = undefined
    counter = 0
    filtered = @filter (card) ->
      if card.get('rankName') == 'a'
        counter++
      card.get('rankName') == 'a'
    counter

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an a, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  bestScore: ->
    bestScoreTotal = 0
    bestScoreTotal = @scores()[0]
    if (@scores()[1] > bestScoreTotal) and (@scores()[1] <= 21) then bestScoreTotal = @scores()[1]
    return bestScoreTotal

  hasBusted: ->
    if @bestScore() > 21 then return true
    else return false
