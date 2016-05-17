Name:       paper-icon-theme
Summary:    Paper Icons
Version:    1.3
Group:      System/GUI/Other
License:    CC-BY-SA-4.0
Url:        http://snwh.org/paper/icons

%global commit0 40-CHARACTER-HASH-VALUE

Release:	.git%{commit0}
Source0:    https://github.com/snwh/%{name}/archive/%{commit0}.tar.gz

BuildArch:  noarch
Requires:   hicolor-icon-theme, gnome-icon-theme

%description
Paper Icon Theme

%prep
%setup -qn %{name}-%{commit0}

# Delete dead icon symlinks
find -L . -type l -delete

%build

%install
install -dpm 0755 $RPM_BUILD_ROOT%{_datadir}/icons/
cp -a Paper/ $RPM_BUILD_ROOT%{_datadir}/icons/

%files
%doc AUTHORS COPYING
%{_datadir}/icons/Paper/

