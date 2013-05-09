$ ->

    parse_entry = (entry) ->
        url = $(entry).find('ref')?.attr('href')
        title = $(entry).find('title')?.text()
        abstract = $(entry).find('abstract')?.text()
        duration = $(entry).find('duration')?.attr('value')

        # console.log "Parsing", entry

        if not url
            return false

        return {
            url: url,
            title: title,
            abstract: abstract,
            duration: duration,
        }

    create_player = (url) ->

        audio = document.createElement "audio"

        audio.controls = true

        source = document.createElement "source"
        source.type = 'audio/mp4'
        source.src = url
        source.preload = 'auto'

        audio.appendChild source

        return audio

    selector = "a[href*='codingformat=.m4a'][href*='metafile=asx']"
    links = $ selector

    $(links).click (e) ->

        link_elem = this
        e.preventDefault()

        $.get $(this).attr("href"), (data) ->
            xml = $.parseXML data
            entry = parse_entry $(xml).find('entry:first')

            # console.log "Parsed entry", entry

            if entry?.url
                player = create_player entry.url
                if player

                    # console.log player

                    # player.style.cssText = window.getComputedStyle(link_elem).cssText

                    $(player).css {
                        width: $(link_elem).css('width')
                        height: $(link_elem).css('height')
                        position: $(link_elem).css('position')
                        top: $(link_elem).css('top')
                        right: $(link_elem).css('right')
                        bottom: $(link_elem).css('bottom')
                        left: $(link_elem).css('left')
                        float: $(link_elem).css('float')
                        display: $(link_elem).css('display')
                        margin: $(link_elem).css('margin')
                        padding: $(link_elem).css('padding')
                        color: $(link_elem).css('color')
                        background: $(link_elem).css('background')
                    }

                    $(link_elem).replaceWith player
                    player.play()


        return false


