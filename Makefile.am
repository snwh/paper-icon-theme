EXTRA_DIST = \
	Paper \
	Paper-Mono-Dark \
	COPYING \
	AUTHORS \
	README.md

themedir = $(datadir)/icons

install-data-hook:
	$(MKDIR_P) $(DESTDIR)/usr/share/icons
	cp -Rv Paper $(DESTDIR)/usr/share/icons/.
	cp -Rv Paper-Mono-Dark $(DESTDIR)/usr/share/icons/.

uninstall-hook:
	test -e $(DESTDIR)/usr/share/icons/Paper && rm -rfv $(DESTDIR)/usr/share/icons/Paper
	test -e $(DESTDIR)/usr/share/icons/Paper-Mono-Dark && rm -rfv $(DESTDIR)/usr/share/icons/Paper-Mono-Dark
