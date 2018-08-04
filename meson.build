project('paper-icon-theme',
    version: '1.5',
    meson_version: '>= 0.40',
    license: 'CC-by-SA',
    default_options: ['prefix=/usr']
)

install_subdir('Paper',
    install_dir: join_paths(get_option('prefix'), 'share/icons')
)

install_subdir('Paper-Mono-Dark',
    install_dir: join_paths(get_option('prefix'), 'share/icons')
)

meson.add_install_script('meson/post_install.py')
