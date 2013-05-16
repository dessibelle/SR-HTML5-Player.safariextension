(function() {
  $(function() {
    var create_player, links, parse_entry, processedClass, selector;

    processedClass = 'sr-player-processed';
    parse_entry = function(entry) {
      var abstract, duration, title, url, _ref, _ref1, _ref2, _ref3;

      url = (_ref = $(entry).find('ref')) != null ? _ref.attr('href') : void 0;
      title = (_ref1 = $(entry).find('title')) != null ? _ref1.text() : void 0;
      abstract = (_ref2 = $(entry).find('abstract')) != null ? _ref2.text() : void 0;
      duration = (_ref3 = $(entry).find('duration')) != null ? _ref3.attr('value') : void 0;
      if (!url) {
        return false;
      }
      return {
        url: url,
        title: title,
        abstract: abstract,
        duration: duration
      };
    };
    create_player = function(url) {
      var audio, source;

      audio = document.createElement("audio");
      audio.controls = true;
      source = document.createElement("source");
      source.type = 'audio/mp4';
      source.src = url;
      source.preload = 'auto';
      audio.appendChild(source);
      return audio;
    };
    selector = "a[href*='codingformat=.m4a'][href*='metafile=asx']:not(" + processedClass + ")";
    links = $(selector);
    return $(links).click(function(e) {
      var link_elem;

      link_elem = this;
      e.preventDefault();
      $.get($(this).attr("href"), function(data) {
        var css_props, entry, inner, player, xml;

        xml = $.parseXML(data);
        entry = parse_entry($(xml).find('entry:first'));
        if (entry != null ? entry.url : void 0) {
          player = create_player(entry.url);
          if (player) {
            $.each($('audio'), function() {
              return this.pause();
            });
            css_props = {
              width: $(link_elem).css('width'),
              height: $(link_elem).css('height'),
              position: $(link_elem).css('position'),
              top: $(link_elem).css('top'),
              right: $(link_elem).css('right'),
              bottom: $(link_elem).css('bottom'),
              left: $(link_elem).css('left'),
              float: $(link_elem).css('float'),
              display: $(link_elem).css('display'),
              margin: $(link_elem).css('margin')
            };
            $(link_elem).wrap('<span class="sr-player-wrapper" />');
            $(link_elem).wrap('<span class="sr-player-inner" />');
            $(link_elem).addClass(processedClass);
            inner = $(link_elem).parent();
            $(inner).css(css_props);
            $(inner).append(player);
            $(player).css({
              width: $(link_elem).css('width'),
              height: $(link_elem).css('height'),
              margin: $(link_elem).css('margin'),
              padding: $(link_elem).css('padding')
            });
            return player.play();
          }
        }
      });
      return false;
    });
  });

}).call(this);
