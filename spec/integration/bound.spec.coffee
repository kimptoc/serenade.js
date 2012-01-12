{Serenade} = require '../../src/serenade'

describe 'Bound attributes and text nodes', ->
  beforeEach ->
    @setupDom()

  it 'does not add bound attribute if value is undefined in model', ->
    model = { name: 'jonas' }
    @render 'div[id=foo]', model
    expect(@body.find('div')).not.toHaveAttribute('id')

  it 'get bound attributes from the model', ->
    model = { name: 'jonas' }
    @render 'div[id=name]', model
    expect(@body).toHaveElement('div#jonas')

  it 'get bound text from the model', ->
    model = { name: 'Jonas Nicklas' }
    @render 'div name', model
    expect(@body.find('div')).toHaveText('Jonas Nicklas')

  it 'changes bound attributes as they are changed', ->
    model = new Serenade.Model
    model.set('name', 'jonas')
    @render 'div[id=name]', model
    expect(@body).toHaveElement('div#jonas')
    model.set('name', 'peter')
    expect(@body).toHaveElement('div#peter')

  it 'removes attributes and reattaches them as they are set to undefined', ->
    model = new Serenade.Model
    model.set('name', 'jonas')
    @render 'div[id=name]', model
    expect(@body).toHaveElement('div#jonas')
    model.set('name', undefined)
    expect(@body.find('div')).not.toHaveAttribute('id')
    model.set('name', 'peter')
    expect(@body).toHaveElement('div#peter')

  it 'handles value specially', ->
    model = new Serenade.Model
    model.set('name', 'jonas')
    @render 'input[value=name]', model
    @body.find('input').val('changed')
    model.set('name', 'peter')
    expect(@body.find('input').val()).toEqual('peter')

  it 'changes bound text nodes as they are changed', ->
    model = new Serenade.Model
    model.set('name', 'Jonas Nicklas')
    @render 'div name', model
    expect(@body.find('div')).toHaveText('Jonas Nicklas')
    model.set('name', 'Peter Pan')
    expect(@body.find('div')).toHaveText('Peter Pan')
