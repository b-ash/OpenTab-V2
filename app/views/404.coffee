View = require './view'

class FourOhFourView extends View
    el: '.main-page'
    template: require './templates/404'

    initialize: =>
        @render()


module.exports = FourOhFourView
