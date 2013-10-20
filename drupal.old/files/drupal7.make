;
; Standard makefile for puppet-drupal.
;

; core
core       = 7.x
;projects[] = drupal

; api
api = 2

; essential
projects[] = views
projects[] = ctools
projects[] = features
projects[] = strongarm
projects[] = feeds

; administration
projects[] = admin
projects[] = rubik
projects[] = tao
projects[] = advanced_help
projects[] = l10n_update

; development
projects[] = devel
projects[] = coder

; email
projects[] = simplenews

; mapping
projects[] = openlayers
projects[] = panels

; openlayers
libraries[openlayers][download][type] = "file"
libraries[openlayers][download][url] = "http://openlayers.org/download/OpenLayers-2.10.tar.gz"
libraries[openlayers][download][md5] = "4fdb8d5bf731168a65add0fabe9234dd"

; tinymce
libraries[tinymce][download][type] = "file"
libraries[tinymce][download][url]  = "http://cloud.github.com/downloads/tinymce/tinymce/tinymce_3_3_9_3.zip"
libraries[tinymce][download][md5]  = "807f12270e605a826f6b9eeece6c724f"

; jquery.ui
libraries[jquery.ui][download][type] = "file"
libraries[jquery.ui][download][url]  = "https://jquery-ui.googlecode.com/files/jquery.ui-1.6.zip"
libraries[jquery.ui][download][sha1] = "3057df12b8b43ba62aa64ab4600ba3e17883fe77"

; ckeditor
libraries[ckeditor][download][type] = "file"
libraries[ckeditor][download][url] = "http://download.cksource.com/CKEditor/CKEditor/CKEditor%203.6.2/ckeditor_3.6.2.tar.gz"
libraries[ckeditor][download][md5] = "1c490b050c428e79a1f65ba5459e7ec9"

; jquery cycle
libraries[jquery.cycle][download][type] = "file"
libraries[jquery.cycle][download][url] = "http://malsup.github.com/jquery.cycle.all.js"
libraries[jquery.cycle][download][md5] = "1afbc5e61bf421dd381c7e76496db89c"

; seo
projects[] = pathauto
projects[] = transliteration
projects[] = redirect
projects[] = globalredirect
projects[] = pathologic
projects[] = subpathauto

; other
projects[captcha][version] = 1.0-beta2
projects[signup][version] = 1.x-dev
projects[subscriptions][version] = 1.0-beta3
projects[web_widgets][version] = 1.x-dev
projects[timeline][version] = 3.x-dev
projects[] = logintoboggan
projects[] = wysiwyg
projects[] = calendar
projects[] = token
projects[] = insert
projects[] = custom_search
projects[] = webform
projects[] = shurly
projects[] = views_slideshow
projects[] = libraries
projects[] = jstimer
projects[] = oauth
projects[] = twitter
projects[] = page_theme
projects[] = link
projects[] = field_group
projects[] = email
projects[] = date_ical
projects[] = mail_edit
projects[] = tagclouds
projects[] = variable
projects[] = languageicons
projects[] = i18n
projects[] = markdown
projects[] = markdowneditor
projects[] = print
projects[] = entity
projects[] = views_php
projects[] = demo
projects[] = security_review
projects[] = module_filter
projects[] = permission_select
projects[] = hidden_captcha
projects[] = captcha_pack
