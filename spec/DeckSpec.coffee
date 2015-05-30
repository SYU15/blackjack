assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      # debugger
      # console.log(deck.length)
      assert.strictEqual deck.length, 50
      # lastCard = deck.last()
      # hitCard = hand.hit()
      # assert.strictEqual deck.last(), hand.hit()
      hand.hit() #whatever
      console.log(deck.length)
      assert.strictEqual deck.length, 49

  describe 'bust', ->
    it 'should bust if over 21', ->
      hand.hit()
      hand.hit()
      hand.hit()
      hand.hit()
      hand.hit()
      hand.hit()
      hand.hit()
      hand.hit()
      hand.hit()
      hand.hit()
      hand.hit()
      assert.strictEqual hand.hasBusted(), true
    it 'should not bust if staying', ->
      assert.strictEqual hand.hasBusted(), false
