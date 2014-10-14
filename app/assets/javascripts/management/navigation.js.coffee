$ ->
        $('#side-menu').metisMenu();

$ ->
        $(window).bind "load resize", ->
                topOffset = 50
                width = if this.window.innerWidth > 0
                        this.window.innerWidth
                else
                        this.screen.width

                if width < 768
                        $('.collapsable').addClass 'collapse'
                        topOffset = 100
                else
                        $('.collapsable').removeClass 'collapse'

                height = if this.window.innerHeight > 0 ?
                        this.window.innerHeight
                else
                        this.screen.height

                height = height - topOffset

                if height < 1
                        height = 1

                if height > topOffset
                        $("#page-wrapper").css("min-height", (height) + "px")
