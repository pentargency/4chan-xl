CatalogLinks =
  init: ->
    return unless Conf['Catalog Links']
    CatalogLinks.el = el = UI.checkbox 'Header catalog links', ' Catalog Links'
    el.id = 'toggleCatalog'

    input = $ 'input', el
    $.on input, 'change', @toggle
    $.sync 'Header catalog links', CatalogLinks.set

    Header.menu.addEntry
      el:    el
      order: 95

  # Set links on load or custom board list change.
  # Called by Header when both board lists (header and footer) are ready.
  initBoardList: ->
    return unless Conf['Catalog Links']
    CatalogLinks.set Conf['Header catalog links']

  toggle: ->
    $.event 'CloseMenu'
    $.set 'Header catalog links', @checked
    CatalogLinks.set @checked

  set: (useCatalog) ->
    path = if useCatalog
      if Conf['JSON Navigation'] and Conf['Use 4chan X Catalog'] then '#catalog' else 'catalog'
    else
      ''

    generateURL = if useCatalog and Conf['External Catalog']
      CatalogLinks.external
    else
      (board) -> a.href = "/#{board}/#{path}"

    for a in $$ """#board-list a:not([data-only]), #boardNavDesktopFoot a"""
      continue if a.hostname not in ['boards.4chan.org', 'catalog.neet.tv', '4index.gropes.us'] or
      !(board = a.pathname.split('/')[1]) or
      board in ['f', 'status', '4chan'] or
      $.hasClass a, 'external'

      # Href is easier than pathname because then we don't have
      # conditions where External Catalog has been disabled between switches.
      a.href = generateURL board

    CatalogLinks.el.title = "Turn catalog links #{if useCatalog then 'off' else 'on'}."

  external: (board) ->
    if board in ['a', 'c', 'g', 'biz', 'k', 'm', 'o', 'p', 'v', 'vg', 'vr', 'w', 'wg', 'cm', '3', 'adv', 'an', 'asp', 'cgl', 'ck', 'co', 'diy', 'fa', 'fit', 'gd', 'int', 'jp', 'lit', 'mlp', 'mu', 'n', 'out', 'po', 'sci', 'sp', 'tg', 'toy', 'trv', 'tv', 'vp', 'wsg', 'x', 'f', 'pol', 's4s', 'lgbt']
      "http://catalog.neet.tv/#{board}"
    else
      "/#{board}/catalog"
