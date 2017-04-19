EXTRA_DIST = \
	Paper \
	Paper-Mono-Dark \
	COPYING \
	AUTHORS \
	README.md

themedir = $(datadir)/icons

install-data-hook:
	$(MKDIR_P) $(DESTDIR)$(datadir)/icons
	cp -Rv Paper $(DESTDIR)$(datadir)/icons/.
	cp -Rv Paper-Mono-Dark $(DESTDIR)$(datadir)/icons/.

uninstall-hook:
	test -e $(DESTDIR)$(datadir)/icons/Paper && rm -rfv $(DESTDIR)$(datadir)/icons/Paper
	test -e $(DESTDIR)$(datadir)/icons/Paper-Mono-Dark && rm -rfv $(DESTDIR)$(datadir)/icons/Paper-Mono-Dark
