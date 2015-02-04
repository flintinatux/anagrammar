@app = {}

@vm = {}

anagram = (string) ->
  @letters _.countBy _.sortBy string.replace(/\s+/,'').toUpperCase()
  @value string

Attempt = ->
  a = {}
  a.anagram = anagram.bind a
  a.letters = m.prop {}
  a.value   = m.prop ''
  a

vm.init = ->
  vm.anagram  = anagram.bind vm
  vm.attempts = [ new Attempt ]
  vm.letters  = m.prop {}
  vm.value    = m.prop ''
  vm.anagram 'parliament'
  vm

app.controller = ->
  vm.init()

app.view = (vm) ->
  [
    m '.header', [
      m 'h1.title', 'Anagrammar'
      m 'p.description', 'a visual anagram tool'
    ]

    m 'input.anagram[placeholder="Enter the original anagram letter-set here..."]', oninput: m.withAttr('value', vm.anagram), value: vm.value()

    m 'h2.subtitle', 'Attempts'

    vm.attempts.map (a, index) ->
      letters = _.uniq _.keys(vm.letters()).concat _.keys(a.letters())

      [
        m "input.attempt[placeholder='Attempt ##{index+1}']", oninput: m.withAttr('value', a.anagram), value: a.value()

        m '.letters', _.map letters, (letter) ->
          total   = vm.letters()[letter] || 0
          used    = a.letters()[letter]  || 0
          valid   = if used > total then total else used
          unused  = total - used
          invalid = if unused < 0 then -unused else 0

          [
            _.times valid,   -> m 'span.letter.valid',   letter
            _.times unused,  -> m 'span.letter.unused',  letter
            _.times invalid, -> m 'span.letter.invalid', letter
          ]
      ]
  ]

m.module document.body, app
