class window.Card extends Backbone.Model
  initialize: (params) ->
    @set
      revealed: true
      revealingFirstHalf: false
      revealingSecondHalf: false
      value: if !params.rank or 10 < params.rank then 10 else params.rank
      suitName: ['spades', 'diams', 'clubs', 'hearts'][params.suit]
      # suitName: ['Spades', 'Diamonds', 'Clubs', 'Hearts'][params.suit]
      rankName: switch params.rank
        # when 0 then 'King'
        # when 1 then 'Ace'
        # when 11 then 'Jack'
        # when 12 then 'Queen'
        when 0 then 'k'
        when 1 then 'a'
        when 11 then 'j'
        when 12 then 'q'
        else params.rank

  flip: ->
    @set 'revealed', !@get 'revealed'
    @

