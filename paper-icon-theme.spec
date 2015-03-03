# Spec file for package paper-icon-theme
#
# Copyright (c) 2014 Sam Hewitt <hewittsamuel@gmail.com>
#
# All modifications and additions to the file contributed by third parties
# remain the property of their copyright owners, unless otherwise agreed
# upon. The license for this file, and modifications and additions to the
# file, is the same license as for the pristine package itself (unless the
# license for the pristine package is not an Open Source License, in which
# case the license is the MIT License). An "Open Source License" is a
# license that conforms to the Open Source Definition (Version 1.9)
# published by the Open Source Initiative.
#


Name:		paper-icon-theme
Version:	1.0
Release:	0

Summary:	Paper Icon theme
Group:		System/GUI/Other
License:    CC-BY-SA-4.0
Group:      System/GUI/GNOME
Url:        http://snwh.org/paper-icon-theme
Source0:	%{name}-%{version}.tar.gz
Requires:	hicolor-icon-theme, gnome-icon-theme
BuildArch:	noarch


%description
Paper Icon Theme

%prep
%setup -q

# Delete dead icon symlinks
find -L . -type l -delete

%build

%install
install -dpm 0755 $RPM_BUILD_ROOT%{_datadir}/icons/
cp -a Paper/ $RPM_BUILD_ROOT%{_datadir}/icons/

%files
%doc AUTHORS LICENSE
%{_datadir}/icons/Paper/
