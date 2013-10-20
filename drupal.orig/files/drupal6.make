;
; Standard makefile for puppet-drupal.

; core
core       = 6.x
;projects[] = drupal

; api
api = 2

; essential
projects[] = views
projects[] = cck

; administration

projects[] = admin
projects[] = rubik
projects[] = tao
projects[] = views_bulk_operations
projects[] = util
projects[] = advanced_help

; development

projects[] = devel
projects[] = coder
projects[] = taxonomy_export
projects[] = variable_dump
projects[] = node_import
projects[] = drupalforfirebug
projects[] = diff

; email
projects[] = simplenews
projects[] = email

; misc
projects[] = activism
projects[] = bueditor
projects[] = dhtml_menu
projects[] = flashnode
projects[] = icecast
projects[] = imagefield
projects[] = markdowneditor
projects[] = notify
projects[] = petition_node
projects[] = swftools
projects[] = taxonomy_menu
projects[] = tribune
projects[] = admin_menu
projects[] = captcha
projects[] = contemplate
projects[] = flashvideo
projects[] = image
projects[] = jquery_ui
projects[] = mm_exif
projects[] = exif
projects[] = og
projects[] = poormanscron
projects[] = sitemenu
projects[] = syndication
projects[] = tinymce
projects[] = advuser
projects[] = captcha_pack
projects[] = ctools
projects[] = fckeditor
projects[] = getid3
projects[] = imageapi
projects[] = lightbox2
projects[] = nice_menus
projects[] = pathauto
projects[] = riddler
projects[] = spam
projects[] = tagadelic
projects[] = token
projects[] = wysiwyg
projects[] = audio
projects[] = casetracker
projects[] = date
projects[] = filefield
projects[] = http_request_fail_reset
projects[] = imagecache
projects[] = link
projects[] = nodeaccess
projects[] = petition
projects[] = shoutbox
projects[] = subscriptions
projects[] = taxonomy_block
projects[] = tooltips
projects[] = accountmenu
projects[] = ajax
projects[] = archive
projects[] = backup_migrate
projects[] = calendar
projects[] = cck_fieldgroup_tabs
projects[] = charts_graphs
projects[] = computed_field
projects[] = conditional_fields
projects[] = context
projects[] = drush_views
projects[] = dynamic_persistent_menu
projects[] = features
projects[] = flag
projects[] = formblock
projects[] = hierarchical_select
projects[] = imagecache_actions
projects[] = jquerymenu
projects[] = location
projects[] = logintoboggan
projects[] = mapstraction
projects[] = menu_per_role
projects[] = nicemap
projects[] = nodemap
projects[] = panels
projects[] = prepopulate
projects[] = profile_location
projects[] = quickmenu
projects[] = quicktabs
projects[] = relevance
projects[] = returnpath
projects[] = rules
projects[] = search_config
projects[] = securepages
projects[] = simplemenu
projects[] = simpletest
projects[] = site_map
projects[] = strongarm
projects[] = swfobject_api
projects[] = tabs
projects[] = taxonomyblocks
projects[] = taxonomy_breadcrumb
projects[] = taxonomy_browser
projects[] = taxonomy_filter
projects[] = taxonomy_treemenu
projects[] = tinytax
projects[] = transliteration
projects[] = umapper
projects[] = unique_field
projects[] = user_import
projects[] = userloginbar
projects[] = user_prune
projects[] = validation_api
projects[] = views_bonus
projects[] = views_calc
projects[] = views_charts
projects[] = views_customfield
projects[] = views_daterange
projects[] = views_groupby
projects[] = views_slideshow
projects[] = l10n_update
projects[] = webform
projects[] = webform_report
projects[] = autoload
projects[] = makemeeting
projects[] = shurly
projects[] = jstimer

; i18n
projects[] = i18n
projects[] = i18nviews
projects[] = tcontact
projects[] = languageicons

; themes
projects[] = framework
projects[] = zen

; tinymce
libraries[tinymce][download][type] = "file"
libraries[tinymce][download][url]  = "http://cloud.github.com/downloads/tinymce/tinymce/tinymce_3_3_9_3.zip"
libraries[tinymce][download][md5]  = "807f12270e605a826f6b9eeece6c724f"

; openlayers
libraries[openlayers][download][type] = "file"
libraries[openlayers][download][url]  = "http://openlayers.org/download/OpenLayers-2.10.tar.gz"
libraries[openlayers][download][md5]  = "4fdb8d5bf731168a65add0fabe9234dd"

; jquery.ui
libraries[jquery.ui][download][type] = "file"
libraries[jquery.ui][download][url]  = "https://jquery-ui.googlecode.com/files/jquery.ui-1.6.zip"
libraries[jquery.ui][download][sha1] = "3057df12b8b43ba62aa64ab4600ba3e17883fe77"

; ckeditor
libraries[ckeditor][download][type] = "file"
libraries[ckeditor][download][url] = "http://download.cksource.com/CKEditor/CKEditor/CKEditor%203.6.2/ckeditor_3.6.2.tar.gz"
libraries[ckeditor][download][md5] = "1c490b050c428e79a1f65ba5459e7ec9"

; other
projects[] = oauth
projects[] = twitter
projects[] = markdown
projects[] = redirect
projects[] = globalredirect
projects[] = path_redirect
projects[] = print
projects[] = demo
projects[] = security_review
projects[] = module_filter
projects[] = permission_select
projects[] = hidden_captcha
projects[] = captcha_pack
