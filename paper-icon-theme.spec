#
# Spec file for package paper-icon-theme
#
# Copyright (c) 2016 Sam Hewitt
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

Name:           paper-icon-theme
Version:        1.3
Release:        4
License:        CC-BY-SA-4.0
Summary:        Paper Icon theme
Url:            https://snwh.org/paper
Group:          System/GUI/Other
Source:         %{name}-%{version}.tar.xz
BuildRequires:  automake
BuildRequires:  fdupes
BuildRequires:  hicolor-icon-theme
BuildRequires:  icon-naming-utils >= 0.8.7
BuildRoot:      %{_tmppath}/%{name}-%{version}-build
BuildArch:      noarch

%description
Paper is simple and modern icon theme with material design influences.

%prep
%setup -q
find -L . -type l -print -delete
chmod +x autogen.sh
chmod a-x AUTHORS README.md

%build
./autogen.sh
make %{?_smp_mflags}

%install
make install DESTDIR=%{buildroot} %{?_smp_mflags}
rm -f %{buildroot}%{_datadir}/icons/Paper/AUTHORS
%fdupes %{buildroot}%{_datadir}/icons/Paper

%post
%icon_theme_cache_post Paper

%files
%defattr(-,root,root)
%doc AUTHORS COPYING LICENSE README.md
%{_datadir}/icons/Paper
%ghost %{_datadir}/icons/Paper/icon-theme.cache
