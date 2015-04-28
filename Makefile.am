EXTRA_DIST = \
	Paper \
	COPYING \
	AUTHORS \
	README.md

xsessiondir = $(datadir)/xsessions

themedir = $(datadir)/icons

install-data-hook:
	$(MKDIR_P) $(DESTDIR)/usr/share/icons
	cp -Rv Paper $(DESTDIR)/usr/share/icons/.

uninstall-hook:
	test -e $(DESTDIR)/usr/share/icons/Paper && rm -rfv $(DESTDIR)/usr/share/icons/Paper
